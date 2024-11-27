class SongFeatures {
  final int durationMs;
  final double acousticness;
  final double danceability;
  final double energy;
  final double instrumentalness;
  final int key;
  final double liveness;
  final double loudness;
  final int audioMode;
  final double speechiness;
  final double tempo;
  final int timeSignature;
  final double audioValence;

  SongFeatures(
      {required this.durationMs,
      required this.acousticness,
      required this.danceability,
      required this.energy,
      required this.instrumentalness,
      required this.key,
      required this.liveness,
      required this.loudness,
      required this.audioMode,
      required this.speechiness,
      required this.tempo,
      required this.timeSignature,
      required this.audioValence});
//create a mp
  Map<String, dynamic> toJson() => {
        'duration_ms': durationMs,
        'acousticness': acousticness,
        'danceability': danceability,
        'energy': energy,
        'instrumentalness': instrumentalness,
        'key': key,
        'liveness': liveness,
        'loudness': loudness,
        'audio_mode': audioMode,
        'speechiness': speechiness,
        'tempo': tempo,
        'time_signature': timeSignature,
        'audio_valence': audioValence,
      };
}
