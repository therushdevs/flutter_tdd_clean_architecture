part of 'number_trivia_bloc.dart';

abstract class NumberTriviaState extends Equatable {
  const NumberTriviaState();
  
  @override
  List<Object> get props => [];
}
class EmptyState extends NumberTriviaState {}

class LoadingState extends NumberTriviaState {}

class LoadedState extends NumberTriviaState {
  final NumberTrivia numberTrivia;
  const LoadedState({required this.numberTrivia});
  @override
  List<Object> get props => [numberTrivia];
}

class ErrorState extends NumberTriviaState {
  final String errorMessage;
  const ErrorState({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
