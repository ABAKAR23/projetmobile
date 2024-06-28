import 'package:get/get.dart';
import 'package:weather_app/services/api_service.dart';
import 'package:weather_app/models/weather_response.dart';
import 'package:dio/dio.dart';

class WeatherController extends GetxController {
  var weatherList = <WeatherResponse>[].obs;
  var isLoading = true.obs;
  var messages = ["Nous téléchargeons les données…", "C’est presque fini…", "Plus que quelques secondes avant d’avoir le résultat…"].obs;
  var currentMessageIndex = 0.obs;

  ApiService _apiService;

  WeatherController() {
    _apiService = ApiService(Dio());
    fetchWeatherData();
  }

  void fetchWeatherData() async {
    isLoading(true);
    weatherList.clear();

    List<String> cities = ["Rennes", "Paris", "Nantes", "Bordeaux", "Lyon"];
    String apiKey = "YOUR_API_KEY";
    String units = "metric";

    for (String city in cities) {
      var weather = await _apiService.getWeather(city, apiKey, units);
      weatherList.add(weather);
      await Future.delayed(Duration(seconds: 10));
    }

    isLoading(false);
  }

  void rotateMessages() {
    Timer.periodic(Duration(seconds: 6), (timer) {
      currentMessageIndex((currentMessageIndex.value + 1) % messages.length);
    });
  }
}
