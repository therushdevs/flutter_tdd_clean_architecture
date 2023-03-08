import 'package:equatable/equatable.dart';

abstract class Failures extends Equatable{
  const Failures([List properties = const <dynamic>[]]) : super();
}

class ServerFailure extends Failures{
  @override
  List<Object?> get props => [];
}

class CachedFailure extends Failures{
  @override
  List<Object?> get props => [];
}
