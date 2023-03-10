import 'dart:convert';

import 'package:number_trivia_clean_architecture/core/error/exceptions.dart';

import '../models/number_trivia_model.dart';
import 'package:http/http.dart' as http;

abstract class NumberTriviaRemoteDatasource{
  /// calls the http://numbersapi.com/{number} endpoint
  /// Throws a [ServerException] for all error codes.
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);

  /// calls the http://numbersapi.com/random endpoint
  ///   /// Throws a [ServerException] for all error codes.
  Future<NumberTriviaModel> getRandomNumberTrivia();
}

const urlNumberTrivia = 'http://numbersapi.com/';
class NumberTriviaRemoteDatasourceImpl implements NumberTriviaRemoteDatasource{
  final http.Client httpClient;
  NumberTriviaRemoteDatasourceImpl({required this.httpClient});

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) async{
    final response = await httpClient.get(Uri.parse('$urlNumberTrivia/$number'), headers: {
      'Content-Type' : 'application/json',
    });
    if (response.statusCode == 200){
      late NumberTriviaModel numberTriviaModel = NumberTriviaModel.fromJson(jsonDecode(response.body));
      return numberTriviaModel;
    }else{
      throw ServerException();
    }

  }

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() {
    // TODO: implement getRandomNumberTrivia
    throw UnimplementedError();
  }
  
  
}