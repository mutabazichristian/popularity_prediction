import 'package:flutter/material.dart';
import 'screens/prediction_screen.dart';

void main() {
  runApp(const SongPopularityApp());
}

class SongPopularityApp extends StatelessWidget {
  const SongPopularityApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Song Popularity Predictor',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const PredictionScreen(),
    );
  }
}

