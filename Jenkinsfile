pipeline {
    agent any

    stages {

        stage("Code") {
            steps {
                echo "Code clone ho gaya"

                git url: "https://github.com/keerthi-prudviraj/Complete-Docker-DevOps-assignment.git",
                    branch: "main"
            }
        }

        stage("Build") {
            steps {
                sh "docker build -t my-app:latest ."
            }
        }

        stage("Test") {
            steps {
                echo "Developer/Tester tests likh k degaa"
            }
        }

        stage("Push to docker hub") {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: "dockerHubcredsAP",
                    usernameVariable: "dockerHubUser",
                    passwordVariable: "dockerHubPass"
                )]) {
        
                    sh '''
                        echo "$dockerHubPass" | docker login -u "$dockerHubUser" --password-stdin
        
                        docker tag my-app:latest "$dockerHubUser/complete-docker-devops-assignment:latest"
        
                        docker push "$dockerHubUser/complete-docker-devops-assignment:latest"
        
                        docker logout
                    '''
                }
            }
        }

        stage("Deploy") {
            steps {
                sh "docker compose up -d --build"
            }
        }
    }
}
