FROM python:3.12-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    APP_HOME=/app

# Set work directory
WORKDIR $APP_HOME

# Install system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ffmpeg \
        git && \
    rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt .
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . .

# Create a non-root user and group `appuser`
#RUN addgroup --system appgroup && \
#    adduser --system --ingroup appgroup appuser

# Change ownership of the application directory
#RUN chown -R appuser:appgroup $APP_HOME

# Switch to the non-root user
#USER appuser

# Expose port 7860
EXPOSE 7860

# Define the default command to run the application
CMD ["python", "app.py"]