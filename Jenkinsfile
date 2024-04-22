pipeline {
    agent none

    stages {
        stage('Submit Alpine Job to Nomad') {
            steps {
                script {
                    sh 'nomad job run alpine_job.hcl'
                }
            }
        }

        stage('Submit Kaniko Job to Nomad') {
            steps {
                script {
                    sh 'nomad job run kaniko_job.hcl'
                }
            }
        }

        stage('Check Job Status') {
            steps {
                script {
                    // Polling or a webhook might be used here to determine when the job has completed
                    sh 'nomad job status gogs-build'
                    sh 'nomad job status kaniko-build'
                }
            }
        }
    }
}
