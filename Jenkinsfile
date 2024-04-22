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
                apk add --no-cache go git
                go build -o myapp
                go test -v ./...
                '''
            }
        }

        stage('Deploy') {
            agent { 
                nomad {
                    label 'nomad-kaniko'
                }
            }
            steps {
                sh '''
                /kaniko/executor --dockerfile Dockerfile --context `pwd` \
                                 --destination myrepo/myapp:latest
                '''
            }
        }
    }
}
