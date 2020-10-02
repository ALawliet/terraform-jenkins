@Library('shared-library@master') _
@Library('shared-resources@master') _2
import org.foo.Point
import providers.AWS

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

                    def point = new Point(1f, 2f, 3f)
                    echo "point ${point}"

                    def pyscript = libraryResource 'helloworld.py'
                    writeFile file: 'helloworld.py', text: pyscript
                    sh 'python helloworld.py'

                    def ansiblescript = libraryResource 'helloworld.yaml'
                    writeFile file: 'helloworld.yaml', text: ansiblescript
                    sh 'ansible-playbook helloworld.yaml'

                    // def terraformscript = libraryResource './terraform/main.tf'
                    // writeFile file: './terraform/main.tf', text: terraformscript
                    // dir('./terraform') {
                    //     sh 'terraform init'
                    //     sh 'terraform validate'
                    //     sh 'terraform plan'
                    // }
                }
            }
        }

        stage('Use AWS package') {
            steps {
                script {
                    def providerConfig = [region:"us-east-1"]
                    def aws = new AWS(this, providerConfig)
                    def readProviderConfig = aws.getProviderConfig()
                    echo "readProviderConfig ${readProviderConfig}"
                    def dns = aws.DNS()
                    def resourceConfig = [name:"www.example.com", type:"A", ttl:"300"]
                    def addRecordRes = dns.addRecord(resourceConfig)
                    echo "resourceConfig ${addRecordRes}"
                    def thing = dns.getThing()
                    echo "thing ${thing}"
                    def script = dns.readScript()
                    echo "script ${script}"
                    dns.executeTerraform()
                    // dns.executeTerraform2()
                    def json = dns.getResourceConfigAsJSON(resourceConfig)
                    echo "json ${json}"
                    dns.executeTerraformWithVars(resourceConfig)
                }
            }
        }
    }
}

def getTerraformPath() {
    def tfHome = tool name: 'terraform-13', type: 'terraform'
    return tfHome
}
