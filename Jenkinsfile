pipeline {
    agent none // This specifies that no global agent will be used

    stages {
        stage('Build and Test') {
            agent { 
                nomad {
                    // Specify the task group or template defined in the Nomad cloud configuration
                    label 'nomad-alpine'
                }
            }
            steps {
                sh '''
                echo "Running on Nomad agent"
                apk update
                apk add --no-cache linux-pam gcompat binutils go postgresql-client git openssh
                go build -o gogs -buildvcs=false
                go test -v -cover ./...
                '''
            }
        }
    }
}
