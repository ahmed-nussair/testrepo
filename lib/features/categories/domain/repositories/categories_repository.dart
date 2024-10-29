import 'package:clean_architecture_demo_2/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

abstract class CategoriesRepository {
  Future<Either<Failure, List<String>>> getCategories();
}
