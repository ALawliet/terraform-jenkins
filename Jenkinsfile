@Library('shared-library@master') _
@Library('shared-resources@master') _2
import org.foo.Point

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

        stage('Load resource') {
            steps {
                script {
                    def request = libraryResource 'request.json'
                    echo "request ${request}"
                    def request2 = libraryResource 'request2.json'
                    echo "request2 ${request2}"
                    def point = new Point(1.0, 2.0, 3.0)
                    echo "point ${point}"
                }
            }
        }
    }
}

def getTerraformPath() {
    def tfHome = tool name: 'terraform-13', type: 'terraform'
    return tfHome
}
