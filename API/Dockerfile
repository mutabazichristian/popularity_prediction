
# Use the appropriate base image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Copy the rest of the application files into the container
COPY . /app

# Ensure the model file is in the right place
COPY Random_Forest_model.pkl best_model.pkl /app/best_model.pkl

# Install dependencies
RUN pip install -r requirements.txt

# Set the entry point for the application
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]

