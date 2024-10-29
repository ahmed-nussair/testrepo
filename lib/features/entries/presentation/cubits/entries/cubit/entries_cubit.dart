import 'package:clean_architecture_demo_2/core/use_case/use_case.dart';
import 'package:clean_architecture_demo_2/features/entries/domain/use_cases/get_entries_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/entry.dart';

part 'entries_state.dart';

class EntriesCubit extends Cubit<EntriesState> {
  final GetEntriesUseCase getEntriesUseCase;
  EntriesCubit({
    required this.getEntriesUseCase,
  }) : super(EntriesInitial());

  Future<void> loadEntries(String category) async {
    emit(LoadingEntriesState());
    final entries = await getEntriesUseCase(EntriesParams(category: category));

    entries.fold(
      (l) => emit(
        FailedLoadingEntriesState(failureMessage: l.failureMessage),
      ),
      (r) => emit(
        SuccessfullyEntriesLoadedState(entries: r),
      ),
    );
  }
}
