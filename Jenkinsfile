pipeline {
    agent any

    parameters {
        string(name: 'REPO_URL', defaultValue: 'https://github.com/chrisdylan237/apps1.git', description: 'Enter your Repository URL')
        string(name: 'BRANCH', defaultValue: 'your-branch', description: 'Enter the Branch to clone')
        string(name: 'CREDENTIALS_ID', defaultValue: 'github-dylan', description: 'Enter your Git Credentials ID')
        string(name: 'DOCKERHUB_USERNAME', defaultValue: 'chrisdylan', description: 'Enter your DockerHub Username')
        string(name: 'APP_VERSION', defaultValue: 'param.app_version', description: 'Enter your Application Version')
        string(name: 'APP_NAME', defaultValue: 'your application name', description: 'Enter your application name')
        string(name: 'container_name', defaultValue: 'your-container-name', description: 'Enter your container name')
        string(name: 'port_number', defaultValue: '8080', description: 'Enter the port number')
        booleanParam(name: 'delete_application', defaultValue: false, description: "Delete application")
        booleanParam(name: 'run_application', defaultValue: false, description: "Run application")
    }

    stages {
        stage('Clean Workspace') {
            when {
                expression { params.run_application }
            }
            steps {
                cleanWs()
            }
        }
        stage('Cloning the Repository') {
            when {
                expression { params.run_application }
            }
            steps {
                script {
                    // Perform the Git clone operation
                    git branch: "${params.BRANCH}", 
                        credentialsId: "${params.CREDENTIALS_ID}", 
                        url: "${params.REPO_URL}"
                }
            }
        }
        stage('SonarQube Analysis') {
            when {
                expression { params.run_application }
            }
            environment {
                SONAR_SCANNER_HOME = tool 'sonar'
            }
            steps {
                withSonarQubeEnv('sonar') {
                    script {
                        sh "${SONAR_SCANNER_HOME}/bin/sonar-scanner"
                    }
                }
            }
        }
        stage('Building Application') {
            when {
                expression { params.run_application }
            }
            steps {
                script {
                    // Building Docker image
                    sh "docker build -t ${params.DOCKERHUB_USERNAME}/${params.APP_NAME}:${params.APP_VERSION} ."
                }
            }
        }
        stage('Login and Push to DockerHub') {
            when {
                expression { params.run_application }
            }
            steps {
                script {
                    // Login to DockerHub using Jenkins credentials
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-dylan', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh "docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD"
                    }
                    // Push Docker image to DockerHub
                    sh "docker push ${params.DOCKERHUB_USERNAME}/${params.APP_NAME}:${params.APP_VERSION}"
                }
            }
        }
        stage('Deploying Application') {
            when {
                expression { params.run_application }
            }
            steps {
                script {
                    // Deploying Docker image
                    sh "docker run -itd -p ${params.port_number}:80 --name ${params.container_name} ${params.DOCKERHUB_USERNAME}/${params.APP_NAME}:${params.APP_VERSION}"
                }
            }
        }
        stage('Delete Application') {
            when {
                expression { params.delete_application }
            }
            steps {
                script {
                    // Deleting the application
                    sh "docker stop ${params.container_name}"
                    sh "docker rm ${params.container_name}"
                }
            }
        }
    }

    post {
        success {
            slackSend(channel: 'google', message: "Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' succeeded.", color: 'good')
        }
        failure {
            slackSend(channel: 'google', message: "Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' failed.", color: 'danger')
        }
    }
}