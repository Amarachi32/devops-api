# Infinion Weather Forecast API - DevOps Assessment

## Language - ASP.NET Core

# Instructions

```
1. Use terraform module to create ACR in the resource group
2. Setup a pipeline (GitHub Actions or Azure DevOps) to build and push the API to the created ACR
3. Setup AKS via Azure portal, Azure CLI, Terraform or however you deem fit
4. Deploy the API to your AKS cluster
5. There'll be bonus points for security best practice approaches
6. Document your deployment for presentation and cleanup your infrastructure when done
```

### This app's endpoint can be reached via /weatherforecast or on your local at http://localhost:5167/weatherforecast

>
Example: https://<your-url>/weatherforecast


## P.S Feel free to reach out to us if you need any assistance while carrying out your tasks












# ☁️ Azure Cloud Deployment: Containerized Weather API
## 📑 Overview
This project demonstrates how to deploy the **Infinion Weather API** to **Azure Kubernetes Service (AKS)** using **Terraform** for infrastructure provisioning and **GitHub Actions** for CI/CD.  
The workflow builds a Docker image of the API, pushes it to **Azure Container Registry (ACR)**, and deploys it to AKS.

The project demonstrates proficiency in cloud architecture, IaC, containerization, and secure pipeline automation.

---

## 🏗️ Architecture

- **Terraform** provisions ACR and AKS.
- **GitHub Actions** builds and pushes Docker images.
- **AKS** hosts the Weather API.
- **Kubernetes manifests** define deployment and service.

---

### 🎯 Project Goals

Provision all necessary Azure infrastructure (Resource Group, ACR, AKS) using Terraform.

Containerize the ASP.NET Core application using Docker.

Implement a secure, automated CI/CD pipeline that builds the image and pushes it to ACR (CI).

Deploy the latest container image to AKS and expose it publicly (CD).

Establish a secure connection between AKS and ACR using Azure Managed Identity.



## 🏗️ 1. Infrastructure as Code (IaC) with Terraform

All cloud resources are defined in the `infra/` directory using Terraform modules, ensuring the entire environment is version-controlled and reproducible.

### 1.1 Resource Provisioning

The Terraform configuration provisions the following key components:

---

### **Azure Container Registry (ACR)**
- **Purpose:** Private storage for Docker images  
- **Module:** `./modules/acr`  
- **SKU:** **Basic** (cost-effective for development)

---

### **Azure Kubernetes Service (AKS)**
- **Purpose:** Managed Kubernetes cluster hosting the API  
- **Module:** `./modules/aks`  
- **SKU:** **Free tier** control plane (cost optimization)  
- **Node Pool:** 1 node (e.g., `Standard_B2s`) suitable for development/testing  


### Apply Steps
```
terraform init
terraform plan -var-file="terraform.tfvars"
terraform apply

```

### 1.2 🔒 Secure ACR–AKS Integration

A critical security practice implemented by Terraform is the connection between AKS and ACR:

- **AKS Identity:**  
  The AKS cluster is created with a **System-Assigned Managed Identity**.

- **Role Assignment:**  
  Terraform uses the **`azurerm_role_assignment`** resource to grant this AKS identity the **`AcrPull`** role, scoped specifically to the ACR instance.

- **Result:**  
  The AKS cluster can securely pull images from the private ACR **without using hardcoded usernames or passwords**.

### 🔐 Secrets Required

- **ACR_LOGIN_SERVER**
- **ACR_USERNAME**
- **ACR_PASSWORD**
- **AZURE_CREDENTIALS** (Service Principal)
- **AKS_CLUSTER_NAME**


## 📦 2. Application Containerization (Docker)

The application is containerized for portability across environments.

- **Dockerfile:** Uses a multi-stage build approach.
  - The first stage compiles the application using a full SDK image.
  - The final stage uses a minimal runtime image (`mcr.microsoft.com/dotnet/aspnet:8.0`) to produce a small, secure, and production-ready image.

- **Container Port:**  
  The application is configured to run on **port 8080**.



## 🚀    3. CI/CD Pipeline with GitHub Actions

The entire build, push, and deployment process is automated by the `.github/workflows/ci.yml` file, triggered automatically upon push to the **master** branch.

### 3.1. Workflow Summary

The pipeline runs as a single job with the following steps:

- **Checkout:** Retrieves the code from the repository.
- **ACR Login (CI):** Logs into the Azure Container Registry using GitHub Secrets (`ACR_USERNAME`, `ACR_PASSWORD`).
- **Build and Push (CI):** Builds the Docker image and pushes it to ACR, tagged with the unique GitHub commit SHA (`${{ github.sha }}`).
- **Azure Login (CD):** Authenticates the workflow to Azure using a Service Principal JSON secret (`AZURE_CREDENTIALS`).
- **Set AKS Context (CD):** Connects `kubectl` to the AKS cluster using:
  - `secrets.AKS_CLUSTER_NAME`
  - `vars.RESOURCE_GROUP_NAME`
- **Deploy to AKS (CD):** Applies the Kubernetes manifests and updates the Deployment to use the new image tag.



## ☁️ 4. Kubernetes Deployment

The application deployment is managed using standard Kubernetes YAML manifests located in the `k8s/` directory.

### 4.1. `deployment.yaml`

- Defines the API Deployment with **2 replicas** for high availability.
- Specifies resource requests and limits  
  - **CPU:** 100m  
  - **Memory:** 128Mi  
  for cost efficiency and resource governance.
- Includes **Liveness** and **Readiness** probes to ensure Kubernetes routes traffic only to healthy, ready pods.

### 4.2. `service.yaml`

- Creates a Kubernetes **Service** of type **LoadBalancer**.
- Automatically provisions an **Azure Public Load Balancer** with an external IP address.
- Maps **external port 80** to the container's **internal port 8080**.


# 🗑️ 5. Operational Instructions (Cleanup)

To manage costs, all provisioned infrastructure should be destroyed when no longer needed.  
Since all resources were managed via Terraform, cleanup is a single command.

## 5.1. Destroy Infrastructure

From the root infra directory, execute the following command:

```bash
terraform destroy -var-file="terraform.tfvars"


Confirmation: Review the destruction plan and type **yes** when prompted to confirm the deletion of all managed resources (AKS, ACR, Role Assignments, etc.).
```
