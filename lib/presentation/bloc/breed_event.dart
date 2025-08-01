part of 'breed_bloc.dart';

@immutable
sealed class BreedEvent {}

class LoadBreeds extends BreedEvent {}

final class BreedsFetchEvent extends BreedEvent {}

final class GetImagesByBreed extends BreedEvent {
  final String breedId;

  GetImagesByBreed(this.breedId);
}

final class GetRandomBreedEvent extends BreedEvent {}

final class VoteBreedEvent extends BreedEvent {
  final String breedId;
  final bool isLike;
  
  VoteBreedEvent(this.breedId, this.isLike);
}
class ResetBreedEvent extends BreedEvent {}

class SelectedBreed extends BreedEvent {
  final BreedModel breed;

  SelectedBreed(this.breed);
}

class ChangedSelectedBreed extends BreedEvent {
  final String breedId;
  ChangedSelectedBreed(this.breedId);
}
