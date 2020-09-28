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

        stage('S3 - create bucket') {
            steps {
                sh 'ansible-playbook ./ansible/s3-bucket.yaml'
            }
        }

        stage('terraform init and apply') {
            steps {
                sh 'terraform init'
                sh 'terraform validate'
                sh 'terraform plan'
                sh 'terraform apply -auto-approve'
            }
        }
    }
}

def getTerraformPath() {
    def tfHome = tool name: 'terraform-13', type: 'terraform'
    return tfHome
}
