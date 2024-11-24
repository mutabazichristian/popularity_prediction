import 'package:flutter/material.dart';
import '../services/prediction_service.dart';
import '../models/song_features.dart';

class PredictionScreen extends StatefulWidget {
  const PredictionScreen({super.key});

  @override
  _PredictionScreenState createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _predictionService = PredictionService();

  final TextEditingController _durationController =
      TextEditingController(text: '262333');
  final TextEditingController _acousticnessController =
      TextEditingController(text: '0.00552');
  final TextEditingController _danceabilityController =
      TextEditingController(text: '0.496');
  final TextEditingController _energyController =
      TextEditingController(text: '0.682');
  final TextEditingController _instrumentalnessController =
      TextEditingController(text: '0.0000294');
  final TextEditingController _keyController = TextEditingController(text: '8');
  final TextEditingController _livenessController =
      TextEditingController(text: '0.0589');
  final TextEditingController _loudnessController =
      TextEditingController(text: '-4.095');
  final TextEditingController _audioModeController =
      TextEditingController(text: '1');
  final TextEditingController _speechinessController =
      TextEditingController(text: '0.0294');
  final TextEditingController _tempoController =
      TextEditingController(text: '167.06');
  final TextEditingController _timeSignatureController =
      TextEditingController(text: '4');
  final TextEditingController _audioValenceController =
      TextEditingController(text: '0.474');

  String _predictionResult = '';
  bool _isLoading = false;

  void _predict() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _predictionResult = '';
      });

      try {
        final songFeatures = SongFeatures(
          durationMs: int.parse(_durationController.text),
          acousticness: double.parse(_acousticnessController.text),
          danceability: double.parse(_danceabilityController.text),
          energy: double.parse(_energyController.text),
          instrumentalness: double.parse(_instrumentalnessController.text),
          key: int.parse(_keyController.text),
          liveness: double.parse(_livenessController.text),
          loudness: double.parse(_loudnessController.text),
          audioMode: int.parse(_audioModeController.text),
          speechiness: double.parse(_speechinessController.text),
          tempo: double.parse(_tempoController.text),
          timeSignature: int.parse(_timeSignatureController.text),
          audioValence: double.parse(_audioValenceController.text),
        );

        final result = await _predictionService.predictPopularity(songFeatures);
        setState(() {
          _predictionResult =
              'Predicted Popularity: ${result.predictedPopularity.toStringAsFixed(2)}';
          _isLoading = false;
        });
      } catch (e) {
        setState(() {
          _predictionResult = 'Prediction Error: $e';
          _isLoading = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _durationController.text = '262333';
    _acousticnessController.text = '0.00552';
    _danceabilityController.text = '0.496';
    _energyController.text = '0.682';
    _instrumentalnessController.text = '2.94e-05';
    _keyController.text = '8';
    _livenessController.text = '0.0589';
    _loudnessController.text = '-4.095';
    _audioModeController.text = '1';
    _speechinessController.text = '0.0294';
    _tempoController.text = '167.06';
    _timeSignatureController.text = '4';
    _audioValenceController.text = '0.474';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Song Popularity Predictor'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextField(
                  _durationController, 'Duration (ms)', 3000, 600000),
              _buildTextField(
                  _acousticnessController, 'Acousticness', 0.0, 1.0),
              _buildTextField(
                  _danceabilityController, 'Danceability', 0.0, 1.0),
              _buildTextField(_energyController, 'Energy', 0.0, 1.0),
              _buildTextField(
                  _instrumentalnessController, 'Instrumentalness', 0.0, 1.0),
              _buildTextField(_keyController, 'Key', 0, 11),
              _buildTextField(_livenessController, 'Liveness', 0.0, 1.0),
              _buildTextField(_loudnessController, 'Loudness', -60.0, 0.0),
              _buildTextField(_audioModeController, 'Audio Mode', 0, 1),
              _buildTextField(_speechinessController, 'Speechiness', 0.0, 1.0),
              _buildTextField(_tempoController, 'Tempo', 50.0, 200.0),
              _buildTextField(_timeSignatureController, 'Time Signature', 3, 7),
              _buildTextField(
                  _audioValenceController, 'Audio Valence', 0.0, 1.0),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isLoading ? null : _predict,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Predict', style: TextStyle(fontSize: 18)),
              ),
              const SizedBox(height: 20),
              Text(
                _predictionResult,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      num minValue, num maxValue) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a value';
          }
          final numValue = num.tryParse(value);
          if (numValue == null) {
            return 'Please enter a valid number';
          }
          if (numValue < minValue || numValue > maxValue) {
            return '$label must be between $minValue and $maxValue';
          }
          return null;
        },
      ),
    );
  }
}
