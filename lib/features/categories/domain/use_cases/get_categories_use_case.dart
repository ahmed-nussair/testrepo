import 'package:clean_architecture_demo_2/core/errors/failures.dart';
import 'package:clean_architecture_demo_2/core/use_case/use_case.dart';
import 'package:clean_architecture_demo_2/features/categories/domain/repositories/categories_repository.dart';
import 'package:dartz/dartz.dart';

class GetCategoriesUseCase extends UseCase<List<String>, NoParams> {
  final CategoriesRepository categoriesRepository;

  GetCategoriesUseCase({required this.categoriesRepository});
  @override
  Future<Either<Failure, List<String>>> call(NoParams params) =>
      categoriesRepository.getCategories();
}
