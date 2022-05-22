import 'package:flutter/foundation.dart';
import 'package:wether_app/data/models/current_weather.dart';
import 'package:wether_app/data/network/remote/dio_helper.dart';

import '../../constants/end_point.dart';
import '../models/weather_forecast_model.dart';

class CurrentWeatherRepository {
  late final DioHelper dioHelper;

  CurrentWeatherRepository(
      {required this.dioHelper}); // Method: getCurrentWeather

  Future<WeatherModel> fetchWeatherDataByCity({required String city}) async {
    final weather = await dioHelper.fetchWeatherDataByCity(
      url: 'v1/current.json',
      query: {'key': apiKey, 'q': city},
    ).catchError((onError){
      if (kDebugMode) {
        print("Error fetchWeatherDataByCity: ${onError.toString()}");
      }
    });
    return WeatherModel.fromJson(weather);
  }

    Future<WeatherForecastModel> fetchWeatherDataByLocation({required double lat ,required double long}) async {
    final weatherForeCast = await dioHelper.fetchWeatherDataByCity(
      url: 'v1/forecast.json',
      query: {'key': apiKey, 'q': '$lat'',''$long','days':7 ,'api' :'no' ,'alerts' :'no'},
    );
    debugPrint('weatherForeCast Repository : $weatherForeCast');
    return WeatherForecastModel.fromJson(weatherForeCast);
  }
}
