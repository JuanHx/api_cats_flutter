// domain/repositories/cat_repository.dart
import '../entities/breed.dart';
import '../entities/image_cat.dart';

abstract class CatRepository {
  Future<List<Breed>> getAllBreeds();
  Future<List<ImageCat>> getImagesByBreed(String breedId, {int limit});
}
