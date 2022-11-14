pipeline {
    agent any
    environment {
        AWS_ACCOUNT_ID="224316520039"
        AWS_DEFAULT_REGION="ap-southeast-2" 
	    CLUSTER_NAME="cluster-002"
	    SERVICE_NAME="service-ecs"
	    TASK_DEFINITION_NAME="nodejs"
	    DESIRED_COUNT="1"
        IMAGE_REPO_NAME="224316520039.dkr.ecr.ap-southeast-2.amazonaws.com/node-ecs"
        IMAGE_TAG="${env.BUILD_ID}"
        REPOSITORY_URI = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}"
	registryCredential = "admin-demo"
    }
   
    stages {
        
    // Building Docker images
    stage('Building image') {
      steps{
        script {
          dockerImage = docker.build "${IMAGE_REPO_NAME}:${IMAGE_TAG}"
        }
      }
    }
   
    // Uploading Docker images into AWS ECR
    stage('Pushing to ECR') {
     steps{  
         script {
			docker.withRegistry("https://" + REPOSITORY_URI, "ecr:${AWS_DEFAULT_REGION}:" + registryCredential) {
                    	dockerImage.push()
                	}
         }
        }
      }
      
    stage('Deploy') {
     steps{
            withAWS(credentials: registryCredential, region: "${AWS_DEFAULT_REGION}") {
                script {
			sh 'sh script.sh'
                }
            } 
        }
      }      
      
    }
}
