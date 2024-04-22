pipeline {
    agent none // This specifies that no global agent will be used

    stages {
        stage('Build and Test') {
            agent { 
                    label 'nomad-alpine'
            }
            steps {
                sh '''
                echo "Running on Nomad agent"
                apk update
                apk add --no-cache linux-pam gcompat binutils go postgresql-client git openssh
                go build -o gogs
                go test -v -cover ./...
                '''
            }
        }
    }
}
