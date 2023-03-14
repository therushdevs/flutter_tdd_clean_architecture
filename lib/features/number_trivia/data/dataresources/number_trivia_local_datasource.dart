import 'dart:convert';
import 'package:number_trivia_clean_architecture/core/error/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/number_trivia_model.dart';

const String _cachedNumberTrivia = 'cached_number_trivia';
abstract class NumberTriviaLocalDatasource{
  /// gets the cached data from the local storage
  /// Throws a [CacheException] if no cached data is present.
  Future<NumberTriviaModel> getLastNumberTriviaModel();
  Future<void> cacheNumberTriviaModel(NumberTriviaModel triviaToCache);
}

class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDatasource{
  final SharedPreferences pref;
  NumberTriviaLocalDataSourceImpl({required this.pref});

  @override
  Future<NumberTriviaModel> getLastNumberTriviaModel() async{
    final data = pref.getString(_cachedNumberTrivia);
    if (data != null && data.isNotEmpty) {
      final model = NumberTriviaModel.fromJson(json.decode(data));
      return model;
    }else{
      throw CachedException();
    }

  }

  @override
  Future<void> cacheNumberTriviaModel(NumberTriviaModel triviaToCache) async {
     pref.setString(_cachedNumberTrivia, json.encode(triviaToCache.toJson()));
  }

}