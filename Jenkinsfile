pipeline{
    agent {label "jenkins-agent"}
 
    stages{
        stage("cleanws")
        {
            steps{
                cleanWs()
            }
        }
        stage("Checkout code"){
            steps{
                    git branch: "main",url: 'https://github.com/Rakshithrpoojary/chatapp-k8.git', credentialsId: 'git-cred'
            }
        }
        // stage("Install pakages")
        // {
        //     steps{
        //         sh "npm install"
        //     }
        // }
        // stage("Trivy scanner for dependency")
        // {
        //     steps{
        //         sh "trivy fs . > trivy.txt"
        //     }
        // }
        // stage("Sonar scann")
        // {
        //     steps{
        //         dir("frontend"){
        //         withSonarQubeEnv("sonar-cred")
        //         {
        //          sh ''' $SONAR_HOME/bin/sonar-scanner \
        //          -Dsonar.projectName="ecommercesecond" \
        //          -Dsonar.projectKey =""ecommercesecond
        //          '''   
        //         }
        //         }
             
        //     }
        // }
        // stage("quality gate")
        // {
        //     steps{
        //         waitForQualityGate(abortPipeline: false, credentialsId:'sonar-token')
        //     }
        // }
        stage('build docker image'){
            steps{
                   sh  'docker system prune -f'
                   sh  'docker build --build-arg REACT_APP_CLOUD_NAME_CLOUDINARY=ecommerce --build-arg REACT_APP_BACKEND_URI=http://13.232.189.213:4000 -t frontend frontend'
      
                   sh  'docker build -t backend backend'
                
            }
        }
        // stage("Scan docker image")
        // {
        //     steps{
        //         sh 'trivy image frontend > trivyimage.txt'
        //         sh 'trivy image backend > trivyimage.txt'
        //     }
        // }
        stage("dockercompose")
        {
            steps{
                sh "docker compose up -d"
            }
        } 
    }


    

}