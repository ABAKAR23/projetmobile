import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'progress_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Accueil')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Bienvenue à l\'application météo'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.to(ProgressScreen());
              },
              child: Text('Commencer'),
            ),
          ],
        ),
      ),
    );
  }
}
