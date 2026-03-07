import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/scoreboard_state.dart';
import 'arrow_painter.dart';
import 'pressable.dart';

class TeamsHeader extends StatelessWidget {
  const TeamsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ScoreboardState>();

    return Stack(
      alignment: Alignment.center,
      children: [
        Pressable(
          onTap: state.togglePossession,
          child: Container(
            width: 200,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.black,
              border: Border.all(color: Colors.grey.shade800),
            ),
            child: state.possession == Possession.none
                ? const Text(
                    "HALLINTA",
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  )
                : CustomPaint(
                    size: const Size(180, 36),
                    painter: ArrowPainter(
                      pointsLeft: state.possession == Possession.home,
                    ),
                  ),
          ),
        ),
        Row(
          children: [
            Row(
              children: [
                const Icon(Icons.home, color: Colors.white, size: 36),
                const SizedBox(width: 6),
                Text(
                  state.homeTeamName,
                  style: TextStyle(
                    color: state.homeTeamColor,
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Impact',
                  ),
                ),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                Text(
                  state.awayTeamName,
                  style: TextStyle(
                    color: state.awayTeamColor,
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Impact',
                  ),
                ),
                const SizedBox(width: 6),
                const Icon(Icons.flight, color: Colors.white, size: 36),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class ScoresRow extends StatelessWidget {
  const ScoresRow({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ScoreboardState>();

    return Row(
      children: [
        Expanded(
          child: _ScoreDisplay(
            score: state.homeScore,
            onAdjust: (d) => state.adjustScore(isHome: true, amount: d),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: _ScoreDisplay(
            score: state.awayScore,
            onAdjust: (d) => state.adjustScore(isHome: false, amount: d),
          ),
        ),
      ],
    );
  }
}

class _ScoreDisplay extends StatelessWidget {
  final int score;
  final Function(int) onAdjust;

  const _ScoreDisplay({required this.score, required this.onAdjust});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(color: Colors.grey.shade800),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Expanded(
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text(
                score.toString().padLeft(2, '0'),
                style: const TextStyle(
                  fontSize: 140,
                  color: Color(0xFF00FF00),
                  fontFamily: 'DSEG7',
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Pressable(
                onTap: () => onAdjust(-1),
                child: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(Icons.remove, color: Colors.grey),
                ),
              ),
              const SizedBox(width: 8),
              _ScoreButton(text: "+1", onTap: () => onAdjust(1)),
              const SizedBox(width: 4),
              _ScoreButton(text: "+2", onTap: () => onAdjust(2)),
              const SizedBox(width: 4),
              _ScoreButton(text: "+3", onTap: () => onAdjust(3)),
            ],
          ),
        ],
      ),
    );
  }
}

class _ScoreButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const _ScoreButton({required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Pressable(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.grey.shade800,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Colors.grey.shade600),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.sports_basketball,
              color: Colors.white70,
              size: 14,
            ),
            const SizedBox(width: 3),
            Text(
              text,
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
