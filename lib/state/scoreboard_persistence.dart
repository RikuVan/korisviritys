import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'scoreboard_state.dart';

class ScoreboardPersistence {
  static const _prefix = 'sb_';

  static Future<void> save(ScoreboardState state, {required bool isRunning}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('${_prefix}homeScore', state.homeScore);
    await prefs.setInt('${_prefix}awayScore', state.awayScore);
    await prefs.setInt('${_prefix}homeFouls', state.homeFouls);
    await prefs.setInt('${_prefix}awayFouls', state.awayFouls);
    await prefs.setInt('${_prefix}period', state.period);
    await prefs.setInt('${_prefix}possession', state.possession.index);
    await prefs.setString('${_prefix}homeTeamName', state.homeTeamName);
    await prefs.setString('${_prefix}awayTeamName', state.awayTeamName);
    await prefs.setInt('${_prefix}homeTeamColor', state.homeTeamColor.toARGB32());
    await prefs.setInt('${_prefix}awayTeamColor', state.awayTeamColor.toARGB32());
    await prefs.setInt('${_prefix}timeLeftMs', state.timeLeft.inMilliseconds);
    await prefs.setBool('${_prefix}wasRunning', isRunning);
    await prefs.setInt('${_prefix}savedAt', DateTime.now().millisecondsSinceEpoch);
  }

  static Future<SavedState?> load() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('${_prefix}homeScore')) return null;

    return SavedState(
      homeScore: prefs.getInt('${_prefix}homeScore') ?? 0,
      awayScore: prefs.getInt('${_prefix}awayScore') ?? 0,
      homeFouls: prefs.getInt('${_prefix}homeFouls') ?? 0,
      awayFouls: prefs.getInt('${_prefix}awayFouls') ?? 0,
      period: prefs.getInt('${_prefix}period') ?? 1,
      possession: Possession.values[prefs.getInt('${_prefix}possession') ?? 0],
      homeTeamName: prefs.getString('${_prefix}homeTeamName') ?? 'KOTI',
      awayTeamName: prefs.getString('${_prefix}awayTeamName') ?? 'VIERAS',
      homeTeamColor: Color(prefs.getInt('${_prefix}homeTeamColor') ?? Colors.white.toARGB32()),
      awayTeamColor: Color(prefs.getInt('${_prefix}awayTeamColor') ?? Colors.white.toARGB32()),
      timeLeftMs: prefs.getInt('${_prefix}timeLeftMs') ?? ScoreboardState.defaultQuarterLength.inMilliseconds,
      wasRunning: prefs.getBool('${_prefix}wasRunning') ?? false,
      savedAt: prefs.getInt('${_prefix}savedAt'),
    );
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys().where((k) => k.startsWith(_prefix));
    for (final key in keys) {
      await prefs.remove(key);
    }
  }
}

class SavedState {
  final int homeScore;
  final int awayScore;
  final int homeFouls;
  final int awayFouls;
  final int period;
  final Possession possession;
  final String homeTeamName;
  final String awayTeamName;
  final Color homeTeamColor;
  final Color awayTeamColor;
  final int timeLeftMs;
  final bool wasRunning;
  final int? savedAt;

  const SavedState({
    required this.homeScore,
    required this.awayScore,
    required this.homeFouls,
    required this.awayFouls,
    required this.period,
    required this.possession,
    required this.homeTeamName,
    required this.awayTeamName,
    required this.homeTeamColor,
    required this.awayTeamColor,
    required this.timeLeftMs,
    required this.wasRunning,
    this.savedAt,
  });
}
