

import '../../data/models/weather_forecast_model.dart';

class WeatherAppState {
}

class WeatherAppStateInitial extends WeatherAppState {
}

class WeatherAppStateLoading extends WeatherAppState {


  }
class WeatherAppStateLoaded extends WeatherAppState {
  WeatherForecastModel weather ;
  WeatherAppStateLoaded({required this.weather});
}

class WeatherAppStateError extends WeatherAppState {
  final dynamic message;
  WeatherAppStateError(this.message);
  }
class FetchByCityLoading extends WeatherAppState {


}
class FetchByCityLoaded extends WeatherAppState {


}
class FetchByCityError extends WeatherAppState {
  dynamic error;
  FetchByCityError(this.error);

}





class WeatherAppStateBottomIndexChange extends WeatherAppState {


}

