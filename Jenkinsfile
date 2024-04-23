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
        // Modified stage to execute SSH command on the Built-In Node
        stage('Execute SSH Command') {
            agent { 
                label 'master' // Running this stage on the Jenkins master node
            }
            steps {
                script {
                    executeSSHCommand("nomad job run /home/vagrant/gogs_job.hcl")
                }
            }
        }
    }
}
