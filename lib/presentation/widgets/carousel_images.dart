import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouseImages extends StatelessWidget {
  const CarouseImages({super.key, required this.widget});

  final dynamic widget;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: widget.images.length,
      itemBuilder: (context, index, realIndex) {
        final image = widget.images[index];
        return Material(
          borderRadius: BorderRadius.circular(16),
          clipBehavior: Clip.antiAlias,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              image.url,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
        );
      },
      options: CarouselOptions(
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 16 / 9,
        viewportFraction: 0.7,
        autoPlayInterval: const Duration(seconds: 5),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
      ),
    );
  }
}
