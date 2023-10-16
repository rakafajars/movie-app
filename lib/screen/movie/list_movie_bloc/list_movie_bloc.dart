import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/model/movie_model.dart';
import 'package:movie_app/service/movie_service.dart';

part 'list_movie_event.dart';
part 'list_movie_state.dart';

class ListMovieBloc extends Bloc<ListMovieEvent, ListMovieState> {
  ListMovieBloc() : super(ListMovieLoading()) {
    on<GetListMovieEvent>(
      (event, emit) async {
        try {
          emit(ListMovieLoading());

          final movie = await MovieService().getMovieListByParameter(
            typeMovie: event.idTitle,
          );

          if (movie.results?.isNotEmpty == true) {
            emit(
              ListMovieLoaded(
                movie: movie,
              ),
            );
          } else {
            emit(ListMovieEmpty());
          }
        } catch (e) {
          emit(
            const ListMovieError(
              messageError: "Terjadi Kesalahan",
            ),
          );
        }
      },
    );
  }
}
