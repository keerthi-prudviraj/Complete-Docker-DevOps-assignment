pipeline {
    agent { label "dev" }

    options {
        skipDefaultCheckout(true)
    }

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

        stage("Push to Docker Hub") {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: "dockerHubcredsAP",
                        usernameVariable: "dockerHubUser",
                        passwordVariable: "dockerHubPass"
                    )
                ]) {
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

    post {

        success {
            emailext(
                to: "keerthiprudvi599@gmail.com",
                subject: "SUCCESS: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                body: """
Hello,

Jenkins pipeline completed successfully.

Job Name: ${env.JOB_NAME}
Build Number: ${env.BUILD_NUMBER}
Build Status: SUCCESS

Build URL:
${env.BUILD_URL}

All stages completed successfully.

Regards,
Jenkins
"""
            )
        }

        failure {
            emailext(
                to: "keerthiprudvi599@gmail.com",
                subject: "FAILED: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                body: """
Hello,

Jenkins pipeline has FAILED.

Job Name: ${env.JOB_NAME}
Build Number: ${env.BUILD_NUMBER}
Build Status: FAILURE

Please check the Jenkins console output.

Build URL:
${env.BUILD_URL}

Regards,
Jenkins
"""
            )
        }
    }
}
