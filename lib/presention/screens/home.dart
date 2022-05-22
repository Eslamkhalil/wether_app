import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bussiness/cubit/news_app_cubit.dart';
import '../../bussiness/cubit/news_app_state.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WeatherAppCubit,WeatherAppState>(

        builder: (context, state) {
           final cubit = WeatherAppCubit.get(context);
          return Scaffold(

            backgroundColor: const Color(0xFF3C405C),
            body: cubit.screens[cubit.currentScreenIndex],
            bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentScreenIndex,
            onTap: (index) => cubit.changeScreen(index),
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home',),
              BottomNavigationBarItem(icon: Icon(Icons.search), label: 'search',),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'settings',),

            ],
          ),);
        }, listener: (context, state) {});
  }
}
