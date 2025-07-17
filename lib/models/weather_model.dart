class Weather {
  final String cityName;
  final double temperature;
  final String description;
  final int humidity;
  final double windSpeed;
  final int sunrise;
  final int sunset;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.description,
    required this.humidity,
    required this.windSpeed,
    required this.sunrise,
    required this.sunset,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'] ?? 'Unknown',
      temperature:
          (json['main']['temp'] as num).toDouble(), // Ensure it's double
      description: json['weather'][0]['description'] ?? 'No description',
      humidity: json['main']['humidity'] ?? 0,
      windSpeed:
          (json['wind']['speed'] as num).toDouble(), // Ensure it's double
      sunrise: json['sys']['sunrise'] ?? 0,
      sunset: json['sys']['sunset'] ?? 0,
    );
  }
}
