// data/datasources/cat_remote_data_source.dart
import '../models/breed_model.dart';
import '../models/image_cat_model.dart';

abstract class CatRemoteDataSource {
  Future<List<BreedModel>> getAllBreeds();
  Future<List<ImageCatModel>> getImagesByBreed(String breedId, {int limit});
}
