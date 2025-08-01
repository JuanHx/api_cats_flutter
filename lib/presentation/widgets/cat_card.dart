import 'package:flutter/material.dart';
import '../../data/models/breed_model.dart';

class CatCard extends StatelessWidget {
  final BreedModel breed;
  final VoidCallback? onPressed;

  const CatCard({super.key, required this.breed, this.onPressed});


  @override
  Widget build(BuildContext context) {
    String? imageUrl;
    if (breed.referenceImageId != null) {
      imageUrl = 'https://cdn2.thecatapi.com/images/${breed.referenceImageId}.jpg';
    }

    return InkWell(
      onTap: onPressed,
      child: Card(
        elevation: 0,
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              // Imagen del gato
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0)),
                child: imageUrl != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[200],
                              child: const Center(child: Icon(Icons.error_outline, color: Colors.grey)),
                            );
                          },
                        ),
                      )
                    : Container(
                        color: Colors.grey[200],
                        child: const Center(child: Icon(Icons.pets, color: Colors.grey)),
                      ),
              ),
              const SizedBox(width: 16.0),
              // Información del gato
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(breed.name, style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4.0),
                    Text(breed.name, style: TextStyle(fontSize: 14.0, color: Colors.grey[600])),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
