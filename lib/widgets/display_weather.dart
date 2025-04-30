import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/utils/utils.dart';

class WeatherDisplay extends StatefulWidget {
  final Weather weather;
  const WeatherDisplay({
    super.key,
    required this.weather,
  });

  @override
  State<WeatherDisplay> createState() => _WeatherDisplayState();
}

class _WeatherDisplayState extends State<WeatherDisplay> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Lottie.asset(
                UtilFunctions()
                    .getWeatherAnimation(condition: widget.weather.condition),
                width: 400,
                height: 400,
              ),
            ),
            Text(
              widget.weather.cityName,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "${widget.weather.temperature.toStringAsFixed(1)}°C",
              style: const TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            Row(
              children: [
                Text(
                  widget.weather.condition,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  widget.weather.description,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildWeatherDetail(
                    "Pressure", "${widget.weather.pressure} hPa"),
                _buildWeatherDetail("Humidity", "${widget.weather.humidity}%"),
                _buildWeatherDetail(
                    "Wind Speed", "${widget.weather.windSpeed} m/s"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherDetail(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.normal,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
