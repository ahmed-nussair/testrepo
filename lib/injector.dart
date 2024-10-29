import 'package:clean_architecture_demo_2/core/network/network_info.dart';
import 'package:clean_architecture_demo_2/features/categories/data/data_sources/categories_local_data_source.dart';
import 'package:clean_architecture_demo_2/features/categories/data/data_sources/categories_remote_data_source.dart';
import 'package:clean_architecture_demo_2/features/categories/data/repositories/categories_repository_impl.dart';
import 'package:clean_architecture_demo_2/features/categories/domain/repositories/categories_repository.dart';
import 'package:clean_architecture_demo_2/features/categories/domain/use_cases/get_categories_use_case.dart';
import 'package:clean_architecture_demo_2/features/categories/presentation/cubits/categories/cubit/categories_cubit.dart';
import 'package:clean_architecture_demo_2/features/entries/data/data_sources/entries_local_data_source.dart';
import 'package:clean_architecture_demo_2/features/entries/data/data_sources/entries_remote_data_source.dart';
import 'package:clean_architecture_demo_2/features/entries/data/repositories/entries_repository_impl.dart';
import 'package:clean_architecture_demo_2/features/entries/domain/repositories/entries_repository.dart';
import 'package:clean_architecture_demo_2/features/entries/domain/use_cases/get_entries_use_case.dart';
import 'package:clean_architecture_demo_2/features/entries/presentation/cubits/entries/cubit/entries_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.I;

Future<void> initInjections() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
      connectionChecker: sl(),
    ),
  );
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(
    () => CategoriesCubit(
      getCategoriesUseCase: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => GetCategoriesUseCase(
      categoriesRepository: sl(),
    ),
  );
  sl.registerLazySingleton<CategoriesRepository>(
    () => CategoriesRepositoryImpl(
      networkInfo: sl(),
      categoriesRemoteDataSource: sl(),
      categoriesLocalDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<CategoriesRemoteDataSource>(
    () => HttpCategoriesRemoteDataSource(),
  );
  sl.registerLazySingleton<CategoriesLocalDataSource>(
    () => SPCategoriesLocalDataSource(
      sharedPreferences: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => EntriesCubit(
      getEntriesUseCase: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => GetEntriesUseCase(
      entriesRepository: sl(),
    ),
  );

  sl.registerLazySingleton<EntriesRepository>(
    () => EntriesRepositoryImpl(
      networkInfo: sl(),
      entriesRemoteDataSource: sl(),
      entriesLocalDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<EntriesRemoteDataSource>(
    () => HttpEntriesRemoteDataSource(),
  );

  sl.registerLazySingleton<EntriesLocalDataSource>(
    () => SPEntriesLocalDataSource(
      sharedPreferences: sl(),
    ),
  );
}
