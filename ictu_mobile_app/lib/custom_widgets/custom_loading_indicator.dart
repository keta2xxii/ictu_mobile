import 'package:flutter/material.dart';

class CustomLoadingIndicator extends StatefulWidget {
  const CustomLoadingIndicator({Key? key}) : super(key: key);

  @override
  _CustomLoadingIndicatorState createState() => _CustomLoadingIndicatorState();
}

class _CustomLoadingIndicatorState extends State<CustomLoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    controller.repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(begin: 1.0, end: 0.0).animate(controller),
      child: Image.asset("assets/images/loading.png"),
    );
  }
}
