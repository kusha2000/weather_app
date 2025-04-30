import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:weather_app/widgets/display_weather.dart';

class SearchWeatherPage extends StatefulWidget {
  const SearchWeatherPage({super.key});

  @override
  State<SearchWeatherPage> createState() => _SearchWeatherPageState();
}

class _SearchWeatherPageState extends State<SearchWeatherPage> {
  final WeatherService _weatherService =
      WeatherService(apiKey: dotenv.env["WEATHER_API"] ?? "");

  Weather? _weather;

  String? _error;
  final TextEditingController _controller = TextEditingController();

  void _searchWeather() async {
    final city = _controller.text.trim();

    if (city.isEmpty) {
      setState(() {
        _error = "Please enter a city name";
      });
      return;
    }

    try {
      final weather = await _weatherService.getWeather(city);
      setState(() {
        _weather = weather;
        _error = null;
      });
    } catch (error) {
      setState(() {
        _error = "Could not find Weather data for $city";
      });
      print(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Weather"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: 'City Name',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: _searchWeather,
                  ),
                ),
                onSubmitted: (value) => _searchWeather(),
              ),
              const SizedBox(height: 10),
              _error != null
                  ? Text(
                      _error!,
                      style: const TextStyle(color: Colors.red),
                    )
                  : _weather != null
                      ? WeatherDisplay(weather: _weather!)
                      : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
