import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../state/scoreboard_state.dart';

void showResetDialog(BuildContext context, ScoreboardState state) {
  showDialog(
    context: context,
    builder: (context) {
      final l10n = AppLocalizations.of(context);
      return AlertDialog(
        backgroundColor: const Color(0xFF2A2A2A),
        title: Text(
          l10n.resetGame,
          style: const TextStyle(color: Colors.white),
        ),
        content: Text(
          l10n.resetConfirmation,
          style: const TextStyle(color: Colors.grey),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              l10n.cancel,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
          TextButton(
            onPressed: () {
              state.resetGame(
                defaultHomeName: l10n.defaultHome,
                defaultAwayName: l10n.defaultAway,
              );
              Navigator.of(context).pop();
            },
            child: Text(l10n.reset, style: const TextStyle(color: Colors.red)),
          ),
        ],
      );
    },
  );
}
