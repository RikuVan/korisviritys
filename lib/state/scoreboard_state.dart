import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

enum Possession { none, home, away }

class _StateSnapshot {
  final int homeScore;
  final int awayScore;
  final int homeFouls;
  final int awayFouls;
  final int period;
  final Possession possession;
  final Duration timeLeft;
  final Duration initialTime;
  final Duration accumulatedTime;

  _StateSnapshot({
    required this.homeScore,
    required this.awayScore,
    required this.homeFouls,
    required this.awayFouls,
    required this.period,
    required this.possession,
    required this.timeLeft,
    required this.initialTime,
    required this.accumulatedTime,
  });
}

class ScoreboardState extends ChangeNotifier {
  static const Duration defaultQuarterLength = Duration(minutes: 10);
  static const int _maxUndoHistory = 30;

  // Undo
  final List<_StateSnapshot> _undoStack = [];

  // Game state
  Duration _timeLeft = defaultQuarterLength;
  Duration _initialTime = defaultQuarterLength;
  Duration _accumulatedTime = Duration.zero;
  int _homeScore = 0;
  int _awayScore = 0;
  int _homeFouls = 0;
  int _awayFouls = 0;
  int _period = 1;
  Possession _possession = Possession.none;

  // Team info
  String _homeTeamName = 'KOTI';
  String _awayTeamName = 'VIERAS';
  Color _homeTeamColor = Colors.white;
  Color _awayTeamColor = Colors.white;

  // Game clock
  late Ticker _ticker;
  DateTime? _startTime;

  // Timeout
  bool _isTimeout = false;
  String _timeoutLabel = '';
  Duration _timeoutLeft = Duration.zero;
  Duration _timeoutDuration = const Duration(seconds: 60);
  Timer? _timeoutTimer;
  DateTime? _timeoutStartTime;

  // Buzzer
  bool _buzzerActive = false;
  final AudioPlayer _buzzerPlayer = AudioPlayer();

  ScoreboardState() {
    _ticker = Ticker(_onTick);
  }

  @override
  void dispose() {
    _ticker.dispose();
    _timeoutTimer?.cancel();
    _buzzerPlayer.dispose();
    super.dispose();
  }

  // --- Getters ---

  Duration get timeLeft => _timeLeft;
  int get minutes => _timeLeft.inMinutes;
  int get seconds => _timeLeft.inSeconds % 60;
  int get homeScore => _homeScore;
  int get awayScore => _awayScore;
  int get homeFouls => _homeFouls;
  int get awayFouls => _awayFouls;
  int get period => _period;
  Possession get possession => _possession;
  bool get isRunning => _ticker.isActive;
  String get homeTeamName => _homeTeamName;
  String get awayTeamName => _awayTeamName;
  Color get homeTeamColor => _homeTeamColor;
  Color get awayTeamColor => _awayTeamColor;
  bool get isTimeout => _isTimeout;
  String get timeoutLabel => _timeoutLabel;
  int get timeoutSeconds => _timeoutLeft.inSeconds;
  bool get buzzerActive => _buzzerActive;
  bool get canUndo => _undoStack.isNotEmpty;

  // --- Undo ---

  void _saveSnapshot() {
    _undoStack.add(
      _StateSnapshot(
        homeScore: _homeScore,
        awayScore: _awayScore,
        homeFouls: _homeFouls,
        awayFouls: _awayFouls,
        period: _period,
        possession: _possession,
        timeLeft: _timeLeft,
        initialTime: _initialTime,
        accumulatedTime: _accumulatedTime,
      ),
    );
    if (_undoStack.length > _maxUndoHistory) {
      _undoStack.removeAt(0);
    }
  }

  void undo() {
    if (_undoStack.isEmpty) return;
    final snapshot = _undoStack.removeLast();
    stopTimer();
    _homeScore = snapshot.homeScore;
    _awayScore = snapshot.awayScore;
    _homeFouls = snapshot.homeFouls;
    _awayFouls = snapshot.awayFouls;
    _period = snapshot.period;
    _possession = snapshot.possession;
    _timeLeft = snapshot.timeLeft;
    _initialTime = snapshot.initialTime;
    _accumulatedTime = snapshot.accumulatedTime;
    notifyListeners();
  }

  // --- Game Clock ---

  void _onTick(Duration elapsed) {
    if (_startTime == null) return;
    final totalElapsed =
        _accumulatedTime + DateTime.now().difference(_startTime!);
    final newTimeLeft = _initialTime - totalElapsed;

    if (newTimeLeft <= Duration.zero) {
      _timeLeft = Duration.zero;
      stopTimer();
      triggerBuzzer();
    } else {
      _timeLeft = newTimeLeft;
    }
    notifyListeners();
  }

  void toggleTimer() {
    if (_ticker.isActive) {
      stopTimer();
    } else {
      startTimer();
    }
  }

  void startTimer() {
    if (_timeLeft > Duration.zero) {
      _startTime = DateTime.now();
      _ticker.start();
      notifyListeners();
    }
  }

  void stopTimer() {
    if (_ticker.isActive) {
      _ticker.stop();
      if (_startTime != null) {
        _accumulatedTime += DateTime.now().difference(_startTime!);
        _startTime = null;
      }
      notifyListeners();
    }
  }

  void adjustTime({int minutes = 0, int seconds = 0}) {
    _saveSnapshot();
    if (_ticker.isActive) stopTimer();

    final newTime = (_timeLeft + Duration(minutes: minutes, seconds: seconds));
    _timeLeft = newTime < Duration.zero ? Duration.zero : newTime;
    _initialTime = _timeLeft;
    _accumulatedTime = Duration.zero;
    notifyListeners();
  }

  // --- Score ---

  void adjustScore({required bool isHome, int amount = 1}) {
    _saveSnapshot();
    if (isHome) {
      _homeScore = (_homeScore + amount).clamp(0, 199);
    } else {
      _awayScore = (_awayScore + amount).clamp(0, 199);
    }
    notifyListeners();
  }

  // --- Fouls ---

  void adjustFouls({required bool isHome, int amount = 1}) {
    _saveSnapshot();
    if (isHome) {
      _homeFouls = (_homeFouls + amount).clamp(0, 99);
    } else {
      _awayFouls = (_awayFouls + amount).clamp(0, 99);
    }
    notifyListeners();
  }

  // --- Period ---

  void setPeriod(int period) {
    _saveSnapshot();
    stopTimer();
    _period = period;
    _timeLeft = defaultQuarterLength;
    _initialTime = defaultQuarterLength;
    _accumulatedTime = Duration.zero;
    _homeFouls = 0;
    _awayFouls = 0;
    notifyListeners();
  }

  // --- Possession ---

  void togglePossession() {
    _saveSnapshot();
    if (_possession == Possession.none) {
      _possession = Possession.home;
    } else if (_possession == Possession.home) {
      _possession = Possession.away;
    } else {
      _possession = Possession.home;
    }
    notifyListeners();
  }

  // --- Timeout ---

  void startTimeout(String label, Duration duration) {
    stopTimer();
    cancelTimeout();
    _isTimeout = true;
    _timeoutLabel = label;
    _timeoutDuration = duration;
    _timeoutLeft = duration;
    _timeoutStartTime = DateTime.now();
    _timeoutTimer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      if (_timeoutStartTime == null) return;
      final remaining =
          _timeoutDuration - DateTime.now().difference(_timeoutStartTime!);
      if (remaining <= Duration.zero) {
        _timeoutLeft = Duration.zero;
        cancelTimeout();
        triggerBuzzer();
      } else {
        _timeoutLeft = remaining;
      }
      notifyListeners();
    });
    notifyListeners();
  }

  void cancelTimeout() {
    _isTimeout = false;
    _timeoutLabel = '';
    _timeoutLeft = Duration.zero;
    _timeoutTimer?.cancel();
    _timeoutTimer = null;
    _timeoutStartTime = null;
    notifyListeners();
  }

  // --- Buzzer ---

  void triggerBuzzer() async {
    _buzzerActive = true;
    notifyListeners();
    await _buzzerPlayer.stop();
    await _buzzerPlayer.play(AssetSource('sounds/buzzer.mp3'));
    Future.delayed(const Duration(milliseconds: 1500), () {
      _buzzerActive = false;
      notifyListeners();
    });
  }

  // --- Team Setup ---

  void setTeamInfo({
    required String homeName,
    required String awayName,
    required Color homeColor,
    required Color awayColor,
  }) {
    _homeTeamName = homeName.toUpperCase();
    _awayTeamName = awayName.toUpperCase();
    _homeTeamColor = homeColor;
    _awayTeamColor = awayColor;
    notifyListeners();
  }

  // --- Reset ---

  void resetGame() {
    stopTimer();
    _undoStack.clear();
    _timeLeft = defaultQuarterLength;
    _initialTime = defaultQuarterLength;
    _accumulatedTime = Duration.zero;
    _homeScore = 0;
    _awayScore = 0;
    _homeFouls = 0;
    _awayFouls = 0;
    _period = 1;
    _possession = Possession.none;
    _homeTeamName = 'KOTI';
    _awayTeamName = 'VIERAS';
    _homeTeamColor = Colors.white;
    _awayTeamColor = Colors.white;
    notifyListeners();
  }
}
