// data/datasources/cat_remote_data_source_impl.dart
import 'package:dio/dio.dart';
import 'cat_remote_data_source.dart';
import '../models/breed_model.dart';
import '../models/image_cat_model.dart';

class CatRemoteDataSourceImpl implements CatRemoteDataSource {
  final Dio dio;

  CatRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<BreedModel>> getAllBreeds() async {
    final response = await dio.get('/breeds');
    final data = response.data as List;
    return data.map((json) => BreedModel.fromJson(json)).toList();
  }

  @override
  Future<List<ImageCatModel>> getImagesByBreed(String breedId, {int limit = 10}) async {
    final response = await dio.get('/images/search', queryParameters: {
      'breed_ids': breedId,
      'limit': limit,
    });
    final data = response.data as List;
    return data.map((json) => ImageCatModel.fromJson(json)).toList();
  }
}
