import 'package:clean_architecture_demo_2/config/routes/app_routes.dart';
import 'package:clean_architecture_demo_2/core/utils/app_strings.dart';
import 'package:clean_architecture_demo_2/features/categories/presentation/cubits/categories/cubit/categories_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<CategoriesCubit, CategoriesState>(
          builder: (context, state) {
            if (state is SuccessfullyCategoriesLoadedState) {
              return ListView.separated(
                itemBuilder: (context, index) => InkWell(
                  onTap: () => context.pushNamed(
                    AppRoutes.entries,
                    params: {
                      AppStrings.categoryName: state.categories[index],
                    },
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      state.categories[index],
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                separatorBuilder: (context, index) => const Divider(),
                itemCount: 10,
              );
            }

            if (state is LoadingCategoriesState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is FailedLoadingCategoriesState) {
              return Center(
                child: Text(
                  state.failureMessage,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
