import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/models/weatherModel.dart';

class WeatherData {
  Future<Weather> getData(var latitude, var longitude) async {
    var uricCall = Uri.parse(
        'http://api.weatherapi.com/v1/current.json?key=3c2ef9087b5846eda5a52409233005&q=$latitude,$longitude&aqi=no');
    try {
      var response = await http.get(uricCall);
      var body = jsonDecode(response.body);
      return Weather.fromJson(body);
    } catch (e) {
      throw Exception('Failed to fetch weather data.');
    }
  }
}
