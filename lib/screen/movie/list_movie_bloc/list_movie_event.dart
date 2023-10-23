part of 'list_movie_bloc.dart';

sealed class ListMovieEvent extends Equatable {
  const ListMovieEvent();
}

class GetListMovieEvent extends ListMovieEvent {
  final String idTitle;
  final int page;

  const GetListMovieEvent({
    required this.idTitle,
    required this.page,
  });

  @override
  List<Object> get props => [idTitle, page];
}

class GetPaginationListMovieEvent extends ListMovieEvent {
  final String idTitle;
  final int page;

  const GetPaginationListMovieEvent({
    required this.idTitle,
    required this.page,
  });

  @override
  List<Object> get props => [idTitle, page];
}
