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
                echo -e "https://alpine.global.ssl.fastly.net/alpine/v3.18/community" > /etc/apk/repositories
                echo -e "https://alpine.global.ssl.fastly.net/alpine/v3.18/main" >> /etc/apk/repositories
                apk update
                apk add --no-cache linux-pam gcompat binutils go postgresql-client git openssh
                go build -o gogs -buildvcs=false
                go test -v -cover ./...
                '''
            }
        }
    }
}
