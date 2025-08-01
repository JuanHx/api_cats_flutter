part of 'breed_bloc.dart';

@immutable
class BreedState {
  const BreedState({
    this.breeds = const [],
    this.selectedBreed,
    this.images = const [],
    this.isLoading = false,
    this.navigateToDetail = false,
  });

  final List<BreedModel> breeds;
  final BreedModel? selectedBreed;
  final List<ImageCatModel> images;
  final bool isLoading;
  final bool navigateToDetail;

  BreedState copyWith({
    List<BreedModel>? breeds,
    BreedModel? selectedBreed,
    List<ImageCatModel>? images,
    bool? isLoading,
    bool? navigateToDetail,
  }) {
    return BreedState(
      breeds: breeds ?? this.breeds,
      selectedBreed: selectedBreed ?? this.selectedBreed,
      images: images ?? this.images,
      isLoading: isLoading ?? this.isLoading,
      navigateToDetail: navigateToDetail ?? this.navigateToDetail,
    );
  }
}

class ResetBreedState extends BreedState {
  const ResetBreedState() : super();
}


class RandomBreedLoaded extends BreedState {
  final BreedModel breed;
  final String imageUrl;
  
  const RandomBreedLoaded(this.breed, this.imageUrl);
}

class BreedVoteSuccess extends BreedState {
  final bool isLike;
  
  const BreedVoteSuccess(this.isLike);
}

class BreedError extends BreedState {
  final String message;

  const BreedError(this.message);
}