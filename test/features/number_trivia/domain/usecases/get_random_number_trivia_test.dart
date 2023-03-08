import 'package:dartz/dartz.dart';
import 'package:number_trivia_clean_architecture/core/usecases/usecases.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/domain/usecases/get_random_number_trivia.dart';

class MockNumberTriviaRepository extends Mock implements NumberTriviaRepository{
}
//@GenerateMocks([], customMocks: [MockSpec<MethodChannel>(as: #MockMethodChannel)])
// @GenerateMocks([NumberTriviaRepository])
void main(){

  late MockNumberTriviaRepository mockNumberTriviaRepository;
  late GetRandomNumberTrivia usecase;

  //this function runs before running all the programme so initializing the variables
  //is kind of a nice option.
  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase =  GetRandomNumberTrivia(repository: mockNumberTriviaRepository);
  });

  const tNumber = 21;
  const tNumberTrivia = NumberTrivia(text: "should return a numberTrivia instance", number: 21);
  test('should get trivia for the number from the repository', () async{

    //  arrange - will actually writing the execution of the function & expecting the result
    when(mockNumberTriviaRepository.getRandomNumberTrivia())
        .thenAnswer((realInvocation) async => const Right(tNumberTrivia));

    //  act - calling the actual defined methode i.e. in production & not in the test methode to get the result
    final result = await usecase(NoParams());

    //  assert - checking if the result we are getting from the actual function matches with the test result.
    expect(result, const Right(tNumberTrivia));
    //Ensuring the number is called with the same number as tNumber
    verify(mockNumberTriviaRepository.getRandomNumberTrivia());
    verifyNoMoreInteractions(mockNumberTriviaRepository);
  });
}