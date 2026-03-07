import 'package:flutter/material.dart';

/// iOS-style pressable wrapper that dims opacity on press.
class Pressable extends StatefulWidget {
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final Widget child;

  const Pressable({
    super.key,
    this.onTap,
    this.onLongPress,
    required this.child,
  });

  @override
  State<Pressable> createState() => _PressableState();
}

class _PressableState extends State<Pressable> {
  bool _pressed = false;

  void _handleDown(TapDownDetails _) {
    if (widget.onTap != null || widget.onLongPress != null) {
      setState(() => _pressed = true);
    }
  }

  void _handleUp(TapUpDetails _) {
    setState(() => _pressed = false);
  }

  void _handleCancel() {
    setState(() => _pressed = false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: widget.onTap,
      onLongPress: widget.onLongPress,
      onTapDown: _handleDown,
      onTapUp: _handleUp,
      onTapCancel: _handleCancel,
      child: AnimatedOpacity(
        opacity: _pressed ? 0.5 : 1.0,
        duration: const Duration(milliseconds: 80),
        child: widget.child,
      ),
    );
  }
}
