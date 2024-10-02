import 'dart:convert'; //For handling JSON
import 'dart:async'; //For async and stream functionalities
import 'package:http/http.dart' as http;
import 'package:test_core/src/util/exit_codes.dart';

//My API Key
const String apiKey = '530dcc25a74e83ff6f4bd6a7564bf40b';
const String apiUrl = 'https://api.openweathermap.org/data/2.5/weather';

//Nigerian cities
List<String> cities = ['Lagos', 'Abuja', 'Kano', 'Port Harcourt'];

void main() async{
  //fetch weather data for multiple cities Future.wait
  await
  fetchMultipleCitiesWeather(cities);
}

//Function to fetch weather data from OpenWeatherMap Api
Future<Map<String, dynamic>?> fetchWeatherData(String cityName) async {
  final response = await http.get(Uri.parse('apiUrl?q=$cityName&appid=$apiKey&units=metric'));

  if (response.statusCode == 200) {
    //parse the JSON data
    return jsonDecode(response.body);
  }else{
    //f the API call fails, return an empty map
    print('Failed to load weather data for $cityName');
    return {};
  }
}

//Function to fetch weather data for multiple cities

Future<void>
fetchMultipleCitiesWeather(List<String> cities) async {
  try{
    List<Future<Map<String, dynamic>>>
    futures = cities.map(fetchWeatherData).toList();
    List<Map<String, dynamic>>
    result = await Future.wait(futures);

    //Display the weather for each city
    for (int i = 0; i < cities.length; i++){
      displayWeatherData(cities[i], result[i]);
    }
  }catch (e) {
    print('Error fetching weather data $e');
  }
}

//Function to display weather data for a city

void displayWeatherData(String city, Map<String dynamic>data){
  if (data.isNotEmpty) {
    String description = data['weather'][0]['description'];
    double temperature = data['main'] ['temp'];
    int humudity = data['main']['humidity'];

    print('City: $city');
    print('Weather: $description');
    print('Temperature: $temperature');
    print('Humidity: $humudity%');
  }else{
    print('No data available for $city.');
  }
}
