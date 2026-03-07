import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
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

const _languages = [
  ('en', '\u{1F1EC}\u{1F1E7}  English'),
  ('fi', '\u{1F1EB}\u{1F1EE}  Suomi'),
  ('sv', '\u{1F1F8}\u{1F1EA}  Svenska'),
  ('et', '\u{1F1EA}\u{1F1EA}  Eesti'),
  ('lv', '\u{1F1F1}\u{1F1FB}  Latvie\u0161u'),
  ('lt', '\u{1F1F1}\u{1F1F9}  Lietuvi\u0173'),
  ('ru', '\u{1F1F7}\u{1F1FA}  \u0420\u0443\u0441\u0441\u043A\u0438\u0439'),
  ('de', '\u{1F1E9}\u{1F1EA}  Deutsch'),
  ('es', '\u{1F1EA}\u{1F1F8}  Espa\u00F1ol'),
  ('fr', '\u{1F1EB}\u{1F1F7}  Fran\u00E7ais'),
  ('it', '\u{1F1EE}\u{1F1F9}  Italiano'),
  (
    'el',
    '\u{1F1EC}\u{1F1F7}  \u0395\u03BB\u03BB\u03B7\u03BD\u03B9\u03BA\u03AC',
  ),
  ('tr', '\u{1F1F9}\u{1F1F7}  T\u00FCrk\u00E7e'),
  ('sr', '\u{1F1F7}\u{1F1F8}  \u0421\u0440\u043F\u0441\u043A\u0438'),
  ('hr', '\u{1F1ED}\u{1F1F7}  Hrvatski'),
  ('sl', '\u{1F1F8}\u{1F1EE}  Sloven\u0161\u010Dina'),
];

void showSetupDialog(BuildContext context, ScoreboardState state) {
  final homeController = TextEditingController(text: state.homeTeamName);
  final awayController = TextEditingController(text: state.awayTeamName);
  Color selectedHomeColor = state.homeTeamColor;
  Color selectedAwayColor = state.awayTeamColor;
  String selectedLocale = state.locale;

  showDialog(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setDialogState) {
        final l10n = AppLocalizations.of(context);
        return AlertDialog(
          backgroundColor: const Color(0xFF2A2A2A),
          title: Row(
            children: [
              const Icon(Icons.settings, color: Colors.white),
              const SizedBox(width: 8),
              Text(
                l10n.gameSettings,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
          content: SizedBox(
            width: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Language selector
                Text(
                  l10n.language,
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const SizedBox(height: 4),
                DropdownButtonFormField<String>(
                  initialValue: selectedLocale,
                  dropdownColor: Colors.grey.shade900,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade700),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade700),
                    ),
                  ),
                  items: [
                    for (final (code, label) in _languages)
                      DropdownMenuItem(value: code, child: Text(label)),
                  ],
                  onChanged: (code) {
                    if (code != null) {
                      setDialogState(() => selectedLocale = code);
                      state.setLocale(code);
                      // Update team name fields if they were defaults
                      homeController.text = state.homeTeamName;
                      awayController.text = state.awayTeamName;
                    }
                  },
                ),
                const SizedBox(height: 16),
                Text(
                  l10n.homeTeam,
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
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
                Text(
                  l10n.awayTeam,
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
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
              child: Text(
                l10n.cancel,
                style: const TextStyle(color: Colors.grey),
              ),
            ),
            TextButton(
              onPressed: () {
                state.setTeamInfo(
                  homeName: homeController.text.isEmpty
                      ? l10n.defaultHome
                      : homeController.text,
                  awayName: awayController.text.isEmpty
                      ? l10n.defaultAway
                      : awayController.text,
                  homeColor: selectedHomeColor,
                  awayColor: selectedAwayColor,
                );
                Navigator.of(context).pop();
              },
              child: Text(
                l10n.save,
                style: const TextStyle(color: Colors.blue),
              ),
            ),
          ],
        );
      },
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
