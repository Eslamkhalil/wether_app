import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:wether_app/data/network/local/cache_helper.dart';
import 'package:wether_app/data/network/remote/dio_helper.dart';
import 'package:wether_app/style/theme.dart';

import 'app_router.dart';
import 'data/network/remote/my_http_overrides.dart';
import 'my_bloc_observer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  //CacheHelper.initCacheHelper();
  // MyHttpOverrides.global=  MyHttpOverrides();

  BlocOverrides.runZoned(
    () {
      runApp(MyApp(AppRouter()));
    },
    blocObserver: SimpleBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final AppRouter router;

  const MyApp(this.router, {Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: darkTheme,
      onGenerateRoute: router.onGenerateRoute,
    );
  }
}
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}