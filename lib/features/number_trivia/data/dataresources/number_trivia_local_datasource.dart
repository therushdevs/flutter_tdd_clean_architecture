import '../models/number_trivia_model.dart';

abstract class NumberTriviaLocalDatasource{
  /// gets the cached data from the local storage
  /// Throws a [CacheException] if no cached data is present.
  Future<NumberTriviaModel> getLastNumberTriviaModel();
  Future<void> cacheNumberTriviaModel(NumberTriviaModel triviaToCache);
}