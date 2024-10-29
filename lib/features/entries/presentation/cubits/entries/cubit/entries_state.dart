part of 'entries_cubit.dart';

abstract class EntriesState extends Equatable {
  const EntriesState();

  @override
  List<Object> get props => [];
}

class EntriesInitial extends EntriesState {}

class LoadingEntriesState extends EntriesState {}

class SuccessfullyEntriesLoadedState extends EntriesState {
  final List<Entry> entries;

  const SuccessfullyEntriesLoadedState({required this.entries});
  @override
  List<Object> get props => [];
}

class FailedLoadingEntriesState extends EntriesState {
  final String failureMessage;

  const FailedLoadingEntriesState({required this.failureMessage});

  @override
  List<Object> get props => [failureMessage];
}
