pipeline {
    agent any
    stages{
        stage('Git Checkout') {
            steps{
                git branch: 'main', url: 'https://github.com/Moreira-Junior/go-calculator.git'
            }
        }
        stage('creating image and running it') {
            steps{
                sh """
                #!/bin/bash
                docker build -t tema19 .
                docker run -d tema19
                """
            }
        
    }
}
}