// data/models/image_cat_model.dart
import '../../domain/entities/image_cat.dart';

class ImageCatModel {
  final String id;
  final String url;
  final int width;
  final int height;

  ImageCatModel({
    required this.id,
    required this.url,
    required this.width,
    required this.height,
  });

  factory ImageCatModel.fromJson(Map<String, dynamic> json) {
    return ImageCatModel(
      id: json['id'],
      url: json['url'],
      width: json['width'],
      height: json['height'],
    );
  }

  ImageCat toEntity() {
    return ImageCat(
      id: id,
      url: url,
      width: width,
      height: height,
    );
  }
}
