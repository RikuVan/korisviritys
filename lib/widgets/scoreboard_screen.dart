import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../state/scoreboard_state.dart';
import 'timer_display.dart';
import 'controls_section.dart';
import 'scores_section.dart';
import 'bottom_bar.dart';
import 'timeout_overlay.dart';

class ScoreboardScreen extends StatefulWidget {
  const ScoreboardScreen({super.key});

  @override
  State<ScoreboardScreen> createState() => _ScoreboardScreenState();
}

class _ScoreboardScreenState extends State<ScoreboardScreen> {
  late final ScoreboardState _state;

  bool _onKey(KeyEvent event) {
    if (event is! KeyDownEvent) return false;
    final key = event.logicalKey;
    if (key == LogicalKeyboardKey.space) {
      _state.toggleTimer();
      return true;
    }
    // Home team: 1/2/3, Away team: 8/9/0
    if (key == LogicalKeyboardKey.digit1) { _state.adjustScore(isHome: true, amount: 1); return true; }
    if (key == LogicalKeyboardKey.digit2) { _state.adjustScore(isHome: true, amount: 2); return true; }
    if (key == LogicalKeyboardKey.digit3) { _state.adjustScore(isHome: true, amount: 3); return true; }
    if (key == LogicalKeyboardKey.digit8) { _state.adjustScore(isHome: false, amount: 1); return true; }
    if (key == LogicalKeyboardKey.digit9) { _state.adjustScore(isHome: false, amount: 2); return true; }
    if (key == LogicalKeyboardKey.digit0) { _state.adjustScore(isHome: false, amount: 3); return true; }
    return false;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _state = context.read<ScoreboardState>();
  }

  @override
  void initState() {
    super.initState();
    HardwareKeyboard.instance.addHandler(_onKey);
  }

  @override
  void dispose() {
    HardwareKeyboard.instance.removeHandler(_onKey);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ScoreboardState>();

    return Scaffold(
        backgroundColor: const Color(0xFF1A1A1A),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 6.0,
              ),
              child: Column(
                children: [
                  const Expanded(flex: 5, child: TimerDisplay()),
                  const SizedBox(height: 4),
                  const ControlsSection(),
                  const SizedBox(height: 4),
                  const TeamsHeader(),
                  const SizedBox(height: 4),
                  const Expanded(flex: 5, child: ScoresRow()),
                  const BottomBar(),
                ],
              ),
            ),
            const TimeoutOverlay(),
          ],
        ),
    );
  }
}

