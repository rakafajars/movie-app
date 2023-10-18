part of 'movie_recommendation_bloc.dart';

sealed class MovieRecommendationEvent extends Equatable {
  const MovieRecommendationEvent();
}

class GetMovieRecommendationEvenet extends MovieRecommendationEvent {
  final String idMovie;

  const GetMovieRecommendationEvenet({required this.idMovie});
  @override
  List<Object> get props => [idMovie];
}
