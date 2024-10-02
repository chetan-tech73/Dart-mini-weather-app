import 'package:my_weather_app/services/weather_service.dart';
import 'package:my_weather_app/models/my_weather_app.dart';

void main() async {
  List<String> cities = ['Abuja', 'Port Harcourt', 'Lagos'];
  for (String city in cities) {
    try {
      Weather weather = await WeatherService.fetchWeather(city);
      print('Weather in ${weather.city}: ');
      print('Description: ${weather.description}: ');
      print('Temperature ${weather.temperature}: ');
      print('Humidity ${weather.humidity}: ');
      print('-------------------');
    } catch (e) {
      print('Error fetching weather for $city $e');
    }
  }
}
