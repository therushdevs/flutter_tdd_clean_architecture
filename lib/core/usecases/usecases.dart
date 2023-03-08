import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../error/failures.dart';

//Params has no use in this application but it is very helpful to access the prameters
//that are passed in.
abstract class Usecases<Type, Params>{
  Future<Either<Failures, Type>?>? call(Params params);
}

class NoParams extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props =>[];
}
