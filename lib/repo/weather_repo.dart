import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/data_model/weather_data_model.dart';

class WeatherRepository {
  Future<WeatherDataModel> getWeather(String loc) async {
    String url =
        'http://api.weatherapi.com/v1/current.json?key=de85cbecc10d4080927115014240202&q=${loc}&aqi=no';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);

      return WeatherDataModel.fromJson(body);
    } else {
      throw Exception('Error');
    }
  }
}
