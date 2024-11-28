from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel, Field
import joblib
import numpy as np
from typing import List

# Init
app = FastAPI(
    title="Song Popularity Predictor",
    description="Predicting a song popul based on audio features ",
    version="1.0.0",
)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# get model
try:
    loaded_data = joblib.load("Random_Forest_model.pkl")
    print("Type of loaded data:", type(loaded_data))
    print(
        "Keys/Attributes of loaded data:",
        (
            list(loaded_data.__dict__.keys())
            if hasattr(loaded_data, "__dict__")
            else (
                loaded_data.keys()
                if isinstance(loaded_data, dict)
                else "No keys available"
            )
        ),
    )
    if hasattr(loaded_data, "best_estimator_"):
        model = loaded_data.best_estimator_
        scaler = None  # You might need to extract this differently
    elif hasattr(loaded_data, "named_steps"):
        model = loaded_data.named_steps.get("regressor")
        scaler = loaded_data.named_steps.get("scaler")
    else:
        raise ValueError(
            f"Unexpected model format. Loaded data type: {type(loaded_data)}"
        )

    if model is None:
        raise ValueError("Failed to extract model from loaded data")

except FileNotFoundError:
    raise Exception("Model file not found. 'Random_Forest_model.pkl' does not exist")
except Exception as e:
    raise Exception(f"Error loading model: {str(e)}")


class SongFeatures(BaseModel):
    duration_ms: int = Field(
        ..., ge=3000, le=600000, description="Song duration in milliseconds"
    )
    acousticness: float = Field(
        ...,
        ge=0.0,
        le=1.0,
        description="A confidence measure of whether the track is acoustic",
    )
    danceability: float = Field(
        ..., ge=0.0, le=1.0, description="How suitable a track is for dancing"
    )
    energy: float = Field(..., ge=0.0, le=1.0, description="Energy level")
    instrumentalness: float = Field(
        ..., ge=0.0, le=1.0, description="whether a track contains no vocals"
    )
    key: int = Field(
        ..., ge=0, le=11, description="The key of the song in musical notes"
    )
    liveness: float = Field(
        ..., ge=0.0, le=1.0, description="Presence of audience in recording"
    )
    loudness: float = Field(
        ..., ge=-60.0, le=0.0, description="Overall loudness in decibels"
    )
    audio_mode: int = Field(
        ..., ge=0, le=1, description="Modality of track, major is 1 and minor 0"
    )
    speechiness: float = Field(
        ..., ge=0.0, le=1.0, description="Presence of spoken words in track"
    )
    tempo: float = Field(
        ..., ge=50.0, le=200.0, description="Overall tempo in beats per minute"
    )
    time_signature: int = Field(
        ..., ge=3, le=7, description="Time signature of the track"
    )
    audio_valence: float = Field(
        ..., ge=0.0, le=1.0, description="Musical positiveness conveyed by the track"
    )

    class Config:
        schema_extra = {
            "example": {
                "duration_ms": 262333,
                "acousticness": 0.00552,
                "danceability": 0.496,
                "energy": 0.682,
                "instrumentalness": 0.0000294,
                "key": 8,
                "liveness": 0.0589,
                "loudness": -4.095,
                "audio_mode": 1,
                "speechiness": 0.0294,
                "tempo": 167.06,
                "time_signature": 4,
                "audio_valence": 0.474,
            }
        }


class PredictionResponse(BaseModel):
    predicted_popularity: float
    feature_importance: dict


@app.post("/predict/", response_model=PredictionResponse)
async def predict_popularity(features: SongFeatures):
    try:
        features_array = np.array(
            [
                [
                    features.duration_ms,
                    features.acousticness,
                    features.danceability,
                    features.energy,
                    features.instrumentalness,
                    features.key,
                    features.liveness,
                    features.loudness,
                    features.audio_mode,
                    features.speechiness,
                    features.tempo,
                    features.time_signature,
                    features.audio_valence,
                ]
            ]
        )

        scaled_features = scaler.transform(features_array)

        prediction = model.predict(scaled_features)[0]

        feature_importance = {}
        if hasattr(model, "feature_importance_"):
            feature_names = [
                "duration_ms",
                "acousticness",
                "danceability",
                "energy",
                "instrumentalness",
                "key",
                "liveness",
                "loudness",
                "audio_mode",
                "speechiness",
                "tempo",
                "time_signature",
                "audio_valence",
            ]
            importance_values = model.feature_importance_
            feature_importance = dict(zip(feature_names, importance_values.tolist()))

        return PredictionResponse(
            predicted_popularity=float(prediction),
            feature_importance=feature_importance,
        )
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


@app.get("/")
async def root():
    return {
        "Message": "Welcom to song Poplarity Predictor API",
        "doc_url": "/docs",
        "openapi_url": "/openapi.json",
    }
