// import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';

import 'package:annotation/app/cores/network/api_error_model.dart';
import 'package:annotation/app/cores/values/app_environment_variable.dart';
import 'package:annotation/app/cores/values/app_strings.dart';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:device_info/device_info.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData, Response;
import 'package:package_info_plus/package_info_plus.dart';

import '../utils/storage_util.dart';

enum Method { POST, GET, PUT, DELETE, PATCH }

class RestClient extends GetxService {
  late Dio _dio;

  Future<dynamic> delete({
    required String url,
    Map<String, dynamic>? params,
    FormData? formData,
    bool withAuthBearerHeader = true,
  }) async {
    return request(
      url,
      Method.DELETE,
      params,
      formData,
      withAuthBearerHeader: withAuthBearerHeader,
    );
  }

  Future<dynamic> get({
    required String url,
    Map<String, dynamic>? params,
    bool withAuthBearerHeader = true,
  }) async {
    return request(
      url,
      Method.GET,
      params,
      null,
      withAuthBearerHeader: withAuthBearerHeader,
    );
  }

  Future<Map<String, String>> header() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      var ip = '';
      var deviceVersion = '';
      var deviceName = '';
      final timezoneOffset = DateTime.now().timeZoneOffset.toString();
      try {
        ip = await Ipify.ipv4();
      } catch (e) {
        debugPrint('Error retrieving IP');
      }

      if (Platform.isAndroid) {
        final androidInfo = await DeviceInfoPlugin().androidInfo;
        deviceVersion =
            '${androidInfo.version.release} SDK(${androidInfo.version.sdkInt})';
        deviceName = androidInfo.model;
        // Android 9 (SDK 28), Xiaomi Redmi Note 7
      }

      if (Platform.isIOS) {
        final iosInfo = await DeviceInfoPlugin().iosInfo;
        deviceVersion = iosInfo.systemName + iosInfo.systemVersion;
        deviceName = iosInfo.name;
      }
      return {
        // 'Content-Type': 'application/json',
        'Authorization':
            'Bearer ${StorageUtil.getString(LocalStorageKey.ACCESS_TOKEN)}',
        'jotpark-os-type': Platform.isIOS ? 'ios' : 'android',
        'jotpark-ip': ip,
        'jotpark-app-version': packageInfo.version,
        'jotpark-os-version': deviceVersion,
        'jotpark-name': deviceName,
        'jotpark-time-zone': timezoneOffset,
      };
    } catch (e) {
      rethrow;
    }
  }

  Future<RestClient> init() async {
    _dio = Dio(
      BaseOptions(
        baseUrl: EnvVariable.baseUrl,
        headers: await header(),
      ),
    );
    _initInterceptors();
    return this;
  }

  Future<dynamic> patch({
    required String url,
    Map<String, dynamic>? params,
    FormData? formData,
    bool withAuthBearerHeader = true,
  }) async {
    return request(
      url,
      Method.PATCH,
      params,
      formData,
      withAuthBearerHeader: withAuthBearerHeader,
    );
  }

  Future<dynamic> post({
    required String url,
    Map<String, dynamic>? params,
    FormData? formData,
    bool withAuthBearerHeader = true,
  }) async {
    return request(
      url,
      Method.POST,
      params,
      formData,
      withAuthBearerHeader: withAuthBearerHeader,
    );
  }

  Future<dynamic> request(
    String url,
    Method method,
    Map<String, dynamic>? params,
    FormData? formData, {
    bool withAuthBearerHeader = true,
  }) async {
    final stopwatch = Stopwatch()..start();
    Response response;
    if (!withAuthBearerHeader) {
      _dio.options.headers.remove('Authorization');
    }
    try {
      if (method == Method.POST) {
        response = await _dio.post(url, data: params ?? formData);
      } else if (method == Method.DELETE) {
        response = await _dio.delete(
          url,
          data: params ?? formData,
        );
      } else if (method == Method.PATCH) {
        response = await _dio.patch(
          url,
          data: params ?? formData,
        );
      } else {
        response = await _dio.get(
          url,
          queryParameters: params,
        );
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        stopwatch.stop();
        final requestTime = stopwatch.elapsed.inMilliseconds.toString();
        // Get.find<FirebaseAnalyticService>().logEvent(
        //   'api_request',
        //   param: {
        //     'route': url,
        //     'ms': requestTime,
        //   },
        // );
        return response.data;
      } else if (response.statusCode == 401) {
      } else if (response.statusCode == 500 ||
          response.statusCode == 503 ||
          response.statusCode == 502) {
        throw Exception('Server Error');
      } else {
        throw Exception('Something Went Wrong');
      }
    } on SocketException {
      throw Exception('No Internet Connection');
    } on FormatException {
      throw Exception('Bad Response Format!');
    } on DioError catch (e) {
      if ([500, 502, 503].any((x) => x == e.response?.statusCode)) {
        throw 'Internal Server Error';
      } else if (e.response?.statusCode == 409) {
        final errorModel =
            ApiErrorModel.fromJson(e.response?.data as Map<String, dynamic>);
        if (errorModel.code == '') {
          throw 'Something went wrong';
        } else if (errorModel.code == 'C0201') {
          // Get.find<SplashScreenController>().loginAnnonymously();
        } else {
          throw errorModel.message;
        }
      } else {
        throw Exception('Something Went Wrong');
      }
    } catch (e) {
      throw Exception('Something Went Wrong');
    } finally {
      stopwatch.stop();
    }
  }

  void _initInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print('REQUEST[${options.method}] =>'
              'data ${options.data}'
              ' PATH:${options.baseUrl}${options.path}'
              '=> Request Values: ${options.queryParameters}, => HEADERS: ${options.headers}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print('RESPONSE[${response.statusCode}] => DATA: ${response.data}');
          return handler.next(response);
        },
        onError: (err, handler) async {
          print('ERROR[${err.response?.statusCode}]');
          if (err.response?.statusCode == 401) {
            ///Handle token expire
            // if (TokenService.isRefreshTokenExpire) {
            //   await Get.offAllNamed(
            //     Routes.SESSION_EXPIRE,
            //   );
            // } else {
            //   await AuthProvider().refreshToken();
            //   err.requestOptions.headers['Authorization'] =
            //       'Bearer ${StorageUtil.getString(LocalStorageKey.ACCESS_TOKEN)}';
            //   return handler.resolve(await _dio.fetch(err.requestOptions));
            // }
          }
          return handler.next(err);
        },
      ),
    );
  }
}
