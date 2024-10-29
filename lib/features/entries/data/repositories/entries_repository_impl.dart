import 'package:clean_architecture_demo_2/core/errors/exceptions.dart';
import 'package:clean_architecture_demo_2/core/network/network_info.dart';
import 'package:clean_architecture_demo_2/core/utils/app_strings.dart';
import 'package:clean_architecture_demo_2/features/entries/data/data_sources/entries_local_data_source.dart';
import 'package:clean_architecture_demo_2/features/entries/data/data_sources/entries_remote_data_source.dart';
import 'package:clean_architecture_demo_2/features/entries/domain/entities/entry.dart';
import 'package:clean_architecture_demo_2/core/errors/failures.dart';
import 'package:clean_architecture_demo_2/features/entries/domain/repositories/entries_repository.dart';
import 'package:dartz/dartz.dart';

class EntriesRepositoryImpl extends EntriesRepository {
  final NetworkInfo networkInfo;
  final EntriesRemoteDataSource entriesRemoteDataSource;
  final EntriesLocalDataSource entriesLocalDataSource;

  EntriesRepositoryImpl({
    required this.networkInfo,
    required this.entriesRemoteDataSource,
    required this.entriesLocalDataSource,
  });

  @override
  Future<Either<Failure, List<Entry>>> getEntries(
      {required String category}) async {
    if (await networkInfo.isConnected) {
      try {
        final entries =
            await entriesRemoteDataSource.getEntries(category: category);
        entriesLocalDataSource.cacheEntries(
            category: category, entries: entries);
        return Right(entries);
      } on ServerException {
        return const Left(
          ServerFailure(failureMessage: AppStrings.defaultServerFailureMessage),
        );
      }
    } else {
      try {
        final entries =
            await entriesLocalDataSource.getCachedEntries(category: category);
        return Right(entries);
      } on CacheException {
        return const Left(
          CacheFailure(failureMessage: AppStrings.defaultCacheFailureMessage),
        );
      }
    }
  }
}
