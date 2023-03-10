import 'package:dartz/dartz.dart';
import '../error/failures.dart';

class InputConverter{
  Either<Failures,int> stringToUnsignedInteger(String str) {
    try{
      final int input = int.parse(str);
      if (input>= 0){
        return Right(input);
      }else{
        throw const FormatException();
      }
    } on FormatException{
      return Left(InvalidInputFailure());
    }

  }
}

class InvalidInputFailure extends Failures{
  @override
  List<Object?> get props => [];
}