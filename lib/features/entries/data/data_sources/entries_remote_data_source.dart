import 'dart:convert';

import 'package:clean_architecture_demo_2/core/api/base_url.dart';
import 'package:clean_architecture_demo_2/core/api/end_points.dart';
import 'package:clean_architecture_demo_2/core/errors/exceptions.dart';
import 'package:clean_architecture_demo_2/features/entries/data/models/EntryModel.dart';
import 'package:dio/dio.dart';
import 'package:http_status_code/http_status_code.dart';

import '../../../../core/utils/app_strings.dart';
import 'package:http/http.dart' as http;

abstract class EntriesRemoteDataSource {
  Future<List<EntryModel>> getEntries({required String category});
}

class HttpEntriesRemoteDataSource extends EntriesRemoteDataSource {
  @override
  Future<List<EntryModel>> getEntries({required String category}) async {
    final uri = Uri.parse('$baseUrl${EndPoints.entries}?category=$category');
    final response = await http.get(uri);
    if (response.statusCode == StatusCode.OK) {
      return List<EntryModel>.from(
        (json.decode(response.body)['entries'] as List).map(
          (e) => EntryModel.fromJson(e),
        ),
      ).toList();
    }
    throw ServerException(message: AppStrings.defaultServerExceptionMessage);
  }
}

class DioEntriesRemoteDataSource extends EntriesRemoteDataSource {
  @override
  Future<List<EntryModel>> getEntries({required String category}) async {
    final response =
        await Dio().get('$baseUrl${EndPoints.entries}?category=$category');
    if (response.statusCode == StatusCode.OK) {
      return List<EntryModel>.from(
        (response.data['entries'] as List)
            .map(
              (e) => EntryModel.fromJson(e),
            )
            .toList(),
      );
    }
    throw ServerException(message: AppStrings.defaultServerExceptionMessage);
  }
}
