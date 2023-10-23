import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/model/data_movie_model.dart';
import 'package:movie_app/model/movie_model.dart';
import 'package:movie_app/service/service_remote/movie_service.dart';

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
            page: event.page,
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

    on<GetPaginationListMovieEvent>(
      (event, emit) async {
        // nilai yang udah didapet dari event
        // GetListMovie itu masih disimpen disini
        try {
          final currentState = state;

          if (currentState is ListMovieLoaded) {
            final List<DataMovieModel>? currentMovie =
                currentState.movie.results;

            final movie = await MovieService().getMovieListByParameter(
              typeMovie: event.idTitle,
              page: event.page,
            );

            if (movie.results?.isNotEmpty == true) {
              movie.results?.forEach((element) {
                currentMovie?.add(element);
              });

              emit(
                ListMovieLoaded(
                  movie: MovieModel(
                    results: currentMovie,
                  ),
                ),
              );
            }
          }
        } catch (e) {
          emit(const ListMoviePaginationError());
        }
      },
    );
  }
}
