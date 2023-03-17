import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:myapp/configuration/app_config.model.dart';
import 'package:myapp/core/core_models/app_context/app_context.model.dart';
import 'package:myapp/core/exceptions/exceptions.dart';
import 'package:myapp/core/exceptions/index.dart';
import 'package:myapp/core/network/http.model.dart';

import '../dependency_injection/injector.dart';
import 'http_interceptor.service.dart';

class HttpService {
  static Dio _dio = Dio();

  HttpService() {
    var appConfiguration = Injector.get<AppConfiguration>();

    var options = BaseOptions(
      baseUrl: appConfiguration.oAuthConfig.baseUrl,
      contentType: Headers.jsonContentType,
    );
    this.dio.options = options;
    if (this.dio.interceptors.isEmpty) {
      this.dio.interceptors.add(HttpInterceptor.getInstance());
    }
  }

  Future<dynamic> get(String path, {Map<String, dynamic>? queryParams}) async {
    this.dio.options.headers = headers;
    try {
      var response = await this.dio.get(path, queryParameters: queryParams);
      return response.data;
    } on DioError catch (e) {
      this._handleHttpError(e);
    }
  }

  Future<dynamic> post(String path, dynamic body,
      {Map<String, dynamic>? queryParams}) async {
    this.dio.options.headers = headers;

    try {
      var response = await this.dio.post(
            path,
            data: body,
            queryParameters: queryParams,
          );
      return response.data;
    } on DioError catch (e) {
      this._handleHttpError(e);
    }
  }

  Future<dynamic> pdfPost(String path, dynamic body,
      {Map<String, dynamic>? queryParams}) async {
    this.dio.options.headers = headers;

    try {
      var response = await this.dio.post(path,
          data: body,
          queryParameters: queryParams,
          options: Options(
            responseType: ResponseType.bytes,
          ));
      return response.data;
    } on DioError catch (e) {
      this._handleHttpError(e);
    }
  }

  Future<dynamic> put(String path, dynamic body,
      {Map<String, dynamic>? queryParams}) async {
    try {
      this.dio.options.headers = headers;
      var response =
          await this.dio.put(path, data: body, queryParameters: queryParams);
      return response.data;
    } on DioError catch (e) {
      this._handleHttpError(e);
    }
  }

  Future<dynamic> delete(String path, dynamic body,
      {Map<String, dynamic>? queryParams}) async {
    try {
      this.dio.options.headers = headers;
      var response = await this
          .dio
          .delete(path, data: jsonEncode(body), queryParameters: queryParams);
      return response.data;
    } on DioError catch (e) {
      this._handleHttpError(e);
    }
  }

  Map<String, dynamic> get headers {
    AppContext appContext = Injector.get<AppContext>();
    var appConfig = Injector.get<AppConfiguration>();
    var requestHeaders = {
      HttpKeys.contentType: 'application/json',
    };

    String token = appContext.token == null
        ? 'Basic '
        : 'bearer ${appContext.token?.access_token}';
    requestHeaders.putIfAbsent(HttpKeys.authorization, () => token);

    return requestHeaders;
  }

  void setContentType(String? contentType) {
    this.dio.options.contentType = contentType;
  }

  void setInterceptorStatus(bool shouldIntercept) {
    if (!shouldIntercept) {
      this.dio.interceptors.clear();
    }
  }

  void _handleHttpError(DioError e) {
    if (e.type == DioErrorType.unknown) throw NoInternetException();

    if (e.type == DioErrorType.cancel) return null;

    if (e.type == DioErrorType.badResponse) {
      if (e.response!.statusCode == 400) {
        var exception = CustomException.fromJson(e.response!.data);
        throw BadRequestException(ex: exception);
      }
      if (e.response!.statusCode == 401) {
        var exception = CustomException.fromJson(e.response!.data);

        throw UnAuthorizedException(ex: exception);
      }
      if (e.response!.statusCode == 403) {
        throw ForbiddenException();
      }
      if (e.response!.statusCode == 500) {
        throw ServerException();
      }

      // If the exception above didn't satisfy, treating it as Timeout exception.
      if (e.response!.statusCode != 404) {
        throw TimedOutException();
      }
    }
  }

  String get baseUrl => this.dio.options.baseUrl;

  Dio get dio => _dio;
}
