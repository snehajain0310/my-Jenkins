pipeline {
  agent any
  
  parameters {
   choice(name: 'action', choices: ['plan','show','apply','destroy'], description: 'Image name to publish')
                }
  
   stages {
     
     stage('Cloning source code from Git')
     {
         steps{
         git branch: 'COMPLETE', url: 'https://github.com/onkardevops7m/DevOpsEnvironment.git'
         }
    }
     
     stage('Prepare COMPLETE Environment configuration') {
         steps{
         script{
        sh 'terraform init'
        if (params.action == "apply") {
            echo "Creating  ENV"
            sh "terraform ${params.action} -auto-approve -lock=false -no-color"
        } else {
            echo "Destorying ENV"
            sh "terraform ${params.action} -auto-approve -lock=false -no-color"
        }
        }
        }
     }
   }
 }
