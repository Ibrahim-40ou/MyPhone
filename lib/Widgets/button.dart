import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final VoidCallback buttonFunction;
  final double height;
  final double width;
  final Color color;
  final Widget child;
  final double elevation;
  final bool disabled;

  const MyButton({
    super.key,
    required this.buttonFunction,
    required this.height,
    required this.width,
    required this.color,
    required this.child,
    this.elevation = 0,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      child: MaterialButton(
        padding: EdgeInsets.zero,
        elevation: elevation,
        onPressed: disabled ? () {} : buttonFunction,
        color: disabled ? color.withOpacity(0.7) : color,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        child: Center(child: child),
      ),
    );
  }
}
