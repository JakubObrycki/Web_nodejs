pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS = credentials('jen-dockerhub')
        dockerTag='firstimage'
        imageName='nodejs'
    }

    stages {
        stage('Git checkout') {
            steps { 
               checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'jen-doc-token', url: 'https://github.com/JakubObrycki/WebSite.git']])
            }
        }
        stage('Build image') {
            steps {
                script {
                    sh 'docker build -t $imageName .' 
                    sh "echo 'Succeeded'"
                }
            }
        }
        stage('Login and push image') {
            steps {
                script {
                    sh 'echo $DOCKER_CREDENTIALS_PSW | docker login -u $DOCKER_CREDENTIALS_USR --password-stdin'
                    sh 'docker tag $imageName $DOCKER_CREDENTIALS_USR/$imageName'
                    sh 'docker push $DOCKER_CREDENTIALS_USR/$imageName'
                    sh "echo 'Succeeded'"
                }
            } 
        }
        stage ('Deploy kubernetes via Ansible') {
            steps {
                script {
                    sh 'ansible-playbook k8s-pod-service.yml'
                    sh "echo 'Succeeded'"
                }
            }
        }
    }
}
