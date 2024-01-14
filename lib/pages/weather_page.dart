import "package:flutter/material.dart";
import "package:lottie/lottie.dart";
import "package:weather/models/weather_model.dart";
import "package:weather/services/weather_service.dart";

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  //apikey
  final _weatherService = WeatherService('c3765a7a51a3f053901c2531ab0e0ce1');
  Weather? _weather;

  //fetch weather
  _fetchWeather() async {
    //get city name
    String cityName = await _weatherService.getCurrentCity();

    //get city weather
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }
    //any error
    catch (e) {
      print(e);
    }
  }

  //weather animation
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json';

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloudy.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rainy.json';
      case 'thunderstrom':
        return 'assets/thunder.json';
      case 'clear' :
        return 'assets/sunny.json';
      default :
        return 'assets/sunny.json';
    }
  }

  //fetch weather initialy
  @override
  void initState() {
    super.initState();

    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.location_on_outlined,color: Color.fromARGB(255, 124, 124, 124),),
            Text(_weather?.cityName ?? "loading city..", style: const TextStyle(color: Color.fromARGB(255, 205, 205, 205)),),
            const SizedBox(height: 30,),
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
            Text('${_weather?.temperature.round()}℃', style: const TextStyle(color: Colors.amber),),
            const SizedBox(height: 10,),
            Text(_weather?.mainCondition?? "loading weather...", style: const TextStyle(color: Color.fromARGB(255, 195, 195, 195)),)
          ],
        ),
      ),
    );
  }
}
