import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/model/movie_model.dart';
import 'package:movie_app/service/movie_service.dart';

part 'movie_recommendation_event.dart';
part 'movie_recommendation_state.dart';

class MovieRecommendationBloc
    extends Bloc<MovieRecommendationEvent, MovieRecommendationState> {
  MovieRecommendationBloc() : super(MovieRecommendationLoading()) {
    on<MovieRecommendationEvent>((event, emit) async {
      if (event is GetMovieRecommendationEvenet) {
        try {
          emit(MovieRecommendationLoading());
          final movieModel = await MovieService()
              .getMovieRecommendation(idMovie: event.idMovie);

          if (movieModel.results?.isNotEmpty == true) {
            emit(MovieRecommendationLoaded(movieModel: movieModel));
          } else {
            emit(MovieRecommendationEmpty());
          }
        } catch (e) {
          emit(
            MovieRecommendationError(
              messageError: e.toString(),
            ),
          );
        }
      }
    });
  }
}
