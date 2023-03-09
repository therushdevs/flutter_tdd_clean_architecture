// Mocks generated by Mockito 5.3.2 from annotations
// in number_trivia_clean_architecture/test/features/number_trivia/data/repositories/number_trivia_repository_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:number_trivia_clean_architecture/core/network/network_info.dart'
    as _i6;
import 'package:number_trivia_clean_architecture/features/number_trivia/data/dataresources/number_trivia_local_datasource.dart'
    as _i5;
import 'package:number_trivia_clean_architecture/features/number_trivia/data/dataresources/number_trivia_remote_datasource.dart'
    as _i3;
import 'package:number_trivia_clean_architecture/features/number_trivia/data/models/number_trivia_model.dart'
    as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeNumberTriviaModel_0 extends _i1.SmartFake
    implements _i2.NumberTriviaModel {
  _FakeNumberTriviaModel_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [NumberTriviaRemoteDatasource].
///
/// See the documentation for Mockito's code generation for more information.
class MockRemoteDataSource extends _i1.Mock
    implements _i3.NumberTriviaRemoteDatasource {
  @override
  _i4.Future<_i2.NumberTriviaModel> getConcreteNumberTrivia(int? number) =>
      (super.noSuchMethod(
        Invocation.method(
          #getConcreteNumberTrivia,
          [number],
        ),
        returnValue:
            _i4.Future<_i2.NumberTriviaModel>.value(_FakeNumberTriviaModel_0(
          this,
          Invocation.method(
            #getConcreteNumberTrivia,
            [number],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.NumberTriviaModel>.value(_FakeNumberTriviaModel_0(
          this,
          Invocation.method(
            #getConcreteNumberTrivia,
            [number],
          ),
        )),
      ) as _i4.Future<_i2.NumberTriviaModel>);
  @override
  _i4.Future<_i2.NumberTriviaModel> getRandomNumberTrivia() =>
      (super.noSuchMethod(
        Invocation.method(
          #getRandomNumberTrivia,
          [],
        ),
        returnValue:
            _i4.Future<_i2.NumberTriviaModel>.value(_FakeNumberTriviaModel_0(
          this,
          Invocation.method(
            #getRandomNumberTrivia,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.NumberTriviaModel>.value(_FakeNumberTriviaModel_0(
          this,
          Invocation.method(
            #getRandomNumberTrivia,
            [],
          ),
        )),
      ) as _i4.Future<_i2.NumberTriviaModel>);
}

/// A class which mocks [NumberTriviaLocalDatasource].
///
/// See the documentation for Mockito's code generation for more information.
class MockLocalDataSource extends _i1.Mock
    implements _i5.NumberTriviaLocalDatasource {
  @override
  _i4.Future<_i2.NumberTriviaModel> getLastNumberTriviaModel() =>
      (super.noSuchMethod(
        Invocation.method(
          #getLastNumberTriviaModel,
          [],
        ),
        returnValue:
            _i4.Future<_i2.NumberTriviaModel>.value(_FakeNumberTriviaModel_0(
          this,
          Invocation.method(
            #getLastNumberTriviaModel,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.NumberTriviaModel>.value(_FakeNumberTriviaModel_0(
          this,
          Invocation.method(
            #getLastNumberTriviaModel,
            [],
          ),
        )),
      ) as _i4.Future<_i2.NumberTriviaModel>);
  @override
  _i4.Future<void> cacheNumberTriviaModel(
          _i2.NumberTriviaModel? triviaToCache) =>
      (super.noSuchMethod(
        Invocation.method(
          #cacheNumberTriviaModel,
          [triviaToCache],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
}

/// A class which mocks [NetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkInfo extends _i1.Mock implements _i6.NetworkInfo {
  @override
  _i4.Future<bool> get isConnected => (super.noSuchMethod(
        Invocation.getter(#isConnected),
        returnValue: _i4.Future<bool>.value(false),
        returnValueForMissingStub: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);
}
