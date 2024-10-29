import 'dart:convert';

import 'package:clean_architecture_demo_2/core/errors/exceptions.dart';
import 'package:clean_architecture_demo_2/core/utils/app_strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CategoriesLocalDataSource {
  Future<void> cacheCategories(List<String> categories);
  Future<List<String>> getCachedCategories();
}

class SPCategoriesLocalDataSource extends CategoriesLocalDataSource {
  final SharedPreferences sharedPreferences;

  SPCategoriesLocalDataSource({required this.sharedPreferences});

  @override
  Future<void> cacheCategories(List<String> categories) async {
    await sharedPreferences.setString(
        AppStrings.cachedCategories, json.encode(categories));
  }

  @override
  Future<List<String>> getCachedCategories() async {
    final categories = sharedPreferences.getString(AppStrings.cachedCategories);
    if (categories != null) {
      return (json.decode(categories) as List)
          .map((e) => e.toString())
          .toList();
    }
    throw CacheException(message: AppStrings.defaultCacheExceptionMessage);
  }
}
