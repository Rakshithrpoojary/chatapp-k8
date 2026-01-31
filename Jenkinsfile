pipeline{
    agent {label "jenkins-agent"}
    tools{
        nodejs 'node22'
    }
    environment{
        SCANNER_HOME=tool 'sonar-scanner'
        AWS_ACCOUNT_ID = credentials('ACCOUNT_ID')
        AWS_ECR_REPO_NAME = credentials('ECR_REPO1')
        AWS_DEFAULT_REGION = 'ap-south-1'
        REPOSITORY_URI = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/"
    }
    stages{
        stage("cleanws")
        {
            steps{
                cleanWs()
            }
        }
        stage("Checkout code"){
            steps{
          
                    git branch: "main",url: 'https://github.com/Rakshithrpoojary/chatapp-k8.git',credentialsId: 'git-cred'
                
            }
        }
        stage("Install pakages")
        {
            steps{
                dir('frontend')
                {
                sh "npm install"

                }
            }
        }
        stage("Trivy scanner for dependency")
        {
            steps{
                sh "trivy fs . > trivy.txt"
            }
        }
        stage("Sonar scann")
        {
            steps{
                dir("frontend"){
                withSonarQubeEnv("sonar-cred-main")
                {
                 sh ''' $SONAR_HOME/bin/sonar-scanner \
                 -Dsonar.projectName="ecommercesecond" \
                 -Dsonar.projectKey =""ecommercesecond
                 '''   
                }
                }
             
            }
        }
        stage("quality gate")
        {
            steps{
                waitForQualityGate(abortPipeline: false, credentialsId:'sonar-token')
            }
        }
        stage('build docker image'){
            steps{
                   sh  'docker system prune -f'
                   sh  'docker build --build-arg REACT_APP_CLOUD_NAME_CLOUDINARY=dnbnsimy4 --build-arg REACT_APP_BACKEND_URI=http://13.232.189.213:4000 -t ${AWS_ECR_REPO_NAME} frontend'   
            }
        }
        stage("Scan docker image")
        {
            steps{
                sh 'trivy image {AWS_ECR_REPO_NAME} > trivyimage.txt'
            }
        }
        stage("Push to ecr")
        {
            steps{
                sh 'aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${REPOSITORY_URI}'
                sh 'docker tag ${AWS_ECR_REPO_NAME} ${REPOSITORY_URI}${AWS_ECR_REPO_NAME}:${BUILD_NUMBER}'
                sh 'docker push ${REPOSITORY_URI}${AWS_ECR_REPO_NAME}:${BUILD_NUMBER}'
            }
        }
    }


    

}
