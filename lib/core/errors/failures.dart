import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String failureMessage;

  const Failure({required this.failureMessage});

  @override
  List<Object?> get props => [failureMessage];
}

class ServerFailure extends Failure {
  const ServerFailure({required super.failureMessage});
}

class CacheFailure extends Failure {
  const CacheFailure({required super.failureMessage});
}
