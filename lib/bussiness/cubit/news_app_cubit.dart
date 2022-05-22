import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wether_app/data/models/current_weather.dart';

import '../../data/models/weather_forecast_model.dart';
import '../../data/repository/current_location.dart';
import '../../data/repository/current_weather_repository.dart';
import '../../presention/layout/search_screen.dart';
import '../../presention/layout/settings_screen.dart';
import '../../presention/layout/wether_screen.dart';
import 'news_app_state.dart';

class WeatherAppCubit extends Cubit<WeatherAppState> {
  final CurrentWeatherRepository currentWeatherRepository;
  final CurrentLocationRepository currentLocationRepository;

  WeatherAppCubit(
      {required this.currentWeatherRepository,
      required this.currentLocationRepository})
      : super(WeatherAppStateInitial());

  static WeatherAppCubit get(context) => BlocProvider.of(context);

  var lat = 0.0;
  var lang = 0.0;
  WeatherModel? weather;
  WeatherForecastModel? forecastWeather;
  List<Hour> hours = [];
  List<WeatherModel> addedLocations = [];
  int currentScreenIndex = 0;

  List<Widget> screens = [
    const WeatherScreen(),
    SearchScreen(),
    const SettingsScreen(),
  ];

  void changeScreen(int index) {
    currentScreenIndex = index;
    if (index == 0) {
      updateUserLocation();
    }

    emit(WeatherAppStateBottomIndexChange());
  }

  Future<void> updateUserLocation() async {
    Position? position = await currentLocationRepository.determinePosition();
    lat = position.latitude;
    lang = position.longitude;
    debugPrint('lat: $lat, lon: $lang');
    getCurrentWeatherByLocation(lat, lang);
  }

  void getCurrentWeatherByLocation(double lat, double lang) async {
    emit(WeatherAppStateLoading());

    try {
      forecastWeather = await currentWeatherRepository
          .fetchWeatherDataByLocation(lat: lat, long: lang);

      forecastWeather!.forecast!.forecastday!.forEach((element) {
        hours = element.hour!.toList();
      });
      if (kDebugMode) {
        print('cubit Weather : ${forecastWeather!.location!.country}');
      }

      emit(WeatherAppStateLoaded(weather: forecastWeather!));
    } catch (e) {
      if (kDebugMode) {
        print("Error cubit : ${e.toString()}");
        print("Error cubit : ${hours.toString()}");
      }
      emit(WeatherAppStateError(e.toString()));
    }
  }
  void getCurrentWeather(String city) async {
    emit(FetchByCityLoading());

    try {
       weather =
      await currentWeatherRepository.fetchWeatherDataByCity(city: city);
       addedLocations.add(weather!);
      if (kDebugMode) {
        print('cubit Weather : ${weather!.location!.country}');
      }
      emit(FetchByCityLoaded());
    } catch (e) {

      if (kDebugMode) {
        print("Error cubit : ${e.toString()}");
      }
      emit(FetchByCityError(e.toString()));
    }
  }
}


/*  emit(NewsAppStateLoading());
    weather=  await currentWeatherRepository
        .fetchWeatherDataByCity(city: city)
        .then((value) {
      weather = WeatherModel.fromJson(value);
      if (kDebugMode) {
        print('cubit Weather : {$value}');
      }
      emit(NewsAppStateLoaded(weather: value));
    }).catchError((onError) {
      if (kDebugMode) {
        print("Error cubit : ${onError.toString()}");
      }
      emit(NewsAppStateError(onError.toString()));
    });
  }*/
