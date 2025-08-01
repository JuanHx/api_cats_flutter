import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  final Color? color;
  const CustomDivider({super.key, this.color = const Color.fromARGB(255, 164, 145, 228)});

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: 1,
      height: 1,
      color: color,
      
    );
  }
}
