import 'package:clean_architecture_demo_2/features/entries/domain/entities/entry.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';

abstract class EntriesRepository {
  Future<Either<Failure, List<Entry>>> getEntries({required String category});
}
