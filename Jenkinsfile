@Library('shared-library@master') _

pipeline {
    agent any

    environment {
        PATH = "${PATH}:${getTerraformPath()}"
    }

    stages {
        stage('say hello') {
            steps {
                echo 'hello world'
            }
        }

        stage('S3 - Create Bucket w/ Ansible') {
            steps {
                sh 'ansible-playbook ./ansible/s3-bucket.yaml'
            }
        }

        stage('Route53 - Add Record w/ Terraform') {
            steps {
                sh 'terraform init'
                sh 'terraform validate'
                sh 'terraform plan'
                sh 'terraform apply -auto-approve'
            }
        }

        stage('Route53 - Add Record w/ Ansible') {
            steps {
                sh 'ansible-playbook ./ansible/route53.yaml'
            }
        }

        stage('Check logs') {
            steps {
                filterLogs('WARNING', 1)
            }
        }
    }
}

def getTerraformPath() {
    def tfHome = tool name: 'terraform-13', type: 'terraform'
    return tfHome
}
