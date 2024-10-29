import 'dart:convert';

import 'package:clean_architecture_demo_2/core/errors/exceptions.dart';
import 'package:clean_architecture_demo_2/core/utils/app_strings.dart';
import 'package:clean_architecture_demo_2/features/entries/data/models/EntryModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class EntriesLocalDataSource {
  Future<List<EntryModel>> getCachedEntries({required String category});
  Future<void> cacheEntries({
    required String category,
    required List<EntryModel> entries,
  });
}

class SPEntriesLocalDataSource extends EntriesLocalDataSource {
  final SharedPreferences sharedPreferences;

  SPEntriesLocalDataSource({required this.sharedPreferences});

  @override
  Future<void> cacheEntries({
    required String category,
    required List<EntryModel> entries,
  }) async {
    await sharedPreferences.setString(
      '${AppStrings.cachedEntries}#$category',
      json.encode(entries),
    );
  }

  @override
  Future<List<EntryModel>> getCachedEntries({required String category}) async {
    final entries =
        sharedPreferences.getString('${AppStrings.cachedEntries}#$category');
    if (entries != null) {
      return (json.decode(entries) as List)
          .map((e) => EntryModel.fromJson(e))
          .toList();
    }
    throw CacheException(
      message: AppStrings.defaultCacheExceptionMessage,
    );
  }
}
