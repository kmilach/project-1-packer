pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID = credentials('jenkins-aws-secret-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('jenkins-aws-secret-access-key')
    }

    stages {
        stage('Build AMI image') {
            steps {
                echo "Initializing and installing Packer plugins..."
                sh "/usr/bin/packer init packer.pkr.hcl"

                echo "Build AMI image with Packer..."
                sh "/usr/bin/packer build -var 'ansible_playbook=playbook.yml' packer.pkr.hcl"
            }
        }
    }