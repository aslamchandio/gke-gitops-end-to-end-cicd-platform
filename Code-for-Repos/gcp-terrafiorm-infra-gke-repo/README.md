# GKE Private Cluster + Cloud SQL Infrastructure (Terraform Modules + Shell Automation)

## Overview

This project demonstrates a production-style Google Cloud infrastructure setup using **custom Terraform modules** to deploy a **Private GKE Cluster** and **Private Cloud SQL instance**, with environment-based execution using **shell scripts** for DEV and PROD workflows.

The goal of this project is to showcase secure, modular, reusable, and enterprise-aligned Infrastructure-as-Code practices suitable for real-world DevOps / Platform Engineering environments.

---

## Architecture Highlights

This solution implements:

* Private GKE Cluster (no public node IPs)
* Private Cloud SQL (MySQL) using private IP
* Custom Terraform module structure
* Separate DEV and PROD environments
* Shell script–based deployment automation
* VPC-native Kubernetes networking
* Secure service-to-database communication
* Production-ready infrastructure layout

---

## Technologies Used

* Google Kubernetes Engine (GKE)
* Google Cloud SQL (Private IP)
* Terraform (Modular Architecture)
* Google Cloud VPC
* IAM Service Accounts
* Cloud NAT (optional for private outbound traffic)
* Shell scripting (environment automation)

---

## Project Structure

```
.
├── modules/
│   ├── vpc/
│   ├── gke-private-cluster/
│   └── cloudsql-private-instance/
│
├── environments/
│   ├── dev/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── terraform.tfvars
│   │
│   └── prod/
│       ├── main.tf
│       ├── variables.tf
│       └── terraform.tfvars
│
├── scripts/
│   ├── deploy-dev.sh
│   └── deploy-prod.sh
│
└── README.md
```

This structure enables clean separation between reusable modules and environment-specific configurations.

---

## Key Features

### 1. Private GKE Cluster

* Control plane accessible only via authorized networks
* Nodes deployed without public IPs
* VPC-native networking enabled
* Secure production-grade cluster design

### 2. Private Cloud SQL Instance

* Uses Private Service Access
* No public exposure
* Internal connectivity from GKE workloads
* Secret-based credential management supported

### 3. Modular Terraform Design

Reusable modules include:

* VPC Module
* GKE Private Cluster Module
* Cloud SQL Private Instance Module

Benefits:

* Reusability
* Maintainability
* Environment consistency
* Scalable architecture patterns

### 4. Environment-Based Deployment Automation

Shell scripts simplify deployments:

```
./scripts/deploy-dev.sh
./scripts/deploy-prod.sh
```

Each script:

* Initializes Terraform
* Selects environment configuration
* Applies infrastructure safely
* Ensures repeatable deployments

---

## Security Design Considerations

This project follows secure infrastructure principles:

* Private Kubernetes nodes
* Private Cloud SQL connectivity
* No public database endpoints
* Environment isolation between DEV and PROD
* IAM-based access control ready
* Network segmentation using custom subnets

---

## Deployment Workflow

### Step 1

Clone repository:

```
git clone <repo-url>
cd <repo-name>
```

### Step 2

Authenticate with Google Cloud:

```
gcloud auth application-default login
```

### Step 3

Deploy DEV environment:

```
./scripts/deploy-dev.sh
```

### Step 4

Deploy PROD environment:

```
./scripts/deploy-prod.sh
```

---

## Example Use Cases

This infrastructure supports:

* Microservices platforms
* Internal enterprise workloads
* Secure backend API environments
* Kubernetes-based application platforms
* Production-grade DevOps learning labs

---

## Learning Outcomes

Through this project:

* Designed private Kubernetes architecture
* Implemented Cloud SQL private networking
* Built reusable Terraform modules
* Practiced environment isolation strategies
* Automated infrastructure deployments
* Applied production-style IaC patterns

---

## Future Enhancements (Roadmap)

Planned improvements:

* Workload Identity integration
* Secret Manager DB password automation
* CI/CD pipeline integration (GitHub Actions / Cloud Build)
* Remote Terraform state (GCS backend)
* Policy validation (OPA / Terraform Validator)

---

## Author

**Aslam Chandio**

Cloud & DevOps Engineer focused on building secure, scalable, and production-ready cloud infrastructure using Terraform and Kubernetes.

LinkedIn: https://www.linkedin.com/in/aslam-chandio/
GitHub: https://github.com/aslamchandio

---

If this project helps you, feel free to star the repository.
