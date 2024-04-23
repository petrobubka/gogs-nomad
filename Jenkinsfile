def executeSSHCommand(String command) {
    sshPublisher(
        publishers: [
            sshPublisherDesc(
                configName: "nomad", 
                verbose: true,
                transfers: [
                    sshTransfer(
                        execCommand: command
                    )
                ]
            )
        ]
    )
}
pipeline {
    agent none // This specifies that no global agent will be used

    stages {
        stage('Build and Test') {
            agent { 
                label 'nomad-alpine'
            }
            steps {
                sh '''
                echo -e "https://alpine.global.ssl.fastly.net/alpine/v3.18/community" > /etc/apk/repositories
                echo -e "https://alpine.global.ssl.fastly.net/alpine/v3.18/main" >> /etc/apk/repositories
                apk update
                apk add --no-cache linux-pam gcompat binutils go postgresql-client git openssh
                go build -o gogs -buildvcs=false
                go test -v -cover ./...
                '''
            }
        }

        stage('Push Docker Image to Docker Hub') {
            agent {
                label 'nomad-docker'
            }
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]) {
                    sh '''
                    echo $PASSWORD | docker login --username $USERNAME --password-stdin
                    docker build -t petrobubka/my_gogs_image_nomad:latest -f Dockerfile_app .
                    docker push petrobubka/my_gogs_image_nomad:latest
                    '''
                }
            }
        }

        stage('Execute SSH Command') {
            agent { 
              node {
               label 'master'
        }               
            }
            steps {
                script {
                    executeSSHCommand("nomad job run /home/vagrant/gogs_job.hcl")
                }
            }
        }
    }
}
