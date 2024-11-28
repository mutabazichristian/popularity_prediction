# Use the appropriate base image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file first (for better caching)
COPY requirements.txt .

# Install dependencies
RUN pip install -r requirements.txt

# Copy the rest of the application files into the container
COPY . .

# Ensure the model file is in the right place
COPY Random_Forest_model.pkl /app/Random_Forest_model.pkl

# Set the entry point for the application
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
