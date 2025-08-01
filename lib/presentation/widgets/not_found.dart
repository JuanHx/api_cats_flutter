import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NotFound extends StatefulWidget {
  final Color pawColor;

  const NotFound({super.key, this.pawColor = const Color(0xFF7760C0)});

  @override
  State<NotFound> createState() => _NotFoundState();
}

class _NotFoundState extends State<NotFound>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.width * 0.8,
            child: Lottie.asset(
              'assets/lottie/error_404.json',
              fit: BoxFit.contain,
              controller: _controller,
              onLoaded: (composition) {
                _controller
                  ..duration = composition.duration * 0.5
                  ..repeat(reverse: true);
              },
            ),
          ),
        ),
      ),
    );
  }
}
