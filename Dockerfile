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

# Update and install OpenJDK 17
RUN apt-get update && \
    apt-get install -y openjdk-17-jdk wget unzip && \
    apt-get clean

# Verify Java installation
RUN java -version

# Set JAVA_HOME environment variable
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
ENV PATH="$JAVA_HOME/bin:$PATH"

# Install Allure
RUN apt-get update && \
    apt-get install -y curl unzip && \
    curl -LO https://github.com/allure-framework/allure2/releases/download/2.32.2/allure-2.32.2.zip && \
    unzip allure-2.32.2.zip && \
    mv allure-2.32.2 /opt/allure-2.32.2 && \
    ln -s /opt/allure-2.32.2/bin/allure /usr/bin/allure
    
# Verify installation
RUN allure --version

# Default command (overridden in cloudbuild.yaml)
#CMD ["sh", "-c", "pytest --alluredir=allure-results && allure generate --clean -o allure-report allure-results"]
