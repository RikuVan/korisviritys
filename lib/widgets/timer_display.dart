import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../state/scoreboard_state.dart';
import 'fouls_panel.dart';
import 'pressable.dart';
import 'seg_display.dart';

/// Bright red used for the seconds so they read at a glance.
const Color _secondsColor = Color(0xFFFF0000);
const Color _stepperColor = Color(0xFF264997);

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
        const SizedBox(width: 12),
        Expanded(
          child: Pressable(
            onTap: () => state.toggleTimer(),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Time fills the black background (bounded box → scales up)
                  // and is centered; gutters keep it clear of the steppers.
                  Positioned.fill(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 60),
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SegDisplay(
                              text: state.minutes.toString().padLeft(2, '0'),
                              color: Colors.white,
                              fontSize: 120,
                              letterSpacing: 2,
                              ghostOpacity: 0.06,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4),
                              child: Text(
                                ":",
                                style: TextStyle(
                                  fontSize: 120,
                                  color: Colors.white,
                                  fontFamily: 'DSEG7',
                                  height: 1,
                                ),
                              ),
                            ),
                            SegDisplay(
                              text: state.seconds.toString().padLeft(2, '0'),
                              color: _secondsColor,
                              fontSize: 120,
                              letterSpacing: 2,
                              ghostOpacity: 0.12,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 8,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: _Stepper(
                        onUp: () => state.adjustTime(minutes: 1),
                        onDown: () => state.adjustTime(minutes: -1),
                        upLabel: l10n.minutesUp,
                        downLabel: l10n.minutesDown,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 8,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: _Stepper(
                        onUp: () => state.adjustTime(seconds: 1),
                        onDown: () => state.adjustTime(seconds: -1),
                        upLabel: l10n.secondsUp,
                        downLabel: l10n.secondsDown,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 4,
                    child: _RunLabel(isRunning: state.isRunning),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        const FoulsPanel(isHome: false),
      ],
    );
  }
}

class _RunLabel extends StatelessWidget {
  final bool isRunning;

  const _RunLabel({required this.isRunning});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Text(
      isRunning ? '\u25CF ${l10n.running}' : '\u275A\u275A ${l10n.paused}',
      style: TextStyle(
        color: isRunning ? Colors.green.shade400 : Colors.grey,
        fontSize: 13,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.8,
      ),
    );
  }
}

class _Stepper extends StatelessWidget {
  final VoidCallback onUp;
  final VoidCallback onDown;
  final String upLabel;
  final String downLabel;

  const _Stepper({
    required this.onUp,
    required this.onDown,
    required this.upLabel,
    required this.downLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        _StepperButton(
          icon: Icons.keyboard_arrow_up,
          onTap: onUp,
          label: upLabel,
        ),
        const SizedBox(height: 10),
        _StepperButton(
          icon: Icons.keyboard_arrow_down,
          onTap: onDown,
          label: downLabel,
        ),
      ],
    );
  }
}

class _StepperButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final String label;

  const _StepperButton({
    required this.icon,
    required this.onTap,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: label,
      child: Pressable(
        onTap: onTap,
        child: Container(
          width: 44,
          height: 44,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: _stepperColor),
          ),
          child: Icon(icon, color: Colors.grey.shade300, size: 24),
        ),
      ),
    );
  }
}
