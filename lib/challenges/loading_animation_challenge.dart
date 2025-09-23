import 'package:flutter/material.dart';

class LoadingAnimationChallenge extends StatefulWidget {
  const LoadingAnimationChallenge({super.key});

  @override
  State<LoadingAnimationChallenge> createState() =>
      _LoadingAnimationChallengeState();
}

class _LoadingAnimationChallengeState extends State<LoadingAnimationChallenge>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> scale1;
  late final Animation<double> scale2;
  late final Animation<double> scale3;
  late final Animation<double> opacity1;
  late final Animation<double> opacity2;
  late final Animation<double> opacity3;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    scale1 = Tween<double>(begin: 1, end: 1.5).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.33)),
    );
    opacity1 = Tween<double>(begin: .5, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.33)),
    );

    scale2 = Tween<double>(begin: 1, end: 1.5).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.33, 0.66)),
    );
    opacity2 = Tween<double>(begin: .5, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.33, 0.66)),
    );

    scale3 = Tween<double>(begin: 1, end: 1.5).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.66, 1.0)),
    );
    opacity3 = Tween<double>(begin: .5, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.66, 1.0)),
    );

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Loading Animation Challenge")),
      body: Center(
        child: Row(
          spacing: 8,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomCircleAvatar(scale: scale1, opacity: opacity1),
            CustomCircleAvatar(scale: scale2, opacity: opacity2),
            CustomCircleAvatar(scale: scale3, opacity: opacity3),
          ],
        ),
      ),
    );
  }
}

class CustomCircleAvatar extends StatelessWidget {
  const CustomCircleAvatar({
    super.key,
    required this.scale,
    required this.opacity,
  });

  final Animation<double> scale;
  final Animation<double> opacity;

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scale,
      child: FadeTransition(
        opacity: opacity,
        child: const CircleAvatar(radius: 8, backgroundColor: Colors.blueGrey),
      ),
    );
  }
}
