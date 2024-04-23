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

        stage('Push Docker Image to Docker Hub') {
            agent {
                label 'nomad-docker'
            }
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
                        sh '''
                        docker build -t petrobubka/my_gogs_image_nomad:latest -f Dockerfile_app .
                        docker push petrobubka/my_gogs_image_nomad:latest
                        '''
                    }
                }
            }
        }
    }
}




