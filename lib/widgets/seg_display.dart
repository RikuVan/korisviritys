import 'package:flutter/material.dart';

/// Seven-segment (DSEG7) number with faint "ghost" segments behind the lit
/// digits, mimicking the unlit segments of a real LED scoreboard.
class SegDisplay extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final double letterSpacing;

  /// Opacity of the ghost (unlit) segments drawn behind the value.
  final double ghostOpacity;

  const SegDisplay({
    super.key,
    required this.text,
    required this.color,
    required this.fontSize,
    this.letterSpacing = 0,
    this.ghostOpacity = 0.08,
  });

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      fontSize: fontSize,
      fontFamily: 'DSEG7',
      letterSpacing: letterSpacing,
      height: 1,
    );
    // "8" lights every segment, so a faint row of 8s reveals the full grid.
    final ghost = '8' * text.characters.length;

    return Stack(
      children: [
        Text(
          ghost,
          style: style.copyWith(color: color.withValues(alpha: ghostOpacity)),
        ),
        Text(text, style: style.copyWith(color: color)),
      ],
    );
  }
}
