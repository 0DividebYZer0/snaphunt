import 'package:flutter/material.dart';

class LoadingTextField extends StatefulWidget {
  @override
  _LoadingTextFieldState createState() => _LoadingTextFieldState();
}

class _LoadingTextFieldState extends State<LoadingTextField>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    animation = Tween<double>(begin: -1.0, end: 2.0).animate(
        CurvedAnimation(curve: Curves.easeInOutSine, parent: _controller));

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        _controller.repeat();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var brightness = Theme.of(context).brightness;

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Padding(
          padding: const EdgeInsets.all(1.0),
          child: Container(
            width: 75,
            height: 8.0,
            decoration: myBoxDec(animation, brightness: brightness),
          ),
        );
      },
    );
  }
}

Decoration myBoxDec(animation, {isCircle = false, brightness}) {
  final dark = [
    Colors.grey[700],
    Colors.grey[600],
    Colors.grey[700],
  ];

  final light = [
    Color(0xfff6f7f9),
    Color(0xffe9ebee),
    Color(0xfff6f7f9),
  ];
  return BoxDecoration(
    shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
    gradient: LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: brightness == Brightness.light ? light : dark,
      stops: [
        // animation.value * 0.1,
        animation.value - 1,
        animation.value,
        animation.value + 1,
        // animation.value + 5,
        // 1.0,
      ],
    ),
  );
}
