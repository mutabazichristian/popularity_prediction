# 🎵 Song Popularity Predictor

## Project Overview
A machine learning solution to predict song popularity using advanced regression techniques and audio feature analysis.

##Public API End point
https://popularity-prediction.onrender.com/
##Video
https://youtu.be/w8faeZQNQZQ

## 🎯 The Use
Develop a predictive model that helps musicians and producers understand the key factors influencing a song's potential success by analyzing audio characteristics.

## 📊 Dataset
- **Source**: Kaggle Top Songs Dataset
- **Features**: Comprehensive audio characteristics
- **Key Attributes**: 
  - Danceability
  - Energy
  - Loudness
  - Tempo
  - Key

### Performance Metrics
- Mean Squared Error (MSE)
- R-squared (R²) Score

## 🛠 How to run
1. Clone repo
2. navigate to FlutterApp/
3. Use the "flutter run" command
4. Predict your popularity!

### Data Preprocessing
- Feature selection
- Standard scaling
- Train-test split

### Model Evaluation
- Comparative analysis of three regression models
- Automatic best model selection
- Model and scaler persistence

## 📁 Project Structure
```
song_popularity_predictor/
│
├── data/
│   └── song_data.csv
│
├── models/
│   ├── linear_regression_model.pkl
│   └── song_popularity_scaler.pkl
│
├── visualizations/
│   └── linear_regression_scatter.png
│
└── song_popularity_predictor.py
```

## 🔍 Key Insights
- Identifies critical audio features influencing song popularity
- Provides data-driven insights for music production

## 📜 License
MIT License

## 🙏 Acknowledgments
- Kaggle for the dataset
- Open-source machine learning community
- learnig coach
