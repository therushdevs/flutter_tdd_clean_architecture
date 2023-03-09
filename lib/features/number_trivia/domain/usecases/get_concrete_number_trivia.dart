import 'package:equatable/equatable.dart';
import 'package:number_trivia_clean_architecture/core/error/failures.dart';
import 'package:number_trivia_clean_architecture/core/usecases/usecases.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:dartz/dartz.dart';

class GetConcreteNumberTrivia implements Usecases<NumberTrivia?, Params>{
  final NumberTriviaRepository repository;

  GetConcreteNumberTrivia({required this.repository});

  //we've created it a callable class i.e. we don't need to specifically mention the call methode while calling the methoge.
  //final result = await usecase(number: tNumber); like this we can directly call methode with the class instance.
  @override
  Future<Either<Failures, NumberTrivia>> call(Params params) async{
    return await repository.getConcreteNumberTrivia(params.number);
  }

}

class Params extends Equatable{
  final int number;
  const Params({required this.number}):super();
  @override
  // TODO: implement props
  List<Object?> get props => [number];
}