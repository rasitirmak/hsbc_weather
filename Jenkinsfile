pipeline {
    
    agent any
    
    stages {
        stage('Code checkout') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/rasitirmak/hsbc_weather.git']]])                   }
        }
    
    // Building Docker images
        stage('Building image') {
            steps {
                sh 'mvn clean package -f ./weather-api'
                sh 'docker build -t "weather-api" ./weather-api'
                sh 'docker login -u admin -p 12345 http://44.194.255.37:8081'
                // sh 'docker login --username=MYUSERNAME --password=MYPASSWORD'
                sh 'docker push http://44.194.255.37:8081/repository/weather-docker-private-repo/weather-api:1.0'
            }
        }
        stage('Building image') {
            steps {
                sh 'docker build -t "weather-ui" ./weather-ui'
                sh 'docker login -u admin -p 12345 http://44.194.255.37:8081'              
                sh 'docker push http://44.194.255.37:8081/repository/weather-docker-private-repo/weather-api:1.0'
            }
        }
    }
}
