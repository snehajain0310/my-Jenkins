
pipeline {
  agent any

   parameters {
  choice choices: ['COMPLETE', 'VPC', 'WEBSERVER'], description: '', name: 'ENV'
  choice choices: ['CREATE', 'DESTROY',], description: '', name: 'ACTION'
                }
 
  stages {
      
       stage ('manager permmision')
    {
        steps{
          mail bcc: '', body: "we are working on AWS Environment with ${params.ENV} for ${params.ACTION} please gives us approval.", cc: '', from: '', replyTo: '', subject: 'For Approval', to: 'onkardevops7m@gmail.com'
          echo 'mail sent'
        }
    }
    
    stage('Configuration Approval') {
        steps{
        input "Do you want to proceed for deployment?"
        echo 'asking for input'
            
        }
    }
      
      
    stage("New Infrastructure Deployment") {
         steps{
         script{
             
        if (params.ENV == "COMPLETE") {
            if (params.ACTION == "CREATE")
            {
            echo "=====>> Creating ${params.ENV} ENV"
            build job: "${params.ENV}", parameters: [string(name: 'action', value: 'apply')], wait: true
        } 
        else
        {
            echo "=====>> Destorying ${params.ENV} ENV"
            build job: "${params.ENV}", parameters: [string(name: 'action', value: 'destroy')]
        }
        }
        
        if (params.ENV == "VPC") {
            if (params.ACTION == "CREATE")
            {
            echo "=====>> Creating ${params.ENV} ENV"
            build job: "${params.ENV}", parameters: [string(name: 'action', value: 'apply')], wait: true
        } 
        else
        {
            echo "=====>> Destorying ${params.ENV} ENV"
            build job: "${params.ENV}", parameters: [string(name: 'action', value: 'destroy')]
        }
        }
        
        if (params.ENV == "WEBSERVER") {
            if (params.ACTION == "CREATE")
            {
            echo "=====>> Creating ${params.ENV} ENV"
            build job: "${params.ENV}", parameters: [string(name: 'action', value: 'apply')], wait: true
        } 
        else
        {
            echo "=====>> Destorying ${params.ENV} ENV"
            build job: "${params.ENV}", parameters: [string(name: 'action', value: 'destroy')]
        }
        }
        }
        }
   }
   
      }
     
}
