import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia_clean_architecture/core/utils/imput_converter.dart';


void main(){
  late InputConverter inputConverter;

  setUp(() {
    inputConverter = InputConverter();
  });

  test('should return an integer when string represents an unsigned integer', () {
  //  arrange
    const String tNumber = '1';
  //  act
    final result = inputConverter.stringToUnsignedInteger(tNumber);
  //  assert
    expect(result, const Right(1));
  });

  test('should return a failure when the string is a not an integer', () {
    //  arrange
    const String tNumber = 'abc';
    //  act
    final result = inputConverter.stringToUnsignedInteger(tNumber);
    //  assert
    expect(result,  Left(InvalidInputFailure()));
  });

  test('should return a failure when the string is a negative integer', () {
    //  arrange
    const String tNumber = '-5';
    //  act
    final result = inputConverter.stringToUnsignedInteger(tNumber);
    //  assert
    expect(result,  Left(InvalidInputFailure()));
  });

}