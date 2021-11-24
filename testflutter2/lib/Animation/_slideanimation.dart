import 'package:flutter/material.dart';

class SlideAnimation extends StatefulWidget {
  final double delay;
  final Widget child;

  const SlideAnimation({Key? key, required this.delay, required this.child})
      : super(key: key);

  @override
  _FadeTransitionDemoState createState() => _FadeTransitionDemoState();
}

class _FadeTransitionDemoState extends State<SlideAnimation>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late final Animation<Offset> _offsetAnimation;

  @override
  initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: (500 * widget.delay).round()),
      vsync: this,
    )..forward();
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, -2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.bounceOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(position: _offsetAnimation, child: widget.child);
  }
}
