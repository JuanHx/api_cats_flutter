import 'package:api_cats_app/data/datasources/cat_remote_data_source_impl.dart';
import 'package:api_cats_app/data/dio_client.dart';
import 'package:api_cats_app/data/models/breed_model.dart';
import 'package:api_cats_app/data/models/image_cat_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'dart:math';

part 'breed_event.dart';
part 'breed_state.dart';

class BreedBloc extends Bloc<BreedEvent, BreedState> {
  final CatRemoteDataSourceImpl dataSource;

  List<BreedModel>? _cachedBreeds;
  bool _hasLoadedBreeds = false;

  BreedBloc({CatRemoteDataSourceImpl? dataSource})
    : dataSource = dataSource ?? CatRemoteDataSourceImpl(dio: DioClient().dio),
      super(BreedState()) {
    on<BreedsFetchEvent>(onFetchBreeds);
    on<GetImagesByBreed>(onGetImagesByBreed);
    on<SelectedBreed>(onSelectedBreed);
    on<ChangedSelectedBreed>(onChangedSelectedBreed);
    on<GetRandomBreedEvent>(_onGetRandomBreed);
    on<VoteBreedEvent>(_onVoteBreed);
  }

  Future<void> onFetchBreeds(
    BreedsFetchEvent event,
    Emitter<BreedState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    if (_hasLoadedBreeds && _cachedBreeds != null) {
      emit(state.copyWith(breeds: _cachedBreeds!, isLoading: false));
      emit(state.copyWith(isLoading: false));
      return;
    }

    final breeds = await dataSource.getAllBreeds();
    _cachedBreeds = breeds;
    _hasLoadedBreeds = true;
    emit(state.copyWith(breeds: breeds, isLoading: false));
  }

  Future<void> onGetImagesByBreed(
    GetImagesByBreed event,
    Emitter<BreedState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final images = await dataSource.getImagesByBreed(event.breedId);

    emit(
      state.copyWith(images: images, isLoading: false, navigateToDetail: true),
    );
  }

  void clearCache() {
    _cachedBreeds = null;
    _hasLoadedBreeds = false;
  }

  bool get hasCachedBreeds => _hasLoadedBreeds && _cachedBreeds != null;

  void onSelectedBreed(SelectedBreed event, Emitter<BreedState> emit) {
    emit(state.copyWith(selectedBreed: event.breed));
  }

  Future<void> onChangedSelectedBreed(
    ChangedSelectedBreed event,
    Emitter<BreedState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final images = await dataSource.getImagesByBreed(event.breedId);

    emit(
      state.copyWith(
        images: images,
        selectedBreed: state.breeds.firstWhere(
          (breed) => breed.id == event.breedId,
        ),
        isLoading: false,
      ),
    );
  }

  Future<void> _onGetRandomBreed(
    GetRandomBreedEvent event,
    Emitter<BreedState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      final breeds = await dataSource.getAllBreeds();
      if (breeds.isEmpty) {
        emit(BreedError('No se encontraron razas'));
        return;
      }

      final random = Random();
      final randomIndex = random.nextInt(breeds.length);
      final randomBreed = breeds[randomIndex];

      String imageUrl;
      if (randomBreed.referenceImageId != null) {
        imageUrl =
            'https://cdn2.thecatapi.com/images/${randomBreed.referenceImageId}.jpg';
        emit(RandomBreedLoaded(randomBreed, imageUrl));
      } else {
        try {
          final images = await dataSource.getImagesByBreed(
            randomBreed.id,
            limit: 1,
          );
          if (images.isNotEmpty) {
            imageUrl = images.first.url;
            emit(RandomBreedLoaded(randomBreed, imageUrl));
          } else {
            emit(BreedError('No se encontraron imágenes para esta raza'));
          }
        } catch (e) {
          emit(BreedError(e.toString()));
        }
      }
    } catch (e) {
      emit(BreedError(e.toString()));
    }
  }

  Future<void> _onVoteBreed(
    VoteBreedEvent event,
    Emitter<BreedState> emit,
  ) async {
    try {
      emit(BreedVoteSuccess(event.isLike));
      add(GetRandomBreedEvent());
    } catch (e) {
      emit(BreedError(e.toString()));
    }
  }
}
