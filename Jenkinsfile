pipeline {
    agent any

    environment {
        AWS_REGION = 'us-east-1'
        AWS_ACCOUNT_ID = '539935451710'
        ECR_REPO_PATIENT = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/patient-service"
        ECR_REPO_APPOINTMENT = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/appointment-service"
        ECS_CLUSTER = 'fargate-cluster'
        ECS_SERVICE_PATIENT = 'patient-service-task-service'
        ECS_SERVICE_APPOINTMENT = 'appointment-service-task-service'
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/Elishadevakonda/Fargate_deployment_track_elisha.git'
            }
        }

        stage('Terraform Lint') {
            steps {
                sh 'terraform fmt -check'
            }
        }

        stage('Terraform Init & Plan') {
            steps {
                sh '''
                terraform init
                terraform plan -out=tfplan
                '''
            }
        }

        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -auto-approve tfplan'
            }
        }

        stage('Login to AWS ECR') {
            steps {
                sh '''
                aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com
                '''
            }
        }

        stage('Build & Push Docker Images') {
            parallel {
                stage('Patient Service') {
                    steps {
                        sh '''
                        docker build -t patient-service -f Dockerfile.patient .
                        docker tag patient-service $ECR_REPO_PATIENT:latest
                        docker push $ECR_REPO_PATIENT:latest
                        '''
                    }
                }
                stage('Appointment Service') {
                    steps {
                        sh '''
                        docker build -t appointment-service -f Dockerfile.appointment .
                        docker tag appointment-service $ECR_REPO_APPOINTMENT:latest
                        docker push $ECR_REPO_APPOINTMENT:latest
                        '''
                    }
                }
            }
        }

        stage('Deploy to ECS') {
            parallel {
                stage('Deploy Patient Service') {
                    steps {
                        sh '''
                        aws ecs update-service --cluster $ECS_CLUSTER --service $ECS_SERVICE_PATIENT --force-new-deployment
                        '''
                    }
                }
                stage('Deploy Appointment Service') {
                    steps {
                        sh '''
                        aws ecs update-service --cluster $ECS_CLUSTER --service $ECS_SERVICE_APPOINTMENT --force-new-deployment
                        '''
                    }
                }
            }
        }
    }

    post {
        always {
            sh 'terraform destroy -auto-approve'
        }
    }
}
