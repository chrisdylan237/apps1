pipeline {
    agent any

    parameters {
        string(name: 'REPO_URL', defaultValue: 'https://github.com/chrisdylan237/apps1.git', description: 'Enter your Repository URL')
        string(name: 'BRANCH', defaultValue: 'your-branch', description: 'Enter the Branch to clone')
        string(name: 'CREDENTIALS_ID', defaultValue: 'your-credentials-id', description: 'Enter your Git Credentials ID')
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
    }
}
