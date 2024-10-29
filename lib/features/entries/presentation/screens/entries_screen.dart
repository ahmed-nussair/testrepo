import 'package:clean_architecture_demo_2/features/entries/presentation/cubits/entries/cubit/entries_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EntriesScreen extends StatelessWidget {
  final String categoryName;
  const EntriesScreen({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(categoryName),
        ),
        body: BlocBuilder<EntriesCubit, EntriesState>(
          builder: (context, state) {
            if (state is SuccessfullyEntriesLoadedState) {
              return ListView.separated(
                itemBuilder: (context, index) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.entries[index].api),
                    Text(state.entries[index].description),
                  ],
                ),
                separatorBuilder: (context, index) => const Divider(),
                itemCount: state.entries.length,
              );
            }
            if (state is LoadingEntriesState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is FailedLoadingEntriesState) {
              return Center(
                child: Text(
                  state.failureMessage,
                  textAlign: TextAlign.center,
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
