part of 'search_movie_bloc.dart';

sealed class SearchMovieEvent extends Equatable {
  const SearchMovieEvent();
}

class GetSearchMovieEvent extends SearchMovieEvent {
  final String query;

  const GetSearchMovieEvent({required this.query});
  @override
  List<Object> get props => [query];
}
