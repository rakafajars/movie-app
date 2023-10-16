part of 'detail_movie_bloc.dart';

sealed class DetailMovieEvent extends Equatable {
  const DetailMovieEvent();
}

class GetDetailMovieEvent extends DetailMovieEvent {
  final String idMovie;

  const GetDetailMovieEvent({required this.idMovie});
  @override
  List<Object> get props => [idMovie];
}
