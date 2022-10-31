pipeline {
    agent any
    environment {
        AWS_ACCOUNT_ID="224316520039"
        AWS_DEFAULT_REGION="ap-northeast-1" 
        IMAGE_REPO_NAME="node-ecr-test"
        IMAGE_TAG="v6"
        REPOSITORY_URI = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}"
    }
   
    stages {
        
         stage('Logging into AWS ECR') {
            steps {
                script {
                sh "aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com"
                }
                 
            }
        }
        
        stage('Cloning Git') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: '', url: 'https://github.com/RNK9629/nodejs-sample-test.git']]])     
            }
        }
        stage('Building image') {
            steps{
                script {
                    dockerImage = docker.build "${IMAGE_REPO_NAME}:${IMAGE_TAG}"
                    
                }
                
            }
            
        }
        stage('Pushing to ECR') {
            steps{  
                script {
                    sh "docker tag ${IMAGE_REPO_NAME}:${IMAGE_TAG} ${REPOSITORY_URI}:$IMAGE_TAG"
                    sh "docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}:${IMAGE_TAG}"
                    
                }
                
            }
            
        }
        stage('ECS'){
            steps{
                script{
                    sh "sed -e  node-signup.json > node-signup-v5.json"
                    sh "aws ecs register-task-definition --cli-input-json file://node-signup-v5.json"
                }
            }
        }
        
    }
}
