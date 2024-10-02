import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/my_weather_app.dart';

class WeatherService{
  static const String apiKey = '530dcc25a74e83ff6f4bd6a7564bf40b';

  static Future<Weather> fetchWeather(String city) async{
    final url = 'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric';

    final response = await http.get(Uri.parse(url));

    if(response.statusCode == 200){
      final Map<String, dynamic> data = jsonDecode(response.body);
      return Weather.fromJson(data);
    }else{
      throw Exception('Failed to load weather data');
    }
  }
  
}