import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_models.dart';

class DataServise {
  Future<Weather> fetchData(
    String cityName,
  ) async {
    try {
      final queryParameters = {
        'q': cityName,
        'appid': 'b8abc8e09d5de81b4ce2ebbced61aea5',
        'units': 'metric',
      };
      final uri = Uri.https(
          'api.openweathermap.org', '/data/2.5/weather', queryParameters);
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        return Weather.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Error to load data');
      }
    } catch (e) {
      rethrow;
    }
  }
}

class DataServise2 {
  Future<Weather> fetchData(lat, long) async {
    try {
      final queryParameters = {
        'lat': lat,
        'lon': long,
        'appid': 'b8abc8e09d5de81b4ce2ebbced61aea5',
        'units': 'metric',
      };
      final uri = Uri.https(
          'api.openweathermap.org', '/data/2.5/weather', queryParameters);
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        return Weather.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Error to load data');
      }
    } catch (e) {
      rethrow;
    }
  }
}
