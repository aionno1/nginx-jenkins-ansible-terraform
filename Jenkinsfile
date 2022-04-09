pipeline {
  agent any
  parameters {
    choice(
        name: 'Action',
        choices: "apply\ndestroy",
        description: 'Apply or Destroy the instance' )
  }
  stages {

    stage('Checkout') {
        steps {
            git branch: 'master', credentialsId: 'Github', url: 'git@github.com:aionno1/nginx-jenkins-ansible-terraform.git'
        }
    }

    stage('Terraform') {
      steps {
        script {
          if (params.Action == "apply") {
            sh 'terraform -chdir=terraform/static-site init'
            sh 'terraform apply -var "name=hello" -var "group=web" -var "region=us-east-1" -var "profile=DevOpsUser" --auto-approve terraform/static-site'
          } 
          else {
            sh 'terraform destroy -var "name=hello" -var "group=web" -var "region=us-east-1" -var "DevOpsUser" --auto-approve -chdir=terraform/static-site'
          }
        }
      }
    }

    stage('Ansible') {
      steps {
        retry(count: 5) {
          sh 'ansible-playbook -i /etc/ansible/aws_ec2.yaml ansible/static-site/site.yaml'
        }
      }cd 
    }
  }
}