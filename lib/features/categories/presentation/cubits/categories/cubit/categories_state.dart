part of 'categories_cubit.dart';

abstract class CategoriesState extends Equatable {
  const CategoriesState();

  @override
  List<Object> get props => [];
}

class CategoriesInitial extends CategoriesState {}

class LoadingCategoriesState extends CategoriesState {}

class SuccessfullyCategoriesLoadedState extends CategoriesState {
  final List<String> categories;

  const SuccessfullyCategoriesLoadedState({required this.categories});
  @override
  List<Object> get props => [categories];
}

class FailedLoadingCategoriesState extends CategoriesState {
  final String failureMessage;

  const FailedLoadingCategoriesState({required this.failureMessage});
  @override
  List<Object> get props => [failureMessage];
}
