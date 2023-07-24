import 'package:flutter/material.dart';
import 'package:news_app/models/getlocation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/weatherData.dart';
import '../models/weatherModel.dart';
import '../widgets/weather_widget1.dart';
import '../widgets/weather_widget2.dart';

class WeatherScreen extends StatefulWidget {
  // const WeatherScreen({Key key}) : super(key: key);
  static String routeName = "/weather_screen";

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  var client = WeatherData();
  bool isInit = true;
  bool isLoading = false;
  var data;
  String? error;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (isInit) {
      isLoading = true;
      isInit = false;
      try {
        var position = await getPosition();
        data = await client.getData(position.latitude, position.longitude);
        print(data);
        setState(() {
          isLoading = false;
        });
      } catch (e) {
        setState(() {
          isLoading = false;
          error = 'Failed to fetch weather data.';
        });
      }
    }
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
      error = null;
    });
    try {
      var position = await getPosition();
      data = await client.getData(position.latitude, position.longitude);
    } catch (e) {
      setState(() {
        error = 'Failed to fetch weather data.';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 1, 23, 41),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : error != null
              ? Center(
                  child: Text(
                    error!,
                    style: TextStyle(color: Colors.red),
                  ),
                )
              : Column(
                  children: [
                    WeatherWidget1(size: size, data: data),
                    const SizedBox(
                      height: 20,
                    ),
                    WeatherWidget2(data: data),
                  ],
                ),
    );
  }
}

// class WeatherData {
//   Future<Weather> getData(var latitude, var longitude) async {
//     var uricCall = Uri.parse(
//         'http://api.weatherapi.com/v1/current.json?key=3c2ef9087b5846eda5a52409233005&q=$latitude,$longitude&aqi=no');
//     try {
//       var response = await http.get(uricCall);
//       var body = jsonDecode(response.body);
//       return Weather.fromJson(body);
//     } catch (e) {
//       throw Exception('Failed to fetch weather data.');
//     }
//   }
// }
