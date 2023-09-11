import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:data_package/remote/curl_iIntercepter.dart';
import 'package:dio/dio.dart';
import 'package:domain_package/configuration/app_configuration.dart';
import 'package:domain_package/entities/api/api.dart';
import 'package:domain_package/entities/joke/joke_response.dart';
import 'package:domain_package/enums/api.dart';
import 'package:domain_package/utils/domain_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:domain_package/extensions/string_extension.dart';

class ApiController {
  final Dio apiClient;
  final AppConfiguration appConfiguration;

  ApiController({required this.apiClient, required this.appConfiguration, }) {
    apiClient
      ..options.connectTimeout = const Duration(milliseconds: Duration.millisecondsPerMinute)
      ..options.receiveTimeout = const Duration(milliseconds: Duration.millisecondsPerMinute);

    if (kDebugMode) {
      /// curl interceptor
      apiClient.interceptors.add(CurlInterceptor());

      /// log interceptor
      apiClient.interceptors.add(LogInterceptor(
        responseBody: true,
        error: true,
        requestHeader: true,
        responseHeader: true,
        request: true,
        requestBody: true,
        logPrint: (msg) {
          log(msg.toString());
        },
      ));
    }
  }

  Future<Map<String, String>> get _httpHeaders async => {
    'Content-Type': 'application/json',
    'followRedirects': 'false',
    'appOS': Platform.operatingSystem,
    'appVersionCode': await domainUtils.appVersionCode,
    'appVersionName': await domainUtils.appVersionName,
  };

  Future<BaseAppResponse<T>> get<T>(String path, {AppURLsType urlType = AppURLsType.main, Map<String, dynamic> queryParams = const {}, Map<String, String> headers = const {}}) async =>
      processRequest(
        requestOptions: RequestOptions(
          path: '${appConfiguration.appURLs[urlType]}/$path',
          headers: { ...headers },
          method: 'GET',
          queryParameters: queryParams,
        ),
      );

  Future<BaseAppResponse<T>> post<T>(String path, {AppURLsType urlType = AppURLsType.main, Map<String, String> headers = const {}, Object? body}) async =>
      processRequest(
        requestOptions: RequestOptions(
          path: '${appConfiguration.appURLs[urlType]}/$path',
          headers: { ...headers },
          method: 'POST',
          data: body,
        ),
      );

  Future<BaseAppResponse<T>> put<T>(String path, {AppURLsType urlType = AppURLsType.main, Map<String, String> headers = const {}, Object? body}) async =>
      processRequest(
        requestOptions: RequestOptions(
          path: '${appConfiguration.appURLs[urlType]}/$path',
          headers: { ...headers },
          method: 'PUT',
          data: body,
        ),
      );

  Future<BaseAppResponse<T>> processRequest<T>({required RequestOptions requestOptions, int retryCount = 1 }) async {
    BaseAppResponse<T> returnValue = BaseAppResponse();
    try {
      requestOptions.headers.addAll( await _httpHeaders );
      final res = await apiClient.fetch(requestOptions);

      final statusCode = res.statusCode!;
      returnValue.statusCode = statusCode;

      if (statusCode.toString().contains('20')) {
        returnValue.data = _parseResponse<T>(res.data);
      } else {
        returnValue.error = BaseAppError(apiErrorData: res.data);
        _trackFailure(requestOptions, returnValue);
      }
    } on DioException catch(dioError) {
      if (dioError.type == DioExceptionType.badResponse) {
        final res = dioError.response;

        final statusCode = res!.statusCode!;
        returnValue.statusCode = statusCode;

        if ((statusCode == 401 || statusCode == 408) && retryCount < 5) {
          bool isIdTokenUpdated = true; // update the token
          if (isIdTokenUpdated) {
            returnValue = await processRequest(requestOptions: requestOptions, retryCount: retryCount + 1);
          } else {
            returnValue.error = BaseAppError(apiErrorData: res.data, exception: Exception(dioError.toString()));
            _trackFailure(requestOptions, returnValue);
          }
        } else {
          returnValue.error = BaseAppError(apiErrorData: res.data, exception: Exception(dioError.toString()));
          _trackFailure(requestOptions, returnValue);
        }
      } else {
        returnValue.error = BaseAppError(exception: Exception(dioError.toString()));
        _trackFailure(requestOptions, returnValue);
      }
    } catch(e) {
      returnValue.error = BaseAppError(apiErrorData: e.toString(), exception: e);
      _trackFailure(requestOptions, returnValue);
    }

    return returnValue;
  }

  Future<BaseAppResponse<String>> uploadFile(File file, String path, {AppURLsType urlType = AppURLsType.main, Map<String, String> fields = const {}, List<http.MultipartFile> files = const [], int retryCount = 0}) async {
    BaseAppResponse<String> returnValue = BaseAppResponse();

    final url = '${appConfiguration.appURLs[urlType]}/$path';
    try {
      var req = http.MultipartRequest('POST', Uri.parse(url));
      req.fields.addAll(fields);
      req.files.addAll(files);
      final res = await req.send();

      final statusCode = res.statusCode;

      returnValue.statusCode = statusCode;

      if (statusCode.toString().contains('20')) {
        returnValue.data = await res.stream.bytesToString();
      } else if ((statusCode == 401 || statusCode == 408) && retryCount < 5) {
        bool isIdTokenUpdated = true; // update the token
        if (isIdTokenUpdated) {
          returnValue = await uploadFile(file, url, fields: fields, files: files, retryCount: retryCount + 1);
        } else {
          returnValue.error = BaseAppError(apiErrorData: await res.stream.bytesToString());
          _trackFailure(RequestOptions(path: url, headers: {...(await _httpHeaders)}, method: 'POST'), returnValue);
        }
      } else {
        returnValue.error = BaseAppError(apiErrorData: await res.stream.bytesToString());
        _trackFailure(RequestOptions(path: url, headers: {...(await _httpHeaders)}, method: 'POST'), returnValue);
      }
    } catch(e) {
      returnValue.error = BaseAppError(exception: e);
      _trackFailure(RequestOptions(path: url, headers: {...(await _httpHeaders)}, method: 'POST'), returnValue);
    }
    return returnValue;
  }

  T? _parseResponse<T>(dynamic resBody) {
    T? returnValue;
    try {
      final decodedBody = resBody;
      switch(T) {
        case Map:
          returnValue = decodedBody;
          break;

        case List:
          returnValue = decodedBody;
          break;

        case JokeListResponse:
          returnValue = JokeListResponse.fromJson(decodedBody) as T;
          break;
      }
    } catch(e) {
      /// do nothing
    }

    return returnValue;
  }

  void _trackFailure(RequestOptions options, BaseAppResponse baseApiResponse) async {
    try {
      final loggingProperties = {
        'method': options.method,
        'uri': options.uri.toString(),
        'headers': jsonEncode(options.headers),
        'status_code': baseApiResponse.statusCode
      };
      if (options.data != null) {
        loggingProperties['data'] = jsonEncode(options.data);
      }

      final baseApiError = baseApiResponse.error!;
      if (baseApiError.apiErrorData != null) {
        var data = baseApiError.apiErrorData;
        if (data is Map) {
          data = json.encode(data);
        } else if (data is String) {
          /// do nothing
        } else {
          data = data.toString();
        }
        loggingProperties['error_response'] = data;
      }
      if ((baseApiError.exception?.message as String?)?.isNullEmptyOrWhitespace == false) {
        loggingProperties['error_exception'] = baseApiError.exception?.message;
      }
    } catch(e) {
      /// do nothing
    }
  }
}