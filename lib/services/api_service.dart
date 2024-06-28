import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:weather_app/models/weather_response.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "https://api.openweathermap.org/data/2.5/")
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET("weather")
  Future<WeatherResponse> getWeather(
    @Query("q") String city,
    @Query("appid") String apiKey,
    @Query("units") String units,
  );
}
