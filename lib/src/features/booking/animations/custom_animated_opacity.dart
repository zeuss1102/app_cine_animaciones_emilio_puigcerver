import 'package:flutter/material.dart';

class CustomAnimatedOpacity extends AnimatedWidget {
  const CustomAnimatedOpacity({
    super.key,
    required Animation animation,
    required this.child,
  }) : super(listenable: animation);

  final Widget child;

  Animation<double> get progress => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: progress.value,
      child: child,
    );
  }
}
