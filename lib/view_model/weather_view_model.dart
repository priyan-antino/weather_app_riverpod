import 'package:weather_app/data_model/weather_data_model.dart';
import 'package:weather_app/repo/weather_repo.dart';

class WeatherViewModel {
  final _rep = WeatherRepository();
  Future<WeatherDataModel> getWeather(String loc) async {
    final response = await _rep.getWeather(loc);
    return response;
  }
}
