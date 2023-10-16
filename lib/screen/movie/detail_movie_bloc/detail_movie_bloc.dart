import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/model/data_movie_model.dart';
import 'package:movie_app/service/movie_service.dart';

part 'detail_movie_event.dart';
part 'detail_movie_state.dart';

class DetailMovieBloc extends Bloc<DetailMovieEvent, DetailMovieState> {
  DetailMovieBloc() : super(DetailMovieLoading()) {
    on<GetDetailMovieEvent>((event, emit) async {
      try {
        emit(DetailMovieLoading());
        final data =
            await MovieService().getMovieDetail(idDetail: event.idMovie);
        emit(DetailMovieLoaded(dataMovieModel: data));
      } catch (e) {
        emit(const DetailMovieError(messageError: 'Terjadi Error'));
      }
    });
  }
}
