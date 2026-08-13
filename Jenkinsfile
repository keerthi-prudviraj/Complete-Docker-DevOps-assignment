pipeline {
    agent any

    stages {

        stage("Code") {
            steps {
                echo "Cloning code..."
                git branch: 'main',
                    url: 'https://github.com/keerthi-prudviraj/Complete-Docker-DevOps-assignment.git'
            }
        }

        stage("Build") {
            steps {
                echo "Building Docker image..."
                sh 'docker build -t demo-app .'
            }
        }

        stage("Test") {
            steps {
                echo "Running tests..."
                echo "Tests will be added here"
            }
        }

        stage("Deploy") {
            steps {
                echo "Deploying application..."
                sh 'docker compose up -d'
            }
        }
    }
}
