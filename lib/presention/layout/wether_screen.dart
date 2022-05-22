import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../bussiness/cubit/news_app_cubit.dart';
import '../../bussiness/cubit/news_app_state.dart';
import '../../data/models/weather_forecast_model.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildBlocBuilder();
  }

  buildBlocBuilder() {
    return BlocConsumer<WeatherAppCubit, WeatherAppState>(
        builder: (context, state) {
          final cubit = BlocProvider.of<WeatherAppCubit>(context);
          if (state is WeatherAppStateLoaded) {
            return buildLoadedData(cubit.forecastWeather!, cubit.hours);
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        listener: (context, state) {});
  }

  Widget buildLoadedData(WeatherForecastModel model, hours) {
    final date = DateTime.tryParse(model.location!.localtime!);

    return Stack(
      children: [
        Image.asset(
          'assets/images/cloudy.jpeg',
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 45.0, horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Center(
                      child: Text(
                    'Weather',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold),
                  )),
                ],
              ),
              const SizedBox(
                height: 70.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(alignment: AlignmentDirectional.centerEnd, children: [
                    const Text(
                      ' c',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Text(
                      '${model.current!.tempC}° ',
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 50.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ]),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                '${DateFormat.MMMEd().format(date!)} \n ${DateFormat.jm().format(date)}',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    height: 1.5,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                '${model.location!.country} , ${model.location!.name}',
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.white, fontSize: 14.0),
              ),
              const SizedBox(
                height: 50.0,
              ),
              Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) =>
                      _buildForeCastPeriod(hours[index]),
                  scrollDirection: Axis.horizontal,
                  itemCount: hours.length,
                  separatorBuilder: (context, index) => const SizedBox(
                    width: 10,
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => _buildForeCastPeriodByDay(
                      model.forecast!.forecastday![index]),
                  scrollDirection: Axis.vertical,
                  itemCount: model.forecast!.forecastday!.length,
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 8,
                  ),
                ),
              ),

              /* const Text('Weather Details',
              style: TextStyle(
                letterSpacing: 0.1,
                fontWeight: FontWeight.w500,
                fontSize: 24,
              )),
          const SizedBox(
            height: 16.0,
          ),*/
              //_buildWeatherDetails(),
            ],
          ),
        ),
      ],
    );
  }

  _buildForeCastPeriod(Hour hour) {
    return Container(
      height: 150,
      width: 90,
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(DateFormat.jm().format(DateTime.tryParse(hour.time!)!.toLocal()),
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white, fontSize: 16)),
          Image.network(
            'https:${hour.condition!.icon}',
            width: 48,
            height: 48,
            fit: BoxFit.cover,
          ),
          Text('${hour.tempC} °c',
              style: const TextStyle(color: Colors.white, fontSize: 16)),
        ],
      ),
    );
  }

  _buildForeCastPeriodByDay(
    Forecastday forecastday,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(DateFormat.EEEE().format(DateTime.tryParse(forecastday.date!)!),
              style: const TextStyle(
                color: Colors.white,
                letterSpacing: 0.1,
              )),
          Image.network(
            'https:${forecastday.day!.condition!.icon}',
            width: 24,
            height: 24,
          ),
          Text('${forecastday.day!.avgtempC} °',
              style: const TextStyle(
                color: Colors.white,
                letterSpacing: 0.1,
              )),
        ],
      ),
    );
  }

  _buildWeatherDetails() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: const [
                Text('temp'),
                Text('28'),
                SizedBox(
                  height: 24,
                ),
                Text('temp'),
                Text('28'),
                SizedBox(
                  height: 24,
                ),
                Text('temp'),
                Text('28'),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: const [
                Text('temp'),
                Text('28'),
                SizedBox(
                  height: 24,
                ),
                Text('temp'),
                Text('28'),
                SizedBox(
                  height: 24,
                ),
                Text('temp'),
                Text('28'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
