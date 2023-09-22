import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather.dart';

const apiKey = 'd361edb622eff85f4aaa1dc54ec0b0cd';
String baseUrl =
    'https://api.openweathermap.org/data/2.5/weather?appid=$apiKey';
final clien = http.Client();

class WeatherRepositories {
  static Future<Temperatures> fetchTemperatures(
      {String? units, String? lang, String? city}) async {
    units ?? 'metric';
    String url = '$baseUrl&units=$units&lang=$lang&q=$city';
    try {
      final response = await clien.get(Uri.parse(url));
      if (response.statusCode != 200) {
        throw Exception('Cannot get weather');
      }
      final responseBody = jsonDecode(response.body);
      print('Object: ${Temperatures.fromJson(responseBody)}');
      return Temperatures.fromJson(responseBody);
    } catch (e) {
      print(e);
      throw Exception(e.toString());
    }
  }
}
