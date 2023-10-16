part of 'person_popular_bloc.dart';

sealed class PersonPopularState extends Equatable {
  const PersonPopularState();
}

final class PersonPopularLoading extends PersonPopularState {
  @override
  List<Object> get props => [];
}

final class PersonPopularLoaded extends PersonPopularState {
  final PersonPopularModel personPopularModel;

  const PersonPopularLoaded({required this.personPopularModel});
  @override
  List<Object> get props => [personPopularModel];
}

final class PersonPopularError extends PersonPopularState {
  final String messageError;

  const PersonPopularError({required this.messageError});

  @override
  List<Object> get props => [messageError];
}
