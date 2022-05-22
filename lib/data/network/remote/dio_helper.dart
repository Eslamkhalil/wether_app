import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:wether_app/data/models/current_weather.dart';

import '../../../constants/end_point.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        receiveTimeout: 1000 * 20,
        connectTimeout: 1000 * 20,
        receiveDataWhenStatusError: true,
      ),
    );

    final ioc =  HttpClient();
    ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }


  Future<dynamic> fetchWeatherDataByCity(
      {required String url, required Map<String, dynamic> query}) async {
    try {
      final response = await dio.get(url, queryParameters: query);
      if (kDebugMode) {
        print("response Dio Helper  :  ${response.data.toString()}");
      }
      return response.data;

    } catch (e) {
      if (kDebugMode) {
        print("response Error Dio Helper:  ${e.toString()}");
      }
    }
  }

  Future<dynamic> fetchWeatherDataByLocation(
      {required String url, required Map<String, dynamic> query}) async {
    try {
      final response = await dio.get(url, queryParameters: query);
      if (kDebugMode) {
        print("response Dio Helper  :  ${response.data.toString()}");
      }
      return response.data;

    } catch (e) {
      if (kDebugMode) {
        print("response Error Dio Helper:  ${e.toString()}");
      }
    }
  }
}
