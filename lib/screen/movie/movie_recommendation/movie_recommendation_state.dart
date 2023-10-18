part of 'movie_recommendation_bloc.dart';

sealed class MovieRecommendationState extends Equatable {
  const MovieRecommendationState();
}

final class MovieRecommendationLoading extends MovieRecommendationState {
  @override
  List<Object> get props => [];
}

final class MovieRecommendationLoaded extends MovieRecommendationState {
  final MovieModel movieModel;

  const MovieRecommendationLoaded({required this.movieModel});
  @override
  List<Object> get props => [movieModel];
}

final class MovieRecommendationEmpty extends MovieRecommendationState {
  @override
  List<Object> get props => [];
}

final class MovieRecommendationError extends MovieRecommendationState {
  final String messageError;

  const MovieRecommendationError({required this.messageError});
  @override
  List<Object> get props => [messageError];
}
