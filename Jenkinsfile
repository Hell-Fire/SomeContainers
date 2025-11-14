
pipeline {
    environment {
        REPOHOST = credentials('harbor-url')
        LIBRARY = '/library'
        PLATFORMS = 'linux/amd64,linux/arm64/v8,linux/arm/v7'
    }

    agent {
        kubernetes {
            yaml '''
apiVersion: v1
kind: Pod
spec:
  containers:
    - name: buildkitd
      image: moby/buildkit:master-rootless
      args:
        - --oci-worker-no-process-sandbox
        - --addr
        - tcp://0.0.0.0:1234
      readinessProbe:
        exec:
          command:
            - buildctl
            - --addr
            - tcp://127.0.0.1:1234
            - debug
            - workers
        initialDelaySeconds: 5
        periodSeconds: 30
      livenessProbe:
        exec:
          command:
            - buildctl
            - --addr
            - tcp://127.0.0.1:1234
            - debug
            - workers
        initialDelaySeconds: 5
        periodSeconds: 30
      securityContext:
        # Needs Kubernetes >= 1.19
        seccompProfile:
          type: Unconfined
        # To change UID/GID, you need to rebuild the image
        runAsUser: 1000
        runAsGroup: 1000
'''
            defaultContainer 'buildkitd'
            retries 2
        }
    }

    stages {
        stage('Harbor-Creds-Init') {
            steps {
                withCredentials(
                [
                    usernamePassword(
                        credentialsId: 'harbor',
                        passwordVariable: 'REPOPASS',
                        usernameVariable: 'REPOUSER'
                    )
                ]
                ) {
                    sh './.jenkins/docker-creds-from-env.sh'
                }
            }
        }

        stage('Checkout') {
            steps {
                script {
                    checkout scm
                    env.GIT_SHORT_SHA = sh(
                        returnStdout: true,
                        script: 'git rev-parse HEAD'
                    ).trim().substring(0, 7)
                }
            }
        }

        stage('Build') {
            matrix {
                axes {
                    axis {
                        name 'IMAGE'
                        values 'dhcpd', 'icecast', 'keepalived', 'meshcentral', 'movienight', 'nginx-dav', 'novnc', 'ser2net', 'stunnel', 'websockify-go'
                    }
                }

                stages {
                    stage("Build-$IMAGE") {
                        lock('one-at-a-time-plz') {                            steps {
                                sh '''buildctl \
                                        --addr tcp://127.0.0.1:1234 \
                                        build \
                                        --frontend dockerfile.v0 \
                                        --local context=$WORKSPACE/$IMAGE \
                                        --local dockerfile=$WORKSPACE/$IMAGE \
                                        --opt platform=${PLATFORMS} \
                                        --export-cache type=inline \
                                        --import-cache type=registry,\\\"ref=${REPOHOST}${LIBRARY}/${IMAGE}\\\" \
                                        --output type=image,\\\"name=${REPOHOST}${LIBRARY}/${IMAGE}:sha-${GIT_SHORT_SHA},${REPOHOST}${LIBRARY}/${IMAGE}:latest\\\",push=true
            '''
                            }
                        }
                    }
                }
            }
        }
    }
}
