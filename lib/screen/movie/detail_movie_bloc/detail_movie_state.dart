part of 'detail_movie_bloc.dart';

sealed class DetailMovieState extends Equatable {
  const DetailMovieState();
}

final class DetailMovieLoading extends DetailMovieState {
  @override
  List<Object> get props => [];
}

final class DetailMovieLoaded extends DetailMovieState {
  final DataMovieModel dataMovieModel;

  const DetailMovieLoaded({required this.dataMovieModel});
  @override
  List<Object> get props => [dataMovieModel];
}

final class DetailMovieError extends DetailMovieState {
  final String messageError;

  const DetailMovieError({required this.messageError});
  @override
  List<Object> get props => [
        messageError,
      ];
}
