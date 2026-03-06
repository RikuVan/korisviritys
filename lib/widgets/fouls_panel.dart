import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/scoreboard_state.dart';

class FoulsPanel extends StatelessWidget {
  final bool isHome;

  const FoulsPanel({super.key, required this.isHome});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ScoreboardState>();
    final fouls = isHome ? state.homeFouls : state.awayFouls;
    final inPenalty = fouls >= 6;

    return Column(
      children: [
        const Text(
          "VIRHEET",
          style: TextStyle(color: Colors.grey, fontSize: 12),
        ),
        const SizedBox(height: 2),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final useCompact = constraints.maxHeight < 180;

              return GestureDetector(
                onTap: () => state.adjustFouls(isHome: isHome, amount: 1),
                onLongPress: () =>
                    state.adjustFouls(isHome: isHome, amount: -1),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 8,
                  ),
                  decoration: BoxDecoration(
                    color: inPenalty ? Colors.red.shade900 : Colors.black,
                    border: Border.all(
                      color: inPenalty ? Colors.red : Colors.grey.shade700,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: useCompact
                      ? Center(
                          child: Text(
                            '$fouls',
                            style: TextStyle(
                              color: inPenalty ? Colors.red : Colors.white,
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'DSEG7',
                            ),
                          ),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(5, (index) {
                            final foulNumber = 5 - index;
                            final isActive = foulNumber <= fouls;
                            final isFifth = foulNumber == 5;
                            final size = 12.0 + (foulNumber * 5.0);
                            final activeColor = isFifth
                                ? Colors.red
                                : Colors.white;
                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 3),
                              width: size,
                              height: size,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: isActive
                                    ? activeColor
                                    : Colors.grey.shade900,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.grey.shade600),
                              ),
                              child: (isFifth && inPenalty)
                                  ? Text(
                                      '$fouls',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  : null,
                            );
                          }),
                        ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
