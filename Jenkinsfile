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
                sh "docker build -t ${DOCKERHUB}:${currentBuild.number} ."
                sh "docker build -t ${DOCKERHUB}:latest ."
            }
        }
        stage('image push') {
            steps {
                withDockerRegistry(credentialsId: DOCKERHUBCREDENTIAL, url: '') {
                    sh "docker push ${DOCKERHUB}:${currentBuild.number}"
                    sh "docker push ${DOCKERHUB}:latest"
                }
            }
            post {
                failure {
                    echo 'docker image push failure'
                    sh "docker image rm -f ${DOCKERHUB}:${currentBuild.number}"
                    sh "docker image rm -f ${DOCKERHUB}:latest"
                }
                success {
                    echo 'docker image push success'
                    sh "docker image rm -f ${DOCKERHUB}:${currentBuild.number}"
                    sh "docker image rm -f ${DOCKERHUB}:latest"
                }
            }
        }
        stage('k8s manifest file update') {
            steps {
                git credentialsId: GITCREDENTIAL,
                url: GITSSHADD,
                branch: 'main'
                
                sh "git config --global user.email ${GITMAIL}"
                sh "git config --global user.name ${GITNAME}"
                sh "sed -i 's@${DOCKERHUB}:.*@${DOCKERHUB}:${currentBuild.number}@g' deployment.yml"
                
                sh "git add ."
                sh "git commit -m 'fix:${DOCKERHUB} ${currentBuild.number} image versioning'"
                sh "git branch -M main"
                sh "git remote remove origin"
                sh "git remote add origin ${GITSSHADD}"
                sh "git push -u origin main"
                
            }
            post {
                failure {
                    echo 'k8s manifest file update failure'
                }
                success {
                    echo 'k8s manifest file update success'  
                }
            }
        }
    }
}