import 'package:clean_architecture_demo_2/core/utils/app_strings.dart';
import 'package:clean_architecture_demo_2/features/categories/domain/use_cases/get_categories_use_case.dart';
import 'package:clean_architecture_demo_2/features/categories/presentation/cubits/categories/cubit/categories_cubit.dart';
import 'package:clean_architecture_demo_2/features/categories/presentation/screens/categories_screen.dart';
import 'package:clean_architecture_demo_2/features/entries/domain/use_cases/get_entries_use_case.dart';
import 'package:clean_architecture_demo_2/features/entries/presentation/cubits/entries/cubit/entries_cubit.dart';
import 'package:clean_architecture_demo_2/features/entries/presentation/screens/entries_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../injector.dart';

class AppRoutes {
  static final goRouter = GoRouter(
    initialLocation: AppStrings.routeCategories,
    routes: _routes,
  );
  static final List<GoRoute> _routes = [
    GoRoute(
      name: categories,
      path: AppStrings.routeCategories,
      builder: (context, state) => BlocProvider(
        create: (_) =>
            CategoriesCubit(getCategoriesUseCase: sl<GetCategoriesUseCase>())
              ..loadCategories(),
        child: const CategoriesScreen(),
      ),
      routes: _categoriesRoutes,
    )
  ];

  static List<RouteBase> get _categoriesRoutes {
    return [
      GoRoute(
        name: entries,
        path: '${AppStrings.routeEntries}/:categoryName',
        builder: (context, state) => BlocProvider(
          create: (_) =>
              EntriesCubit(getEntriesUseCase: sl<GetEntriesUseCase>())
                ..loadEntries(state.params[AppStrings.categoryName]!),
          child: EntriesScreen(
              categoryName: state.params[AppStrings.categoryName]!),
        ),
      ),
    ];
  }

  static String categories = UniqueKey().toString();
  static String entries = UniqueKey().toString();
}
