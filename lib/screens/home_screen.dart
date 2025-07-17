import 'package:flutter/material.dart';
import 'package:weather/models/weather_model.dart';
import 'package:weather/services/weather_services.dart';
import 'package:weather/widgets/weather_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WeatherServices _weatherServices = WeatherServices();
  final TextEditingController _controller = TextEditingController();
  bool _isLoading = false;
  Weather? _weather;

  void _getWeather() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final weather = await _weatherServices.fetchWeather(_controller.text);
      print("Weather Data: ${weather.toString()}");
      setState(() {
        _weather = weather;
        _isLoading = false;
      });
    } catch (e) {
      print("Error fetching weather: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient:
              _weather != null &&
                      _weather!.description.toLowerCase().contains('rain')
                  ? LinearGradient(
                    colors: [Colors.grey, Colors.blueGrey],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )
                  : _weather != null &&
                      _weather!.description.toLowerCase().contains('clear')
                  ? LinearGradient(
                    colors: [Colors.orangeAccent, Colors.blueAccent],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )
                  : LinearGradient(
                    colors: [
                      Colors.blue,
                      const Color.fromARGB(255, 171, 195, 236),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(height: 25),
                Text(
                  "Weather App",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 25),
                TextField(
                  controller: _controller,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Enter city name",
                    hintStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.black.withOpacity(0.3),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      color: Colors.white,
                      onPressed: _getWeather,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                if (_isLoading)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                if (_weather != null) WeatherCard(weather: _weather!),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
