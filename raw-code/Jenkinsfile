pipeline {
    agent any
    tools {
        maven "maven"
    }
    environment {
              APP_NAME = "loginregisterapp"
              DOCKER_USER = "vedantdevops"
              MAJOR_VERSION = "1.0"
              IMAGE_TAG = "${MAJOR_VERSION}.${BUILD_NUMBER}"
              NEW_BUILD_DOCKER_IMAGE = "${DOCKER_USER}" + "/" + "${APP_NAME}:${IMAGE_TAG}" 
    }
    stages {
        stage('Clean') {
            steps {
                cleanWs()
            }
        }
        stage('Code Commit') {
            steps {
                git 'https://github.com/vedantguptha/CI-CD-Project7.git'
            }
        }
        stage('Unit Test maven') {
            steps {
                sh 'mvn test'
            }
        }       
        stage('Integration Test maven') {
            steps {
                sh 'mvn verify -DskipUnitTests'
            }
        }
        stage ('Package') {
            steps {
                sh 'mvn package'
            }  
        }
        stage ('Artifactory') {
            steps {
                sh " aws s3 cp $WORKSPACE/target/*.war s3://b90-artifactory/${APP_NAME}-${IMAGE_TAG}.war "
            }  
        }
        stage ('Build Docker Iamge') {
            steps {
                sh ''' cd $WORKSPACE ''' 
                sh " docker build -t ${NEW_BUILD_DOCKER_IMAGE} . "
            }  
        }
        stage ('Registery Login') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]) {
                    sh ' docker login -u $USERNAME -p $PASSWORD '
                }
            }  
        }
        stage ('Push Docker Image') {
            steps {
                sh " docker push ${NEW_BUILD_DOCKER_IMAGE} "
            }  
        }
        stage ('Git Checkout') {
            steps {
                 script {
                    echo "Assume the Deploy feature/alpha is Success"
                  
                    timeout(time: 5, unit: 'MINUTES') {
                        env.userChoice = input message: "Do you want to Deploy ${NEW_BUILD_DOCKER_IMAGE} of Application ? ",
                            parameters: [choice(name: 'New Deploymnet Conformation', choices: 'no\nyes', description: 'Choose "yes" if you want to deploy this build')]
                    }
                    if (userChoice == 'yes') {
                
                        build job: 'merge', parameters: 
                        [  string(name: 'release_version_tag_id', value: "${IMAGE_TAG}"),  string(name: 'docker_image_name', value: "${APP_NAME}") ]
                    }
                    else if(userChoice == 'no') {
                        echo "Process abort by: ${user}"
                    }
                        
                }
            }  
        }
    }
}
