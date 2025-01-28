FROM python:3.11-slim

WORKDIR /app

SHELL ["/bin/bash", "-c"]

EXPOSE 5000

STOPSIGNAL SIGTERM

# Copy the requirements file and install dependencies
COPY requirements.txt /app
RUN pip install -r requirements.txt

# Copy the application files
COPY . /app

# Healthcheck to verify the service is running
HEALTHCHECK --interval=30s --timeout=5s \
            --retries=3 CMD curl --fail http://localhost:5000/ || exit 1

# Command to run the Python application
CMD ["python", "app.py"]
