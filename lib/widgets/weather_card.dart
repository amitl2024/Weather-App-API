import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/models/weather_model.dart';

class WeatherCard extends StatelessWidget {
  final Weather weather;

  const WeatherCard({super.key, required this.weather});

  String formatTime(int timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return DateFormat('hh:mm a').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.all(24),
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          gradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(0.25),
              Colors.blueAccent.withOpacity(0.15),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.blueAccent.withOpacity(0.2),
              blurRadius: 24,
              offset: Offset(0, 8),
            ),
          ],
          border: Border.all(color: Colors.white.withOpacity(0.3), width: 1.5),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Weather Animation
            Lottie.asset(
              weather.description.contains('rain')
                  ? 'assets/rain.json'
                  : weather.description.contains('clear')
                  ? 'assets/clear.json'
                  : 'assets/cloudy.json',
              height: 120,
              width: 120,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 12),
            // City Name
            Text(
              weather.cityName,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey[900],
                letterSpacing: 1.2,
                shadows: [
                  Shadow(color: Colors.white.withOpacity(0.7), blurRadius: 8),
                ],
              ),
            ),
            SizedBox(height: 8),
            // Temperature
            Text(
              '${weather.temperature.toStringAsFixed(1)}°C',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.w900,
                foreground:
                    Paint()
                      ..shader = LinearGradient(
                        colors: [Colors.blue, Colors.blueGrey],
                      ).createShader(Rect.fromLTWH(0, 0, 200, 70)),
                shadows: [
                  Shadow(
                    color: Colors.blueAccent.withOpacity(0.2),
                    blurRadius: 12,
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            // Description
            Text(
              weather.description[0].toUpperCase() +
                  weather.description.substring(1),
              style: TextStyle(
                fontSize: 20,
                color: Colors.blueGrey[700],
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(height: 24),
            // Weather Details Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _WeatherDetail(
                  icon: Icons.water_drop,
                  label: 'Humidity',
                  value: '${weather.humidity}',
                  color: Colors.blueAccent,
                ),
                _WeatherDetail(
                  icon: Icons.air,
                  label: 'Wind',
                  value: '${weather.windSpeed} m/s',
                  color: Colors.teal,
                ),
              ],
            ),
            SizedBox(height: 24),
            // Sunrise & Sunset
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _WeatherDetail(
                  icon: Icons.wb_sunny_outlined,
                  label: 'Sunrise',
                  value: formatTime(weather.sunrise),
                  color: Colors.orange,
                ),
                _WeatherDetail(
                  icon: Icons.nights_stay_outlined,
                  label: 'Sunset',
                  value: formatTime(weather.sunset),
                  color: Colors.deepPurple,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _WeatherDetail extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _WeatherDetail({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: color.withOpacity(0.15),
          child: Icon(icon, color: color, size: 28),
          radius: 24,
        ),
        SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.blueGrey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
