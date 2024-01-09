pipeline {
    agent any
    
    tools {
        maven 'my_maven'
    }
    
    environment {
        GITNAME = 'An-HyoJun'
        GITMAIL = '97aahhjj@naver.com'
        GITWEBADD = 'https://github.com/An-HyoJun/sb_code.git'
        GITSSHADD = 'git@github.com:An-HyoJun/sb_code.git'
        GITCREDENTIAL = 'git_cre'
        
        DOCKERHUB = 'prehed/spring'
        DOCKERHUBCREDENTIAL = 'docker_cre'
    }

    stages {
        stage('Checkout Github') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [],
                userRemoteConfigs: [[credentialsId: GITCREDENTIAL, url: GITWEBADD]]])
            }
            post {
                failure {
                    echo 'Repository clone failure'
                }
                success {
                    echo 'Repository clone success'
                }
            }
        }
        stage('code build') {
            steps {
                sh "mvn clean package"
            }
        }
        stage('image build') {
            steps {
                sh "docker build -t DOCKERHUB:${currentBuild.number} ."
            }
        }
    }
}