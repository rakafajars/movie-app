part of 'list_movie_bloc.dart';

sealed class ListMovieState extends Equatable {
  const ListMovieState();
}

final class ListMovieLoading extends ListMovieState {
  @override
  List<Object> get props => [];
}

final class ListMovieLoaded extends ListMovieState {
  final MovieModel movie;

  const ListMovieLoaded({required this.movie});

  @override
  List<Object> get props => [movie];
}

final class ListMovieEmpty extends ListMovieState {
  @override
  List<Object?> get props => [];
}

final class ListMovieError extends ListMovieState {
  final String messageError;

  const ListMovieError({required this.messageError});
  @override
  List<Object?> get props => [messageError];
}
