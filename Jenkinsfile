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
    agent any
    stages {
        stage('Clean previous') {
            steps {
                executeSSHCommand("nomad job run /home/vagrant/gogs_job.hcl")
            }
        }
        }
}
