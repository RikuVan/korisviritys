import 'package:flutter/material.dart';
import '../state/scoreboard_state.dart';

void showResetDialog(BuildContext context, ScoreboardState state) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: const Color(0xFF2A2A2A),
      title: const Text("NOLLAA PELI", style: TextStyle(color: Colors.white)),
      content: const Text(
        "Haluatko varmasti nollata pelin? Kaikki pisteet, virheet ja kello palautetaan alkutilaan.",
        style: TextStyle(color: Colors.grey),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("PERUUTA", style: TextStyle(color: Colors.grey)),
        ),
        TextButton(
          onPressed: () {
            state.resetGame();
            Navigator.of(context).pop();
          },
          child: const Text("NOLLAA", style: TextStyle(color: Colors.red)),
        ),
      ],
    ),
  );
}
