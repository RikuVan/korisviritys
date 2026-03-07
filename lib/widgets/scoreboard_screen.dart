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
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ScoreboardState>();

    return Focus(
      focusNode: _focusNode,
      autofocus: true,
      onKeyEvent: (node, event) {
        if (event is KeyDownEvent &&
            event.logicalKey == LogicalKeyboardKey.space) {
          state.toggleTimer();
          return KeyEventResult.handled;
        }
        return KeyEventResult.ignored;
      },
      child: Scaffold(
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
      ),
    );
  }
}
