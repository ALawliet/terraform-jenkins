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
                sh 'terraform init ./terraform'
                sh 'terraform validate ./terraform'
                sh 'terraform plan -detailed-exit-code -out=plan.out ./terraform'
                sh 'terraform apply plan.out'
            }
        }
    }
}

def getTerraformPath() {
    def tfHome = tool name: 'terraform-13', type: 'terraform'
    return tfHome
}
