pipeline {
    agent any

    tools {
        maven 'Maven'   
        jdk 'Java'      
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/babaly/221-java-project.git'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean compile'
            }
        }

        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }

        stage('Package') {
            steps {
                sh 'mvn package'
            }
            post {
                success {
                    archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
                }
            }
        }
    }
}
