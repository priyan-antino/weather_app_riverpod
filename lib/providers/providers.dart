import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/data_model/weather_data_model.dart';
import 'package:weather_app/repo/weather_repo.dart';
import 'package:weather_app/view_model/weather_view_model.dart';

class LocationNotifier extends StateNotifier<String> {
  LocationNotifier() : super("gurgaon");

  void refreshlocation(String location) {
    state = location;
  }
}

final locationProvider = StateNotifierProvider<LocationNotifier, String>((ref) {
  return LocationNotifier();
});

final weatherProvider = FutureProvider.autoDispose((ref) async {
  final weatherRepo = ref.watch(weatherRepositoryProvider);
  final loc = ref.watch(locationProvider);
  return weatherRepo.getWeather(loc);
});

final weatherRepositoryProvider = Provider<WeatherRepository>((ref) {
  return WeatherRepository();
});
