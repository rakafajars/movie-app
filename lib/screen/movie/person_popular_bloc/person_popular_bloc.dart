import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/model/person_popular_model.dart';
import 'package:movie_app/service/service_remote/movie_service.dart';

part 'person_popular_event.dart';
part 'person_popular_state.dart';

class PersonPopularBloc extends Bloc<PersonPopularEvent, PersonPopularState> {
  PersonPopularBloc() : super(PersonPopularLoading()) {
    on<GetPersonPopularEvent>((event, emit) async {
      try {
        emit(PersonPopularLoading());

        final data = await MovieService().getPersonPopular();

        emit(PersonPopularLoaded(personPopularModel: data));
      } catch (e) {
        emit(
          const PersonPopularError(messageError: "Terjadi Error Bro"),
        );
      }
    });
  }
}
