import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wether_app/presention/screens/home.dart';
import 'package:wether_app/presention/layout/wether_screen.dart';

import 'bussiness/cubit/news_app_cubit.dart';
import 'constants/route.dart';
import 'data/network/remote/dio_helper.dart';
import 'data/repository/current_location.dart';
import 'data/repository/current_weather_repository.dart';

class AppRouter {
  late CurrentWeatherRepository currentWeatherRepository;
  late WeatherAppCubit newsAppCubit;

  AppRouter() {
    currentWeatherRepository = CurrentWeatherRepository(dioHelper: DioHelper());
    newsAppCubit =
        WeatherAppCubit(currentWeatherRepository: currentWeatherRepository ,currentLocationRepository: CurrentLocationRepository());
  }

  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => newsAppCubit,
                  child:  const Home(),
                ));
    }
    return null;
  }
}
