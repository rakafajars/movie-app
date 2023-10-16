part of 'list_movie_bloc.dart';

sealed class ListMovieEvent extends Equatable {
  const ListMovieEvent();
}

class GetListMovieEvent extends ListMovieEvent {
  final String idTitle;

  const GetListMovieEvent({required this.idTitle});
  @override
  List<Object> get props => [idTitle];
}
