import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/scoreboard_state.dart';
import 'pressable.dart';

class TimeoutOverlay extends StatelessWidget {
  const TimeoutOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ScoreboardState>();
    if (!state.isTimeout) return const SizedBox.shrink();

    final mins = (state.timeoutSeconds ~/ 60).toString().padLeft(2, '0');
    final secs = (state.timeoutSeconds % 60).toString().padLeft(2, '0');

    return Pressable(
      onTap: () => state.cancelTimeout(),
      child: Container(
        color: Colors.black.withValues(alpha: 0.85),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                state.timeoutLabel,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Impact',
                ),
              ),
              const SizedBox(height: 20),
              Text(
                '$mins:$secs',
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 200,
                  fontFamily: 'DSEG7',
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                "Paina peruuttaaksesi",
                style: TextStyle(color: Colors.grey, fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
