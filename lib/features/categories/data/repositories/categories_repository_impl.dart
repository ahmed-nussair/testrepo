import 'package:clean_architecture_demo_2/core/errors/exceptions.dart';
import 'package:clean_architecture_demo_2/core/errors/failures.dart';
import 'package:clean_architecture_demo_2/core/network/network_info.dart';
import 'package:clean_architecture_demo_2/core/utils/app_strings.dart';
import 'package:clean_architecture_demo_2/features/categories/data/data_sources/categories_local_data_source.dart';
import 'package:clean_architecture_demo_2/features/categories/data/data_sources/categories_remote_data_source.dart';
import 'package:clean_architecture_demo_2/features/categories/domain/repositories/categories_repository.dart';
import 'package:dartz/dartz.dart';

class CategoriesRepositoryImpl extends CategoriesRepository {
  final NetworkInfo networkInfo;
  final CategoriesRemoteDataSource categoriesRemoteDataSource;
  final CategoriesLocalDataSource categoriesLocalDataSource;

  CategoriesRepositoryImpl({
    required this.networkInfo,
    required this.categoriesRemoteDataSource,
    required this.categoriesLocalDataSource,
  });

  @override
  Future<Either<Failure, List<String>>> getCategories() async {
    if (await networkInfo.isConnected) {
      try {
        final categories = await categoriesRemoteDataSource.getCategories();
        categoriesLocalDataSource.cacheCategories(categories);
        return Right(categories);
      } on ServerException {
        return const Left(
          ServerFailure(failureMessage: AppStrings.defaultServerFailureMessage),
        );
      }
    } else {
      try {
        final categories =
            await categoriesLocalDataSource.getCachedCategories();
        return Right(categories);
      } on CacheException {
        return const Left(
          CacheFailure(failureMessage: AppStrings.defaultCacheFailureMessage),
        );
      }
    }
  }
}
