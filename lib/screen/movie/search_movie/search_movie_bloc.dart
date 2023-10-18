import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/model/movie_model.dart';
import 'package:movie_app/service/service_remote/movie_service.dart';

part 'search_movie_event.dart';
part 'search_movie_state.dart';

class SearchMovieBloc extends Bloc<SearchMovieEvent, SearchMovieState> {
  SearchMovieBloc() : super(SearchMovieInitial()) {
    on<GetSearchMovieEvent>((event, emit) async {
      try {
        emit(SearchMovieLoading());
        final movie = await MovieService().searchMovie(query: event.query);

        if (movie.results?.isNotEmpty == true) {
          emit(SearchMovieLoaded(movieModel: movie));
        } else {
          emit(SearchMovieEmpty());
        }
      } catch (e) {
        print(e);
        emit(
          const SearchMovieError(
            messageError: "Terjadi Kesalahan",
          ),
        );
      }
    });
  }
}
