import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/pages/search_weather_page.dart';
import 'package:weather_app/providers/theme_provider.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:weather_app/widgets/display_weather.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final WeatherService _weatherService =
      WeatherService(apiKey: dotenv.env["WEATHER_API"] ?? "");

  Weather? _weather;

  //methods to fetch the weather
  void fetchWeather() async {
    try {
      final weather = await _weatherService.getWeatherFromLocation();
      setState(() {
        _weather = weather;
      });
    } catch (error) {
      print("Error from weather data:$error");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Weather App",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false)
                  .toggleTheme(Theme.of(context).brightness != Brightness.dark);
            },
            icon: Icon(Theme.of(context).brightness == Brightness.dark
                ? Icons.light_mode
                : Icons.dark_mode),
          ),
        ],
      ),
      body: _weather != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                WeatherDisplay(
                  weather: _weather!,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SearchWeatherPage()),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(107, 255, 208, 128),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Search Weather",
                        style: TextStyle(
                          color: Colors.orangeAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
