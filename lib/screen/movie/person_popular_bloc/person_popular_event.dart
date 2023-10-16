part of 'person_popular_bloc.dart';

sealed class PersonPopularEvent extends Equatable {
  const PersonPopularEvent();
}

class GetPersonPopularEvent extends PersonPopularEvent {
  @override
  List<Object> get props => [];
}
