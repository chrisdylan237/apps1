pipeline {
    agent any

    parameters {
        string(name: 'REPO_URL', defaultValue: 'https://github.com/chrisdylan237/apps1.git', description: 'Enter your Repository URL')
        string(name: 'BRANCH', defaultValue: 'your-branch', description: 'Enter the Branch to clone')
        string(name: 'CREDENTIALS_ID', defaultValue: 'your-credentials-id', description: 'Enter your Git Credentials ID')
        string(name: 'DOCKERHUB_USERNAME', defaultValue: 'param.dockerhubusername', description: 'Enter your DockerHub Username')
        string(name: 'APP_VERSION', defaultValue: 'param.app_version', description: 'Enter your Application Version')
        string(name: 'APP_NAME', defaultValue: 'your application name', description: 'enter your application name')
    }

    stages {
        stage('Clean Workspace') {
            steps {
                cleanWs()
            }
        }
        stage('Cloning the Repository') {
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
            steps {
                script {
                    // Building Docker image
                    sh "docker build -t ${params.DOCKERHUB_USERNAME}/${params.APP_NAME}:${params.APP_VERSION} ."
                }
            }
        }
    }
}
