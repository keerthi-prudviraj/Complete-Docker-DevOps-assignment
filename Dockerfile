# Use an official lightweight Python image
FROM python:3.12-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the dependency file into the container
COPY requirements.txt .

# Install Python dependencies without caching packages
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application source code
COPY app.py .

# Document that the application listens on port 80
EXPOSE 80

# Start the Flask application
CMD ["python", "app.py"]