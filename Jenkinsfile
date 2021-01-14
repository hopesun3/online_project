def Build_pass=true
def Deploy_to_Dev_pass=true
def UnitTest_pass=true
def Deploy_to_QA_pass=true
def E2e_tests_pass= true
pipeline {
agent any
  
stages {
         
stage('Build') {
            steps {
               script{
                   try{
            
                     if (fileExists('/home/jenkins/jenkins-data/online_project/Build.zip')) {
                     sh '''cd /
                     cd /home/jenkins/jenkins-data/online_project
                     rm -rf Build.zip'''
                     } else {
                         echo 'No Build.zip Found'
                     }
                checkout([$class: 'GitSCM',  poll: true, branches: [[name: '*/main']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/hopesun3/online_project.git']]])
	        fileOperations([fileZipOperation(folderPath: '', outputFolderPath: '/var/jenkins_home/'), fileRenameOperation(destination: '/var/jenkins_home/Build.zip', source: '/var/jenkins_home/CI_CD_Pipeline_main.zip')]) 
        }
        catch (Exception e){
        Build_pass = false
    }
        }
             }
        }      
        
stage('deploy_to_Dev'){
	
	 steps {
		 script
		 {
		 
	   if(Build_pass){
		 
	  sh '''scp -o StrictHostKeyChecking=no -i "/var/jenkins_home/ec2key.pem" /var/jenkins_home/Build.zip ec2-user@54.234.254.46:/home/ec2-user/EAPP

ssh -i "/var/jenkins_home/ec2key.pem" ec2-user@54.234.254.46 "cd EAPP; sh deployment.sh"
'''

}
}
}
}

stage('UnitTest'){

    steps {
     
     script{
	 
	 if(Deploy_to_Dev_pass){
	 
	 try{
        checkout([$class: 'GitSCM', branches: [[name: '*/main']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/hopesun3/UnitTests_Devops.git']]])
		
		}
		catch(Exception e){
		UnitTest_pass=false
     }
     
}
	 
    }
}



}

stage('deploy_to_Test'){
	
	 steps {
		 script
		 {
		 
	   if(Build_pass){
		 
	  sh '''scp -o StrictHostKeyChecking=no -i "/var/jenkins_home/ec2key.pem" /var/jenkins_home/Build.zip ec2-user@54.234.254.46:/home/ec2-user/EAPP

ssh -i "/var/jenkins_home/ec2key.pem" ec2-user@54.234.254.46 "cd EAPP; sh deployment.sh"
'''

}
}
}
}



}
}
