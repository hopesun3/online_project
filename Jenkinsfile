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
                checkout([$class: 'GitSCM',  poll: true, branches: [[name: '*/main']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/hopesun3/Online_Fruits_And_Veggies_DEVOPS.git']]])
				fileOperations([fileZipOperation(folderPath: '', outputFolderPath: '/home/jenkins/jenkins-data/online_project/'), fileRenameOperation(destination: '/home/jenkins/jenkins-data/online_project/Build.zip', source: '/home/jenkins/jenkins-data/online_project/CI_CD_Pipeline_main.zip')]) 
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
		 
	  sh '''scp -o StrictHostKeyChecking=no -i "/home/jenkins/jenkins-data/online_project/key4ssh.pem" /home/jenkins/jenkins-data/online_project/Build.zip ec2-user@34.233.197.59:/home/ec2-user/EAPP

      ssh -i "/home/jenkins/jenkins-data/online_project/key4ssh.pem" ec2-user@34.233.197.59 "cd EAPP; sh deployment.sh"
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
}
}
