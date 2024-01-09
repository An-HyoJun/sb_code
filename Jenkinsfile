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
    }

    stages {
        stage('Build') {
            steps {
                echo 'Building..'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}