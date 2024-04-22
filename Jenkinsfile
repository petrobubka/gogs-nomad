pipeline {
    agent none // This specifies that no global agent will be used

    stages {
        stage('Build Docker Image') {
            agent {
                label 'nomad-docker'
            }
            steps {
                sh '''
                docker build -t petrobubka/my_gogs_image_nomad:latest -f Dockerfile_app .
                '''
            }
        }
    }
}
