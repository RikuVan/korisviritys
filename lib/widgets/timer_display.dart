import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../state/scoreboard_state.dart';
import 'fouls_panel.dart';
import 'pressable.dart';

class TimerDisplay extends StatelessWidget {
  const TimerDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ScoreboardState>();
    final l10n = AppLocalizations.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const FoulsPanel(isHome: true),
        const SizedBox(width: 8),
        Expanded(
          child: Pressable(
            onTap: () => state.toggleTimer(),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              decoration: BoxDecoration(
                border: Border.all(
                  color: state.isRunning
                      ? Colors.green.shade700
                      : Colors.grey.shade800,
                  width: 2,
                ),
                color: Colors.black,
                borderRadius: BorderRadius.circular(8),
              ),
              child: FittedBox(
                fit: BoxFit.contain,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _TimerDigit(
                      value: state.minutes,
                      onAdjust: (d) => state.adjustTime(minutes: d),
                      label: l10n.minutesLabel,
                      color: Colors.white,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        ":",
                        style: TextStyle(
                          fontSize: 100,
                          color: Colors.white,
                          fontFamily: 'DSEG7',
                          height: 1,
                        ),
                      ),
                    ),
                    _TimerDigit(
                      value: state.seconds,
                      onAdjust: (d) => state.adjustTime(seconds: d),
                      label: l10n.secondsLabel,
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        const FoulsPanel(isHome: false),
      ],
    );
  }
}

class _TimerDigit extends StatelessWidget {
  final int value;
  final Function(int) onAdjust;
  final String label;
  final Color color;

  const _TimerDigit({
    required this.value,
    required this.onAdjust,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value.toString().padLeft(2, '0'),
          style: TextStyle(
            fontSize: 100,
            color: color,
            fontFamily: 'DSEG7',
            letterSpacing: 2,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Pressable(
              onTap: () => onAdjust(1),
              child: const Icon(
                Icons.arrow_drop_up,
                color: Colors.grey,
                size: 24,
              ),
            ),
            const SizedBox(width: 20),
            Pressable(
              onTap: () => onAdjust(-1),
              child: const Icon(
                Icons.arrow_drop_down,
                color: Colors.grey,
                size: 24,
              ),
            ),
          ],
        ),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 10)),
      ],
    );
  }
}
