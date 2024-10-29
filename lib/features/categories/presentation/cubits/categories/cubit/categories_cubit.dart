import 'package:clean_architecture_demo_2/core/use_case/use_case.dart';
import 'package:clean_architecture_demo_2/features/categories/domain/use_cases/get_categories_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final GetCategoriesUseCase getCategoriesUseCase;

  CategoriesCubit({required this.getCategoriesUseCase})
      : super(CategoriesInitial());

  Future<void> loadCategories() async {
    emit(LoadingCategoriesState());
    final categories = await getCategoriesUseCase(NoParams());

    categories.fold(
      (l) =>
          emit(FailedLoadingCategoriesState(failureMessage: l.failureMessage)),
      (r) => emit(
        SuccessfullyCategoriesLoadedState(categories: r),
      ),
    );
  }
}
