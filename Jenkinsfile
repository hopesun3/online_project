def Build_pass=true
pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Build Steps'
                script{
	                 try{
		                if (fileExists('/var/jenkins_home/onlinepipeline.zip')) {
			               sh '''cd /var/jenkins_home
			               rm -rf Build.zip'''
			              } else {
			                  echo 'No Build.zip Found'
			                } 
                        checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/hopesun3/online_project.git']]])
                        fileOperations([fileZipOperation(folderPath: '/var/jenkins_home/workspace/onlinepipeline', outputFolderPath: '/var/jenkins_home')])
	                }
	                 catch (Exception e){
	                   Build_pass = false
                   }
                }
	           }
        }
        stage('deploy_to_Dev') {
            steps {
                echo 'Deploy to dev'
                script{
                  if(Build_pass){
                    sh '''scp -o StrictHostKeyChecking=no -i "/var/jenkins_home/key4ssh.pem" /var/jenkins_home/onlinepipeline.zip ec2-user@34.233.197.59:/home/ec2-user/EAPP
                    ssh -i "/var/jenkins_home/key4ssh.pem" ec2-user@34.233.197.59 "cd EAPP; sh deployment.sh"
                    '''
                 }
               } 
            }
        }
        stage('deploy_to_Test') {
            steps {
                echo 'Deploy to test'
                script{
                  if(Build_pass){
                    sh '''scp -o StrictHostKeyChecking=no -i "/var/jenkins_home/key4ssh.pem" /var/jenkins_home/onlinepipeline.zip ec2-user@50.16.174.212:/home/ec2-user/EAPP
                    ssh -i "/var/jenkins_home/key4ssh.pem" ec2-user@50.16.174.212 "cd EAPP; sh deployment.sh"
                    '''
                 }
               } 
            }
        }
    }
}

