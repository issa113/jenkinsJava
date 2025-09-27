pipeline {
    agent any  

    environment {
        DOCKER_HUB_REPO = 'issa293/jenkinsjava' 
        IMAGE_TAG = "latest" 
        RENDER_SERVICE_ID = 'srv-d378rfmr433s73ehe220'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', 
                     url: 'https://github.com/issa113/jenkinsJava.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Pour Windows, on utilise la commande docker build directement
                    bat "docker build -t ${env.DOCKER_HUB_REPO}:${env.IMAGE_TAG} ."
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    withCredentials([usernamePassword(
                        credentialsId: 'dockerhub-credentials', 
                        usernameVariable: 'DOCKER_USER', 
                        passwordVariable: 'DOCKER_PASS'
                    )]) {
                        bat """
                            echo %DOCKER_PASS% | docker login -u %DOCKER_USER% --password-stdin
                            docker push ${env.DOCKER_HUB_REPO}:${env.IMAGE_TAG}
                            docker logout
                        """
                    }
                }
            }
        }

        stage('Deploy to Render') {
            steps {
                script {
                    withCredentials([string(credentialsId: 'render-api-key', variable: 'RENDER_API_KEY')]) {
                        bat """
                            curl -X POST ^
                                -H "Authorization: Bearer %RENDER_API_KEY%" ^
                                -H "Content-Type: application/json" ^
                                https://api.render.com/v1/services/${env.RENDER_SERVICE_ID}/deploys
                        """
                    }
                }
            }
        }
    }

    post {
        always {
            bat 'docker rmi %DOCKER_HUB_REPO%:%IMAGE_TAG% || echo "Image cleanup failed or image not found"'
        }
        success {
            echo 'Pipeline réussi ! Image pushée et déployée sur Render.'
        }
        failure {
            echo 'Pipeline échoué. Vérifiez les logs.'
        }
    }
}