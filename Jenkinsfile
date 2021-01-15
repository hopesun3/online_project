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
            
               if (fileExists('/home/jenkins/online/Build.zip')) {
                 sh '''cd /
                cd /home/jenkins/online
                rm -rf Build.zip'''
                } else {
                  echo 'No Build.zip Found'
                }
                checkout([$class: 'GitSCM',  poll: true, branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/hopesun3/online_project.git']]])
		fileOperations([fileZipOperation(folderPath: '', outputFolderPath: '/home/jenkins/online/'), fileRenameOperation(destination: '/home/jenkins/online/Build.zip', source: '/home/jenkins/online_project/CI_CD_Pipeline_main.zip')]) 
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
		 
	  sh '''scp -o StrictHostKeyChecking=no -i "/home/jenkins/online/key4ssh.pem" /home/jenkins/online/Build.zip ec2-user@34.233.197.59:/home/ec2-user/EAPP

      ssh -i "/home/jenkins/online/key4ssh.pem" ec2-user@34.233.197.59 "cd EAPP; sh deployment.sh"
'''

}
}
}
}

}
}
