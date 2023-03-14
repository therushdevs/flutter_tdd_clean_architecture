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

const urlNumberTrivia = 'http://numbersapi.com';
typedef getConcreteOrRandom =  Future<http.Response> Function();

class NumberTriviaRemoteDatasourceImpl implements NumberTriviaRemoteDatasource{
  final http.Client httpClient;
  NumberTriviaRemoteDatasourceImpl({required this.httpClient});

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) async{
    return _getRemoteData(()  =>  httpClient.get(Uri.parse('$urlNumberTrivia/$number'), headers: {
      'Content-Type' : 'application/json',
    }));
  }

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() {
    return _getRemoteData(()  =>  httpClient.get(Uri.parse('$urlNumberTrivia/random'), headers: {
    'Content-Type' : 'application/json',
    }));
  }

  Future<NumberTriviaModel> _getRemoteData(getConcreteOrRandom getData) async{
    final response = await getData();
    if (response.statusCode == 200){
     NumberTriviaModel numberTriviaModel = NumberTriviaModel.fromJson(jsonDecode(response.body));
      return numberTriviaModel;
    }else{
      throw ServerException();
    }
  }



}