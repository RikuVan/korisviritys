import 'package:flutter/material.dart';
import '../state/scoreboard_state.dart';

const _teamColors = [
  Colors.white,
  Colors.red,
  Colors.blue,
  Colors.green,
  Colors.yellow,
  Colors.orange,
  Colors.purple,
  Colors.cyan,
  Colors.pink,
  Colors.teal,
  Colors.amber,
  Colors.lime,
  Color(0xFF8B0000), // dark red
  Color(0xFF00008B), // dark blue
  Color(0xFF006400), // dark green
  Color(0xFF8B4513), // saddle brown
  Color(0xFF4B0082), // indigo
  Color(0xFF2F4F4F), // dark slate grey
  Color(0xFFB8860B), // dark goldenrod
  Color(0xFF800080), // dark magenta
  Color(0xFF191970), // midnight blue
];

void showSetupDialog(BuildContext context, ScoreboardState state) {
  final homeController = TextEditingController(text: state.homeTeamName);
  final awayController = TextEditingController(text: state.awayTeamName);
  Color selectedHomeColor = state.homeTeamColor;
  Color selectedAwayColor = state.awayTeamColor;

  showDialog(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setDialogState) => AlertDialog(
        backgroundColor: const Color(0xFF2A2A2A),
        title: const Row(
          children: [
            Icon(Icons.settings, color: Colors.white),
            SizedBox(width: 8),
            Text("PELIN ASETUKSET", style: TextStyle(color: Colors.white)),
          ],
        ),
        content: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Kotijoukkue",
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const SizedBox(height: 4),
              TextField(
                controller: homeController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.black,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade700),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade700),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              _ColorPicker(
                colors: _teamColors,
                selected: selectedHomeColor,
                onSelect: (c) => setDialogState(() => selectedHomeColor = c),
              ),
              const SizedBox(height: 20),
              const Text(
                "Vierasjoukkue",
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const SizedBox(height: 4),
              TextField(
                controller: awayController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.black,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade700),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade700),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              _ColorPicker(
                colors: _teamColors,
                selected: selectedAwayColor,
                onSelect: (c) => setDialogState(() => selectedAwayColor = c),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("PERUUTA", style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              state.setTeamInfo(
                homeName: homeController.text.isEmpty
                    ? 'KOTI'
                    : homeController.text,
                awayName: awayController.text.isEmpty
                    ? 'VIERAS'
                    : awayController.text,
                homeColor: selectedHomeColor,
                awayColor: selectedAwayColor,
              );
              Navigator.of(context).pop();
            },
            child: const Text("TALLENNA", style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
    ),
  );
}

class _ColorPicker extends StatelessWidget {
  final List<Color> colors;
  final Color selected;
  final ValueChanged<Color> onSelect;

  const _ColorPicker({
    required this.colors,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: colors
          .map(
            (color) => GestureDetector(
              onTap: () => onSelect(color),
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: selected == color
                        ? Colors.white
                        : Colors.grey.shade800,
                    width: selected == color ? 3 : 1,
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
