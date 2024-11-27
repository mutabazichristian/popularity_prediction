# 🎵 Song Popularity Predictor

## Project Overview
A machine learning solution to predict song popularity using advanced regression techniques and audio feature analysis.

## 🎯 Mission
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

## 🧠 Machine Learning Approaches

### Models Implemented
1. **Linear Regression**
   - Simple, interpretable linear model
   - Captures linear relationships between features and popularity

2. **Decision Tree Regression**
   - Non-linear model
   - Captures complex feature interactions
   - Provides feature importance insights

3. **Random Forest Regression**
   - Ensemble learning method
   - Reduces overfitting
   - Handles non-linear relationships
   - Provides robust predictions

### Performance Metrics
- Mean Squared Error (MSE)
- R-squared (R²) Score

## 🛠 Technical Implementation

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

## 🚀 Quick Start
1. Install dependencies
2. Run `song_popularity_predictor.py`
3. Predict song popularity using audio features

## 🔍 Key Insights
- Identifies critical audio features influencing song popularity
- Provides data-driven insights for music production

## 📈 Future Enhancements
- Integrate more advanced feature engineering
- Explore deep learning models
- Develop interactive prediction interface

## 📜 License
MIT License

## 🙏 Acknowledgments
- Kaggle for the dataset
- Open-source machine learning community
- learnig
