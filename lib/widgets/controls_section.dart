import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../state/scoreboard_state.dart';
import 'pressable.dart';

class ControlsSection extends StatelessWidget {
  const ControlsSection({super.key});

  void _showTimeoutDialog(BuildContext context, ScoreboardState state) {
    showDialog(
      context: context,
      builder: (ctx) {
        final l10n = AppLocalizations.of(ctx);
        return AlertDialog(
          backgroundColor: Colors.grey.shade900,
          title: Text(
            l10n.timeout,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            l10n.chooseTimeoutDuration,
            style: const TextStyle(color: Colors.grey),
          ),
          actions: [
            for (final entry in {'30s': 30, '1 min': 60, '2 min': 120}.entries)
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                  state.startTimeout(
                    l10n.timeout,
                    Duration(seconds: entry.value),
                  );
                },
                child: Text(
                  entry.key,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
          ],
        );
      },
    );
  }

  void _showHalftimeDialog(BuildContext context, ScoreboardState state) {
    final customController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) {
        final l10n = AppLocalizations.of(ctx);

        void startCustom() {
          final mins = int.tryParse(customController.text);
          if (mins != null && mins > 0) {
            Navigator.of(ctx).pop();
            state.startTimeout(l10n.halftime, Duration(minutes: mins));
          }
        }

        return StatefulBuilder(
          builder: (ctx, setDialogState) => AlertDialog(
            backgroundColor: Colors.grey.shade900,
            title: Text(
              l10n.halftime,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.chooseHalftimeDuration,
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for (final entry in {
                      '5 min': 5,
                      '10 min': 10,
                      '15 min': 15,
                    }.entries)
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                          state.startTimeout(
                            l10n.halftime,
                            Duration(minutes: entry.value),
                          );
                        },
                        child: Text(
                          entry.key,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Expanded(child: Divider(color: Colors.grey)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        l10n.or_,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                    const Expanded(child: Divider(color: Colors.grey)),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    SizedBox(
                      width: 80,
                      child: TextField(
                        controller: customController,
                        autofocus: false,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.black,
                          hintText: '0',
                          hintStyle: TextStyle(color: Colors.grey.shade700),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 8,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade700),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade700),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                        ),
                        onSubmitted: (_) => startCustom(),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      l10n.min,
                      style: const TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                    const SizedBox(width: 12),
                    TextButton(
                      onPressed: startCustom,
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.blue.shade800,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                      ),
                      child: Text(
                        l10n.start,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: Text(
                  l10n.cancel,
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ScoreboardState>();
    final l10n = AppLocalizations.of(context);

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
              Text(
                "${l10n.period}  ",
                style: const TextStyle(
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
                  child: Text(
                    l10n.halftime,
                    style: const TextStyle(
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
                  l10n.timeout,
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
                  l10n.buzzer,
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
