import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/scoreboard_state.dart';
import 'pressable.dart';

class ControlsSection extends StatelessWidget {
  const ControlsSection({super.key});

  void _showTimeoutDialog(BuildContext context, ScoreboardState state) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.grey.shade900,
        title: const Text(
          "AIKALISÄ",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        content: const Text(
          "Valitse aikalisän pituus:",
          style: TextStyle(color: Colors.grey),
        ),
        actions: [
          for (final entry in {'30s': 30, '1 min': 60, '2 min': 120}.entries)
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                state.startTimeout("AIKALISÄ", Duration(seconds: entry.value));
              },
              child: Text(
                entry.key,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
        ],
      ),
    );
  }

  void _showHalftimeDialog(BuildContext context, ScoreboardState state) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.grey.shade900,
        title: const Text(
          "PUOLIAIKA",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        content: const Text(
          "Valitse puoliajan pituus:",
          style: TextStyle(color: Colors.grey),
        ),
        actions: [
          for (final entry in {'5 min': 5, '10 min': 10, '15 min': 15}.entries)
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                state.startTimeout("PUOLIAIKA", Duration(minutes: entry.value));
              },
              child: Text(
                entry.key,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ScoreboardState>();

    return Stack(
      alignment: Alignment.center,
      children: [
        // JAKSO centered with PUOLIAIKA between 2 and 3
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.black,
            border: Border.all(color: Colors.grey.shade700),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "JAKSO  ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ...[1, 2].map(
                (p) => Pressable(
                  onTap: () => state.setPeriod(p),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: 30,
                    height: 30,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: state.period == p
                          ? Colors.red
                          : Colors.grey.shade900,
                      border: Border.all(
                        color: state.period == p
                            ? Colors.redAccent
                            : Colors.grey.shade600,
                      ),
                    ),
                    child: Text(
                      "$p",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Pressable(
                onTap: () => _showHalftimeDialog(context, state),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  height: 30,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade800,
                    border: Border.all(color: Colors.grey.shade600),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    "PUOLIAIKA",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              ...[3, 4].map(
                (p) => Pressable(
                  onTap: () => state.setPeriod(p),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: 30,
                    height: 30,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: state.period == p
                          ? Colors.red
                          : Colors.grey.shade900,
                      border: Border.all(
                        color: state.period == p
                            ? Colors.redAccent
                            : Colors.grey.shade600,
                      ),
                    ),
                    child: Text(
                      "$p",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // Timeout left-center, Summeri right-center
        Row(
          children: [
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: _ControlButton(
                  "AIKALISÄ",
                  Colors.grey.shade800,
                  () => _showTimeoutDialog(context, state),
                  icon: Icons.timer,
                ),
              ),
            ),
            const SizedBox(width: 250),
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: _ControlButton(
                  "SUMMERI",
                  state.buzzerActive
                      ? Colors.red.shade800
                      : Colors.grey.shade800,
                  () => state.triggerBuzzer(),
                  icon: Icons.notifications_active,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ControlButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onTap;
  final IconData? icon;

  const _ControlButton(this.text, this.color, this.onTap, {this.icon});

  @override
  Widget build(BuildContext context) {
    return Pressable(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Colors.white24),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, color: Colors.white, size: 14),
              const SizedBox(width: 4),
            ],
            Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
