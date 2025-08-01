import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class GenericLoading extends StatefulWidget {
  final Color pawColor;

  const GenericLoading({super.key, this.pawColor = const Color(0xFF7760C0)});

  @override
  State<GenericLoading> createState() => _GenericLoadingState();
}

class _GenericLoadingState extends State<GenericLoading>
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
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(widget.pawColor, BlendMode.srcATop),
              child: Lottie.network(
                'https://lottie.host/6389a6a6-f979-4686-90dc-ea6482ec603d/H966xXPCZP.json',
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
      ),
    );
  }
}
