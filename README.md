# 🚀 SDLC DevOps Project: Complete Node.js Pipeline

A complete "Zero to Hero" DevOps project demonstrating a full Software Development Life Cycle (SDLC) pipeline. This project moves a simple Node.js application from local development to a production-ready deployment on AWS using industry-standard tools.

## 📋 Project Overview

This project automates the deployment of a Node.js application using a modern DevOps stack. It covers:
1.  **Development**: Local coding and containerization.
2.  **Orchestration**: Running locally on Kubernetes (Minikube).
3.  **CI (Continuous Integration)**: Jenkins pipeline to build and push Docker images.
4.  **IaC (Infrastructure as Code)**: Terraform to provision AWS EC2 instances.
5.  **CD (Configuration Management)**: Ansible to configure servers and deploy the application.

---

## 🛠️ Technology Stack

* **Application**: Node.js (Express)
* **Version Control**: Git & GitHub
* **Containerization**: Docker & Docker Hub
* **Local Orchestration**: Minikube (Kubernetes)
* **CI Pipeline**: Jenkins (running in Docker)
* **Infrastructure as Code**: Terraform (AWS Provider)
* **Configuration Management**: Ansible
* **Cloud Provider**: AWS (EC2, VPC, Security Groups)
* **Operating System**: Ubuntu (WSL 2 on Windows 11)

---

## 📂 Project Structure

```bash
sdlc-devops-project/
├── app/                  # Application Source Code
│   ├── server.js         # Node.js entry point
│   ├── package.json      # Dependencies
│   └── Dockerfile        # Container definition
├── k8s/                  # Kubernetes Manifests (Local)
│   ├── deployment.yaml
│   └── service.yaml
├── terraform/            # Infrastructure Provisioning
│   ├── main.tf           # AWS Resources (EC2, SG, KeyPair)
│   └── terraform.tfstate # State file (ignore in git)
├── ansible/              # Configuration Management
│   ├── inventory.ini     # Server IPs
│   └── playbook.yaml     # Deployment tasks
├── jenkins-setup/        # Custom Jenkins Docker Image
│   └── Dockerfile
└── Jenkinsfile           # CI Pipeline Script

🚀 Phase 1: Development & Local Orchestration
1. Build & Test Locally
The application is a simple Express server with a health check endpoint.

Bash
cd app
npm install
node server.js
# Access at http://localhost:3000
2. Dockerization
Build the container image locally.

Bash
docker build -t <your-dockerhub-user>/devops-node-app:v1 .
docker run -p 3000:3000 <your-dockerhub-user>/devops-node-app:v1
3. Kubernetes (Minikube)
Deploy to a local Kubernetes cluster to simulate orchestration.

Bash
minikube start
kubectl apply -f k8s/
minikube service node-app-service --url
🔄 Phase 2: Continuous Integration (Jenkins)
Automates the build and push process to Docker Hub.

1. Setup Jenkins
Run Jenkins in a container with the Docker socket mounted ("Docker-out-of-Docker").

Bash
docker run -d \
  -p 8080:8080 \
  -p 50000:50000 \
  --name jenkins \
  -u root \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v jenkins_home:/var/jenkins_home \
  my-jenkins-docker:v1
2. Pipeline Workflow (Jenkinsfile)
Checkout: Pulls code from GitHub.

Build: Creates Docker image with a version tag (:v${BUILD_NUMBER}).

Login: Authenticates with Docker Hub using Jenkins Credentials.

Push: Pushes the tagged image and latest tag to the registry.

Cleanup: Logs out.

☁️ Phase 3: Deployment (Terraform & Ansible)
Provisions AWS infrastructure and deploys the application.

1. Infrastructure Provisioning (Terraform)
Provisions 2 EC2 instances (Ubuntu) and a Security Group allowing SSH (22) and HTTP (80).

Bash
cd terraform
terraform init
terraform plan
terraform apply
Output: Returns public IPs of the new servers.

2. Configuration & Deployment (Ansible)
Configures the raw EC2 instances.

Playbook Tasks:

Updates apt cache.

Installs Docker & Nginx.

Starts Docker service.

Pulls the Node.js image from Docker Hub.

Runs the container on port 3000.

Configures Nginx as a Reverse Proxy (Port 80 -> 3000).

Bash
cd ansible
# Update inventory.ini with Terraform output IPs
ansible-playbook -i inventory.ini playbook.yaml
3. Verification
Access the application via the AWS Public IPs:
http://<EC2-PUBLIC-IP>

🧹 Tear Down
To avoid AWS costs, destroy infrastructure when finished.

Bash
cd terraform
terraform destroy
👤 Author
Martin Stojkovski

GitHub: MartinS984

Created as part of the Complete SDLC DevOps Masterclass.