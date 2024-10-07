#Jenkins Pipeline for Docker Image Build and Security Scan
This project demonstrates a CI/CD pipeline using Jenkins to automate the following tasks:

Clone the repository.
Scan the application code for vulnerabilities.
Build a Docker image for the application.
Scan the Docker image for vulnerabilities using Trivy.
Push the Docker image to DockerHub.
Pipeline Overview
The Jenkins pipeline consists of the following stages:

1. Git Clone
This stage clones the repository from the GitHub repo provided to Jenkins.

2. Code Scan
This stage performs a code scan to check for any vulnerabilities or issues in the application code.

3. Build Docker Image
This stage builds a Docker image for the application using the Dockerfile in the repository.

4. Trivy Image Scan
Trivy is used to scan the built Docker image for security vulnerabilities.

5. Push to DockerHub
If the image passes all the scans, it is pushed to DockerHub for deployment or further use.
