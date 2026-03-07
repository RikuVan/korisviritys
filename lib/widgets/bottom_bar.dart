import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/scoreboard_state.dart';
import '../dialogs/reset_dialog.dart';
import '../dialogs/setup_dialog.dart';
import 'pressable.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ScoreboardState>();

    return Row(
      children: [
        const Expanded(
          child: Center(
            child: Text(
              "Paina kelloa tai VÄLILYÖNTIÄ käynnistääksesi/pysäyttääksesi",
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
        ),
        _BottomButton(
          icon: Icons.undo,
          label: "KUMOA",
          color: state.canUndo ? Colors.grey.shade800 : Colors.grey.shade900,
          borderColor: state.canUndo
              ? Colors.grey.shade600
              : Colors.grey.shade800,
          textColor: state.canUndo ? Colors.white : Colors.grey.shade700,
          onTap: state.canUndo ? () => state.undo() : null,
        ),
        _BottomButton(
          icon: Icons.restart_alt,
          label: "NOLLAA PELI",
          color: Colors.grey.shade800,
          borderColor: Colors.grey.shade600,
          textColor: Colors.white,
          onTap: () => showResetDialog(context, state),
        ),
        _BottomButton(
          icon: Icons.settings,
          label: "ASETUKSET",
          color: Colors.grey.shade800,
          borderColor: Colors.grey.shade600,
          textColor: Colors.white,
          onTap: () => showSetupDialog(context, state),
        ),
      ],
    );
  }
}

class _BottomButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Color borderColor;
  final Color textColor;
  final VoidCallback? onTap;

  const _BottomButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.borderColor,
    required this.textColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Pressable(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: borderColor),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: textColor, size: 14),
              const SizedBox(width: 4),
              Text(
                label,
                style: TextStyle(
                  color: textColor,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
