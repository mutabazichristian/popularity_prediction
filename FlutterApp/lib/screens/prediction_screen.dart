import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../services/prediction_service.dart';
import '../models/song_features.dart';

class PredictionScreen extends StatefulWidget {
  const PredictionScreen({super.key});

  @override
  PredictionScreenState createState() => PredictionScreenState();
}

class PredictionScreenState extends State<PredictionScreen> {
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

  String _predictionResult = 'Ready to predict your song\'s popularity?';
  bool _isLoading = false;

  void _predict() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _predictionResult = 'Analyzing your song...';
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
              'Your song\'s predicted popularity: ${result.predictedPopularity.toStringAsFixed(2)}%';
          _isLoading = false;
        });
      } catch (e) {
        setState(() {
          _predictionResult = 'Whoops! Something went wrong: $e';
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Song Popularity Predictor',
          style: TextStyle(
            color: Colors.blue.shade300,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.black,
              Colors.blue.shade900.withOpacity(0.7),
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildTextField(
                  _durationController, 
                  'Duration (ms)', 
                  3000, 
                  600000,
                ),
                _buildTextField(
                  _acousticnessController, 
                  'Acousticness', 
                  0.0, 
                  1.0,
                ),
                _buildTextField(
                  _danceabilityController, 
                  'Danceability', 
                  0.0, 
                  1.0,
                ),
                _buildTextField(
                  _energyController, 
                  'Energy', 
                  0.0, 
                  1.0,
                ),
                _buildTextField(
                  _instrumentalnessController, 
                  'Instrumentalness', 
                  0.0, 
                  1.0,
                ),
                _buildTextField(
                  _keyController, 
                  'Key', 
                  0, 
                  11,
                ),
                _buildTextField(
                  _livenessController, 
                  'Liveness', 
                  0.0, 
                  1.0,
                ),
                _buildTextField(
                  _loudnessController, 
                  'Loudness', 
                  -60.0, 
                  0.0,
                ),
                _buildTextField(
                  _audioModeController, 
                  'Audio Mode', 
                  0, 
                  1,
                ),
                _buildTextField(
                  _speechinessController, 
                  'Speechiness', 
                  0.0, 
                  1.0,
                ),
                _buildTextField(
                  _tempoController, 
                  'Tempo', 
                  0.0, 
                  300.0,
                ),
                _buildTextField(
                  _timeSignatureController, 
                  'Time Signature', 
                  3, 
                  7,
                ),
                _buildTextField(
                  _audioValenceController, 
                  'Audio Valence', 
                  0.0, 
                  1.0,
                ),
                
                const SizedBox(height: 20),
                
                ElevatedButton(
                  onPressed: _isLoading ? null : _predict,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade600,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                          'Predict Popularity',
                          style: TextStyle(
                            fontSize: 18, 
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                ).animate()
                  .fadeIn(duration: 500.ms)
                  .shimmer(duration: 1500.ms, color: Colors.blue.shade300),
                
                const SizedBox(height: 20),
                
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _predictionResult.contains('Error') 
                      ? Colors.red.withOpacity(0.2) 
                      : Colors.blue.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: _predictionResult.contains('Error') 
                        ? Colors.red.shade300 
                        : Colors.blue.shade300,
                      width: 2,
                    ),
                  ),
                  child: Text(
                    _predictionResult,
                    style: TextStyle(
                      fontSize: 18, 
                      fontWeight: FontWeight.bold,
                      color: _predictionResult.contains('Error') 
                        ? Colors.red.shade300 
                        : Colors.blue.shade300,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ).animate()
                  .scale(duration: 300.ms)
                  .fadeIn(duration: 500.ms),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding _buildTextField(
    TextEditingController controller, 
    String label, 
    num minValue, 
    num maxValue
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.blue.shade300),
          enabledBorder: _customBorder(Colors.blue.shade600),
          focusedBorder: _customBorder(Colors.blue.shade300, 3),
          errorBorder: _customBorder(Colors.red, 2),
          filled: true,
          fillColor: Colors.blue.withOpacity(0.1),
        ),
        keyboardType: TextInputType.number,
        validator: (value) => _validateInput(value, label, minValue, maxValue),
      ).animate()
        .fade(duration: 500.ms)
        .shimmer(duration: 1500.ms, color: Colors.blue.shade300),
    );
  }

  OutlineInputBorder _customBorder(Color color, [double width = 2]) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(color: color, width: width),
    );
  }

  String? _validateInput(String? value, String label, num minValue, num maxValue) {
    if (value == null || value.isEmpty) {
      return 'Got something for me?';
    }
    final numValue = num.tryParse(value);
    if (numValue == null) {
      return 'Looks like that\'s not a number';
    }
    if (numValue < minValue || numValue > maxValue) {
      return '$label should be between $minValue and $maxValue';
    }
    return null;
  }

  @override
  void dispose() {
    _durationController.dispose();
    _acousticnessController.dispose();
    _danceabilityController.dispose();
    _energyController.dispose();
    _instrumentalnessController.dispose();
    _keyController.dispose();
    _livenessController.dispose();
    _loudnessController.dispose();
    _audioModeController.dispose();
    _speechinessController.dispose();
    _tempoController.dispose();
    _timeSignatureController.dispose();
    _audioValenceController.dispose();
    super.dispose();
  }
}
