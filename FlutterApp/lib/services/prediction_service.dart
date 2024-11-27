import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/song_features.dart';

class PredictionResponse {
  final double predictedPopularity;
  final Map<String, dynamic> featureImportance;

  PredictionResponse(
      {required this.predictedPopularity, required this.featureImportance});

  factory PredictionResponse.fromJson(Map<String, dynamic> json) {
    return PredictionResponse(
      predictedPopularity: json['predicted_popularity'],
      featureImportance: json['feature_importance'] ?? {},
    );
  }
}

class PredictionService {
  final String baseUrl = 'https://popularity-prediction.onrender.com';
  // final String baseUrl = 'http://0.0.0.0:8000'; 
  
  Future<PredictionResponse> predictPopularity(SongFeatures features) async {
    final response = await http.post(
      Uri.parse(baseUrl+'/predict'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(features.toJson()),
    );
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      return PredictionResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to predict popularity :${response.body}');
    }
  }
}
