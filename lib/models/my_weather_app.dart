class Weather{
  final String city;
  final double temperature;
  final String description;
  final int humidity;

  Weather({required this.city,required this.temperature,required this.description, required this.humidity});

factory Weather.fromJson(Map<String, dynamic> json) {
  return Weather(city: json['name'] ?? 'Unknown city', 
  temperature: (json['main']['temp'] as num?)?.toDouble() ?? 0.0, 
  description: (json['weather'] != null && json['weather'].isNotEmpty) ? json['weather'][0]['description']
  : 'No description available',
   humidity: (json['main']['humudity'] as num?)?.toInt() ?? 0,
  );
}
}