import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tmdp_movie_app/.secrets/api_keys.dart';

import '../../domain/repository/api_request_repository.dart';
import '../../domain/util/api_general_handler.dart';
import '../constants/const_api_paths.dart';

/// Implementation of `ApiRequestRepository` using [http.Client]
class ApiRequestRepositoryImpl implements ApiRequestRepository {
  ApiRequestRepositoryImpl({
    required this.apiClient,
    required this.apiRequestHandlers,
  });

  /// The API client
  final http.Client apiClient;

  /// The API request errors handler
  final APIRequestHandlers apiRequestHandlers;

  final Map<String, dynamic> defaultHeaders = {
    "Accept": "Application/json",
    "Authorization": "Bearer ${ApiKeys.tmdbApiKey}"
  };

  @override
  Future<Map<String, dynamic>?> getRequest(
    String apiPath, {
    Map<String, String>? headers,
    Function(int)? requestCodesHandler,
  }) async {
    return await _makeRequest(
      request: () async => await apiClient.get(
        Uri.parse(ConstApiPaths.domainLink + apiPath),
        headers: {...defaultHeaders, ...?headers},
      ),
      requestCodesHandler: requestCodesHandler,
    );
  }

  @override
  Future<Map<String, dynamic>?> postRequest(
    String apiPath, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    Function(int)? requestCodesHandler,
  }) async {
    return await _makeRequest(
      request: () async => await apiClient.post(
        Uri.parse(ConstApiPaths.domainLink + apiPath),
        headers: {...defaultHeaders, ...?headers},
        body: jsonEncode(body),
      ),
      requestCodesHandler: requestCodesHandler,
    );
  }

  /// Make the passed API [request] and handle any errors
  Future<Map<String, dynamic>?> _makeRequest({
    required Future<http.Response> Function() request,
    required Function(int)? requestCodesHandler,
  }) async {
    try {
      http.Response response = await request();
      if (response.statusCode != 200) {
        requestCodesHandler?.call(response.statusCode) ??
            apiRequestHandlers.requestException(response);
        return null;
      }
      return jsonDecode(response.body);
    } on http.ClientException catch (requestException) {
      apiRequestHandlers.noResponseRequestException(requestException);
    } catch (otherExceptions) {
      apiRequestHandlers.unknownRequestException(otherExceptions);
    }
    return null;
  }
}
