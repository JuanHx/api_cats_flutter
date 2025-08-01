import 'package:flutter/material.dart';

class ButtonImage extends StatelessWidget {
  final void Function() onPressed;
  final String imagePath;

  const ButtonImage({
    super.key,
    required this.onPressed,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white, // Color del botón
        elevation: 8, // Efecto de elevación
        fixedSize: const Size(100, 100), // Tamaño cuadrado
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // Bordes redondeados
        ),
      ),
      child: Column(
        children: [Image.asset(imagePath, width: 100, height: 100)],
      ),
    );
  }
}
