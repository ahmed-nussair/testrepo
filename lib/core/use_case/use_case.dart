import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../errors/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}

class EntriesParams extends Equatable {
  final String category;

  const EntriesParams({required this.category});
  @override
  List<Object?> get props => [category];
}
