import 'package:clean_architecture_demo_2/core/errors/failures.dart';
import 'package:clean_architecture_demo_2/core/use_case/use_case.dart';
import 'package:clean_architecture_demo_2/features/entries/domain/repositories/entries_repository.dart';
import 'package:dartz/dartz.dart';

import '../entities/entry.dart';

class GetEntriesUseCase extends UseCase<List<Entry>, EntriesParams> {
  final EntriesRepository entriesRepository;

  GetEntriesUseCase({required this.entriesRepository});
  @override
  Future<Either<Failure, List<Entry>>> call(EntriesParams params) =>
      entriesRepository.getEntries(category: params.category);
}
