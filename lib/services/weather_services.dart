import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather/models/weather_model.dart';

class WeatherServices {
  final String apikey = 'Add Your API Key Here';
  Future<Weather> fetchWeather(String cityName) async {
    final url = Uri.parse('Api URL Here');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return Weather.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
