# Use the official Python image from the Docker Hub
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file into the container
COPY requirements.txt .

# Install the dependencies
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copy the rest of the application code into the container
COPY . .

# Install Allure command-line tool
RUN apt-get update && \
    apt-get install -y curl gnupg && \
    curl -sL https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | apt-key add - && \
    echo "deb https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/ $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/adoptopenjdk.list && \
    apt-get update && \
    apt-get install -y adoptopenjdk-11-hotspot && \
    curl -sL https://github.com/allure-framework/allure2/releases/download/2.13.8/allure-2.13.8.tgz | tar -xz -C /opt && \
    ln -s /opt/allure-2.13.8/bin/allure /usr/bin/allure

# Default command (overridden in cloudbuild.yaml)
#CMD ["sh", "-c", "pytest --alluredir=allure-results && allure generate --clean -o allure-report allure-results"]
