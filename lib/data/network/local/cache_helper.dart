

import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper{

static late SharedPreferences _sharedPreferences ;


static initCacheHelper()async{
   _sharedPreferences = await SharedPreferences.getInstance();
 }

 static saveData(String key , dynamic value) async{
  if(value is String ) return await _sharedPreferences.setString(key, value);
  if(value is int ) return await _sharedPreferences.setInt(key, value);
  if(value is bool ) return await _sharedPreferences.setBool(key, value);

  return await _sharedPreferences.setDouble(key, value);

 }

 static getData(String key){
  return _sharedPreferences.get(key);
 }

}