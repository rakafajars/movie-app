part of 'search_movie_bloc.dart';

sealed class SearchMovieState extends Equatable {
  const SearchMovieState();
}

final class SearchMovieInitial extends SearchMovieState {
  @override
  List<Object> get props => [];
}

final class SearchMovieLoading extends SearchMovieState {
  @override
  List<Object> get props => [];
}

class SearchMovieLoaded extends SearchMovieState {
  final MovieModel movieModel;

  const SearchMovieLoaded({required this.movieModel});

  @override
  List<Object?> get props => [movieModel];
}

class SearchMovieEmpty extends SearchMovieState {
  @override
  List<Object?> get props => [];
}

class SearchMovieError extends SearchMovieState {
  final String messageError;

  const SearchMovieError({required this.messageError});
  @override
  List<Object?> get props => [messageError];
}
