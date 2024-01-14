import 'package:flutter/material.dart';
import 'package:weather/pages/weather_page.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp ({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WeatherPage(),
      theme: new ThemeData(scaffoldBackgroundColor: Color.fromARGB(255, 44, 44, 44)),
    );
  }
}