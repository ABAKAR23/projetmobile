import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/controllers/weather_controller.dart';

class ProgressScreen extends StatefulWidget {
  @override
  _ProgressScreenState createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  final WeatherController _weatherController = Get.put(WeatherController());
  double _progress = 0;
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
    _weatherController.rotateMessages();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_progress >= 1) {
          _timer.cancel();
        } else {
          _progress += 1 / 60;
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Progression')),
      body: Obx(() {
        if (_weatherController.isLoading.value) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Progression de la jauge'),
                SizedBox(height: 20),
                LinearProgressIndicator(value: _progress),
                SizedBox(height: 20),
                Text(_weatherController.messages[_weatherController.currentMessageIndex.value]),
              ],
            ),
          );
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Résultats'),
                SizedBox(height: 20),
                DataTable(
                  columns: [
                    DataColumn(label: Text('Ville')),
                    DataColumn(label: Text('Température')),
                    DataColumn(label: Text('Nuages')),
                  ],
                  rows: _weatherController.weatherList.map((weather) {
                    return DataRow(cells: [
                      DataCell(Text(weather.name)),
                      DataCell(Text('${weather.main.temp} °C')),
                      DataCell(Text(weather.weather[0].description)),
                    ]);
                  }).toList(),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _progress = 0;
                      _weatherController.fetchWeatherData();
                      _startTimer();
                    });
                  },
                  child: Text('Recommencer'),
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
