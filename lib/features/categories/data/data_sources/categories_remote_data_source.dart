import 'dart:convert';

import 'package:clean_architecture_demo_2/core/api/base_url.dart';
import 'package:clean_architecture_demo_2/core/api/end_points.dart';
import 'package:clean_architecture_demo_2/core/errors/exceptions.dart';
import 'package:clean_architecture_demo_2/core/utils/app_strings.dart';
import 'package:dio/dio.dart';

import 'package:http/http.dart' as http;
import 'package:http_status_code/http_status_code.dart';

abstract class CategoriesRemoteDataSource {
  Future<List<String>> getCategories();
}

class HttpCategoriesRemoteDataSource extends CategoriesRemoteDataSource {
  @override
  Future<List<String>> getCategories() async {
    final uri = Uri.parse('$baseUrl${EndPoints.categories}');
    final response = await http.get(
      uri,
      headers: {
        AppStrings.contentType: AppStrings.applicationJson,
      },
    );
    if (response.statusCode == StatusCode.OK) {
      return List<String>.from(
        json.decode(response.body)['categories'],
      );
    }
    throw ServerException(message: AppStrings.defaultServerExceptionMessage);
  }
}

class DioCategoriesRemoteDataSource extends CategoriesRemoteDataSource {
  @override
  Future<List<String>> getCategories() async {
    final response = await Dio().get('$baseUrl${EndPoints.categories}');
    if (response.statusCode == StatusCode.OK) {
      return (response.data['categories'] as List)
          .map((e) => e.toString())
          .toList();
    }
    throw ServerException(message: AppStrings.defaultServerExceptionMessage);
  }
}
