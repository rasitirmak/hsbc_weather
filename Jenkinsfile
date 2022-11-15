pipeline {
    
    agent any
    
    environment {
        imageName = "myweatherapp"
        registryCredentials = "nexus"
        registry = "http://18.204.243.118:8085/"
        dockerImage = ''
    }
    
    stages {
        stage('Code checkout') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/rasitirmak/hsbc_weather.git']]])                   }
        }
    
    // Building Docker images
        stage('Building image') {
            steps {
                sh './mvnw clean package'
                sh 'docker-compose -f docker-compose.yml up'
            }
        }

    // Uploading Docker images into Nexus Registry
        stage('Uploading to Nexus') {
            steps{  
                script {
                    docker.withRegistry( 'http://'+registry, registryCredentials ) {
                    dockerImage.push('latest')
                    }
                }
            }
        }
    
    // Stopping Docker containers for cleaner Docker run
        stage('stop previous containers') {
            steps {
                sh 'docker ps -f name=myphpcontainer -q | xargs --no-run-if-empty docker container stop'
                sh 'docker container ls -a -fname=myphpcontainer -q | xargs -r docker container rm'
            }
       }
      
        stage('Docker Run') {
            steps{
                script {
                    sh 'docker run -d -p 80:80 --rm --name myphpcontainer ' + registry + imageName
                }
            }
        }    
    }
}

// pipeline {
//     agent any
//     environment {
//         ECR_REGISTRY = "<aws_account_id>.dkr.ecr.us-east-1.amazonaws.com"
//         APP_REPO_NAME= "clarusway/to-do-app"
//     }
//     stages {
//         stage('Build Docker Image') {
//             steps {
//                 sh 'docker build --force-rm -t "$ECR_REGISTRY/$APP_REPO_NAME:latest" .'
//                 sh 'docker image ls'
//             }
//         }
//         stage('Push Image to ECR Repo') {
//             steps {
//                 sh 'aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin "$ECR_REGISTRY"'
//                 sh 'docker push "$ECR_REGISTRY/$APP_REPO_NAME:latest"'
//             }
//         }
//     }
//     post {
//         always {
//             echo 'Deleting all local images'
//             sh 'docker image prune -af'
//         }
//     }
// }