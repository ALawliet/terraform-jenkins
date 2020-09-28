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
    }
}

def getTerraformPath() {
    def tfHome = tool name: 'terraform-13', type: 'terraform'
    return tfHome
}
