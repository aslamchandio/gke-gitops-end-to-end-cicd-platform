# 🚀 End-to-End Kubernetes CI/CD Pipeline on GKE
Terraform + GitHub Actions + OIDC + Artifact Registry + ArgoCD + Kustomize (Dev / Prod)

This repository demonstrates a production-grade Kubernetes CI/CD platform built on Google Kubernetes Engine (GKE) using GitOps best practices.

The pipeline automatically:

✅ Builds container images
✅ Pushes images to Artifact Registry
✅ Deploys to GKE using ArgoCD
✅ Supports Dev & Prod environments
✅ Uses secure GitHub → GCP authentication via OIDC
✅ Manages infrastructure using Terraform
✅ Uses Kustomize overlays for environment separation

# 🚀 End-to-End Kubernetes CI/CD Pipeline on GKE

> **Terraform · ArgoCD · OIDC · GitHub Actions · Artifact Registry · Kustomize (dev/prod)**

[![Terraform](https://img.shields.io/badge/Terraform-1.7+-7B42BC?logo=terraform)](https://terraform.io)
[![GKE](https://img.shields.io/badge/GKE-Google_Kubernetes_Engine-4285F4?logo=google-cloud)](https://cloud.google.com/kubernetes-engine)
[![ArgoCD](https://img.shields.io/badge/ArgoCD-GitOps-EF7B4D?logo=argo)](https://argoproj.github.io/cd)
[![GitHub Actions](https://img.shields.io/badge/GitHub_Actions-CI%2FCD-2088FF?logo=github-actions)](https://github.com/features/actions)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

---

## 📋 Table of Contents

- [Overview](#-overview)
- [Architecture](#-architecture)
- [Tech Stack](#-tech-stack)
- [Project Structure](#-project-structure)
- [Prerequisites](#-prerequisites)
- [Infrastructure Setup (Terraform)](#-infrastructure-setup-terraform)
- [OIDC Authentication Setup](#-oidc-authentication-setup)
- [Artifact Registry Configuration](#-artifact-registry-configuration)
- [ArgoCD Setup](#-argocd-setup)
- [Kustomize Environments](#-kustomize-environments-devprod)
- [GitHub Actions Workflows](#-github-actions-workflows)
- [Deployment Flow](#-deployment-flow)
- [Environment Variables & Secrets](#-environment-variables--secrets)
- [Monitoring & Observability](#-monitoring--observability)
- [Troubleshooting](#-troubleshooting)
- [Contributing](#-contributing)

---

## 🌐 Overview

This repository implements a **production-grade, fully automated CI/CD pipeline** for deploying containerized applications to **Google Kubernetes Engine (GKE)**. The pipeline is designed with security, scalability, and GitOps principles at its core.

**Key highlights:**

- 🔒 **Keyless authentication** via Workload Identity Federation (OIDC) — no long-lived service account keys
- 🏗️ **Infrastructure as Code** using Terraform for fully reproducible GKE clusters
- 🔄 **GitOps delivery** with ArgoCD — Git is the single source of truth for cluster state
- 🎯 **Environment isolation** using Kustomize overlays for `dev` and `prod`
- 📦 **Private image registry** via Google Artifact Registry
- ⚡ **Automated workflows** — push to branch triggers full build, push, and deploy cycle

---

## 🏛️ Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                        DEVELOPER WORKFLOW                        │
│                                                                  │
│   git push ──► GitHub ──► GitHub Actions (CI)                   │
│                                │                                 │
│                    ┌───────────▼────────────┐                   │
│                    │   OIDC Token Exchange   │                   │
│                    │  (No static keys! 🔒)  │                   │
│                    └───────────┬────────────┘                   │
│                                │                                 │
│              ┌─────────────────▼──────────────────┐            │
│              │         Google Cloud                │            │
│              │                                     │            │
│              │  ┌─────────────────────────────┐   │            │
│              │  │    Artifact Registry         │   │            │
│              │  │  (Docker Image Storage)      │   │            │
│              │  └──────────────┬──────────────┘   │            │
│              │                 │                   │            │
│              │  ┌──────────────▼──────────────┐   │            │
│              │  │    GKE Cluster (Terraform)   │   │            │
│              │  │                             │   │            │
│              │  │  ┌──────────┐ ┌──────────┐ │   │            │
│              │  │  │  dev ns  │ │ prod ns  │ │   │            │
│              │  │  └──────────┘ └──────────┘ │   │            │
│              │  │         ▲            ▲      │   │            │
│              │  │         └────────────┘      │   │            │
│              │  │              │              │   │            │
│              │  │    ┌─────────▼──────────┐  │   │            │
│              │  │    │      ArgoCD        │  │   │            │
│              │  │    │  (GitOps Operator) │  │   │            │
│              │  │    └────────────────────┘  │   │            │
│              │  └─────────────────────────────┘   │            │
│              └─────────────────────────────────────┘            │
│                                │                                 │
│              GitHub Repo (Kustomize manifests) ◄────────────────┘
│                    (ArgoCD watches this repo)                    │
└─────────────────────────────────────────────────────────────────┘
```

**CI Flow (GitHub Actions):**
1. Developer pushes code → GitHub Actions triggers
2. OIDC token exchanged for short-lived GCP credentials
3. Docker image built and pushed to Artifact Registry
4. Kustomize manifest updated with new image tag
5. ArgoCD detects manifest change and syncs cluster state

---

## 🛠️ Tech Stack

| Component | Tool | Purpose |
|-----------|------|---------|
| **Infrastructure** | Terraform 1.7+ | GKE cluster, VPC, IAM, Artifact Registry |
| **Container Orchestration** | GKE (Google Kubernetes Engine) | Managed Kubernetes runtime |
| **CI/CD Pipeline** | GitHub Actions | Build, test, push, update manifests |
| **Auth (Keyless)** | OIDC + Workload Identity Federation | Secure, short-lived GCP credentials |
| **GitOps Operator** | ArgoCD | Automated cluster sync from Git |
| **Image Registry** | Google Artifact Registry | Private Docker image storage |
| **Config Management** | Kustomize | Environment-specific overlays (dev/prod) |
| **Secrets Management** | GCP Secret Manager | Secure secret storage |

---

## 📁 Project Structure

```
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

.
├── .github/
│   └── workflows/
│       ├── cicd-deploy.yml            # CI pipeline for dev branch

│
├── argocd/
│   ├── application-dev.yaml      # ArgoCD Application for dev
│   ├── application-prod.yaml     # ArgoCD Application for prod
│   └── project.yaml              # ArgoCD AppProject definition
│
├── scripts/
│   ├── bootstrap.sh              # One-time GCP project setup
│   └── update-image-tag.sh       # Image tag update helper
│
└── README.md
```

---

## ✅ Prerequisites

Before you begin, ensure you have the following installed and configured:

```bash
# Required tools
gcloud --version      # Google Cloud SDK >= 450.0.0
terraform --version   # >= 1.7.0
kubectl version       # >= 1.28
kustomize version     # >= 5.0.0
argocd version        # ArgoCD CLI >= 2.9
helm version          # >= 3.12 (for ArgoCD installation)
```

**GCP Requirements:**
- A GCP Project with billing enabled
- Project Owner or the following roles: `roles/container.admin`, `roles/iam.workloadIdentityPoolAdmin`, `roles/artifactregistry.admin`

**GitHub Requirements:**
- Repository with Actions enabled
- Branch protection rules configured for `main`

---

## 🏗️ Infrastructure Setup (Terraform)

### 1. Initialize and Configure

```bash
cd terraform/

# Copy and edit the variable file
cp terraform.tfvars.example terraform.tfvars
```

Edit `terraform.tfvars`:

```hcl
# terraform/terraform.tfvars

gcp_project_id = "abcd1234"

gcp_region_1 = "us-central1"
gcp_region_2 = "me-central1"


environment      = "prod"
business_divsion = "it"

project_services = [
  "cloudresourcemanager.googleapis.com",
  "cloudbilling.googleapis.com",
  "serviceusage.googleapis.com",
  "compute.googleapis.com",
  "oslogin.googleapis.com",
  "container.googleapis.com",
  "containerregistry.googleapis.com",
  "iam.googleapis.com",
  "monitoring.googleapis.com",
  "networkconnectivity.googleapis.com",
  "networksecurity.googleapis.com",
  "networkservices.googleapis.com",
  "dns.googleapis.com",
  "certificatemanager.googleapis.com",
  "sql-component.googleapis.com",
  "sqladmin.googleapis.com",
  "servicenetworking.googleapis.com",
  "iap.googleapis.com",
  "storage-api.googleapis.com",
  "secretmanager.googleapis.com"
]

# VPC Configuration
subnet_cidrs = ["192.168.16.0/20", "172.30.10.0/24", "172.30.11.0/24", "192.168.1.0/24"]

pod_cidrs = ["10.244.0.0/16", "10.245.0.0/16"]

service_cidr = "10.34.0.0/16"

source_ip_ranges = "39.100.11.78/32"

# GitHub OIDC
vm_machine_type_map = {
  "test" = "e2-micro"
  "dev"  = "e2-small"
  "prod" = "e2-medium"
}
vm_disk_size = 20
vm_disk_type = "pd-standard"

# GitHub OIDC
github_org        = "your-github-org"
github_repo       = "your-repo-name"

# Artifact Registry
registry_location = "us-central1"
registry_id       = "my-app-registry"
```

### 2. Deploy Infrastructure

```bash
# Authenticate with GCP
gcloud auth application-default login

# Deploy DEV environment:
./scripts/deploy-dev.sh

# Deploy Prod environment:
./scripts/deploy-prod.sh
```

### 3. Configure kubectl

```bash
gcloud container clusters get-credentials $(terraform output -raw cluster_name) \
  --region $(terraform output -raw region) \
  --project $(terraform output -raw project_id)
```

---

## 🔐 OIDC Authentication Setup

###   OIDC Authentication Setup using Terraform

This pipeline uses **Workload Identity Federation** — a keyless, more secure alternative to long-lived service account JSON keys. GitHub Actions exchanges a short-lived OIDC token for temporary GCP credentials.

> 💡 **Word of the Day — *Ephemeral* (adj.):** Lasting for a very short time.
> OIDC tokens are *ephemeral* — they expire after each workflow run, drastically reducing the attack surface compared to static credentials.

The Terraform `iam` module provisions everything automatically, but here's what it creates:

```hcl
# terraform/modules/iam/main.tf (excerpt)

resource "google_iam_workload_identity_pool" "github" {
  workload_identity_pool_id = "github-actions-pool"
  display_name              = "GitHub Actions Pool"
}

resource "google_iam_workload_identity_pool_provider" "github" {
  workload_identity_pool_id          = google_iam_workload_identity_pool.github.workload_identity_pool_id
  workload_identity_pool_provider_id = "github-provider"

  attribute_mapping = {
    "google.subject"       = "assertion.sub"
    "attribute.actor"      = "assertion.actor"
    "attribute.repository" = "assertion.repository"
  }

  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }
}

resource "google_service_account_iam_binding" "github_actions" {
  service_account_id = google_service_account.github_actions.name
  role               = "roles/iam.workloadIdentityUser"

  members = [
    "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.github.name}/attribute.repository/${var.github_org}/${var.github_repo}"
  ]
}
```

After `terraform apply`, retrieve the OIDC values for your GitHub secrets:

```bash
terraform output workload_identity_provider
terraform output service_account_email
```

---

### OIDC Authentication Setup using Gcloud

```bash
# Configure Docker to authenticate with Artifact Registry
gcloud iam service-accounts create wid-cicd-sa --project dev-project-487558 --display-name "Workload-Identity GKE"

gcloud iam workload-identity-pools create github-actions-cicd-gcp-pool \
    --project="dev-project-123456" \
    --location="global" \
    --display-name="GitHub Action CICD GCP Pool" \
    --description="An Identity Pool for Github Action For GCP"


gcloud iam workload-identity-pools describe github-actions-cicd-gcp-pool \
    --project="dev-project-123456" \
    --location="global" \
    --format="value(name)"

    projects/123456789/locations/global/workloadIdentityPools/github-actions-cicd-gcp-pool

gcloud beta iam workload-identity-pools providers create-oidc my-github-actions-cicd-gcp-oidc \
    --project="dev-project-123456" \
    --location="global" \
    --workload-identity-pool="github-actions-cicd-gcp-pool" \
    --display-name="My GitHub Action CICD GCP OIDC" \
    --attribute-mapping="google.subject=assertion.sub,attribute.actor=assertion.actor,attribute.repository=assertion.repository, attribute.aud=assertion.aud,attribute.repository_owner=assertion.repository_owner" \
    --attribute-condition="assertion.repository_owner == 'github-acc-name'" \
    --issuer-uri="https://token.actions.githubusercontent.com"  

   --attribute-mapping="google.subject=assertion.sub,
                      attribute.actor=assertion.actor,
                      attribute.aud=assertion.aud,
                      attribute.repository=assertion.repository,
                      attribute.repository_owner=assertion.repository_owner"

                      
  --attribute-condition="assertion.repository_owner == 'github-acc-name'"   

gcloud iam workload-identity-pools providers list --workload-identity-pool="github-actions-cicd-gcp-pool" --location="global" --show-deleted
gcloud iam workload-identity-pools providers list --workload-identity-pool="github-actions-cicd-gcp-pool" --location="global" 

gcloud iam service-accounts create cicd-oidc-gcp-sa \
    --project="dev-project-123456" \
    --description="Service Account For OIDC Github Actions for GCP" \
    --display-name="SA for OIDC GitHub Actions"

gcloud projects get-iam-policy dev-project-487558   \
--flatten="bindings[].members" \
--format='table(bindings.role)' \
--filter="bindings.members:cicd-oidc-gcp-sa@dev-project-123456.iam.gserviceaccount.com"


gcloud projects add-iam-policy-binding dev-project-487558 \
  --member="serviceAccount:cicd-oidc-gcp-sa@dev-project-123456.iam.gserviceaccount.com" \
   --role="roles/owner" \
  --condition None


gcloud projects add-iam-policy-binding dev-project-487558 \
  --member="serviceAccount:cicd-oidc-gcp-sa@dev-project-123456.iam.gserviceaccount.com" \
  --role="roles/resourcemanager.projectIamAdmin" \
  --condition None


gcloud projects add-iam-policy-binding dev-project-487558 \
  --member="serviceAccount:cicd-oidc-gcp-sa@dev-project-123456.iam.gserviceaccount.com" \
  --role="roles/iam.roleAdmin" \
  --condition None

gcloud projects add-iam-policy-binding dev-project-487558 \
  --member="serviceAccount:cicd-oidc-gcp-sa@dev-project-123456.iam.gserviceaccount.com" \
  --role="roles/iam.serviceAccountAdmin" \
  --condition None

gcloud projects add-iam-policy-binding dev-project-487558 \
  --member="serviceAccount:cicd-oidc-gcp-sa@dev-project-123456.iam.gserviceaccount.com" \
  --role="roles/iam.serviceAccountTokenCreator" \
  --condition None

gcloud projects add-iam-policy-binding dev-project-487558 \
  --member="serviceAccount:cicd-oidc-gcp-sa@dev-project-123456.iam.gserviceaccount.com" \
  --role="roles/iam.serviceAccountUser" \
  --condition None


export PROJECT_ID="dev-project-123456"
export REPO="aslamchandio/gcp-oidc-gitops-code-repo"
export WORKLOAD_IDENTITY_POOL_ID="projects/123456789/locations/global/workloadIdentityPools/github-actions-cicd-gcp-pool"

gcloud iam service-accounts add-iam-policy-binding "cicd-oidc-gcp-sa@${PROJECT_ID}.iam.gserviceaccount.com" \
  --member="principalSet://iam.googleapis.com/${WORKLOAD_IDENTITY_POOL_ID}/attribute.repository/${REPO}" \
  --project="${PROJECT_ID}" \
  --role="roles/iam.workloadIdentityUser" 


gcloud iam workload-identity-pools providers describe my-github-actions-cicd-gcp-oidc \
  --project="${PROJECT_ID}" \
  --location="global" \
  --workload-identity-pool="github-actions-cicd-gcp-pool" \
  --format="value(name)"

WORKLOAD_IDENTITY_PROVIDER   projects/123456789/locations/global/workloadIdentityPools/github-actions-cicd-gcp-pool/providers/my-github-actions-cicd-gcp-oidc

SERVICE_ACCOUNT   cicd-oidc-gcp-sa@dev-project-123456.iam.gserviceaccount.com
```

---

## 📦 Artifact Registry Configuration

```bash
# Configure Docker to authenticate with Artifact Registry
gcloud auth configure-docker $(terraform output -raw registry_location)-docker.pkg.dev

# Verify the registry
gcloud artifacts repositories list --location=$(terraform output -raw registry_location)
```

Image naming convention used in this pipeline:

```
{REGION}-docker.pkg.dev/{PROJECT_ID}/{REGISTRY_ID}/{APP_NAME}:{GIT_SHA}
```

Example:
```
us-central1-docker.pkg.dev/my-project/my-app-registry/backend:a3f8c21
```

Create artifact repo using gcloud:
```
gcloud artifacts repositories create chandio-artifact-repo \
    --repository-format docker \
    --location us-central1 \
    --description  "Artifact Repo for Docker" \
    --immutable-tags \
    --async

gcloud artifacts repositories describe REPOSITORY \
    --location=LOCATION    
```

---

## 🔄 ArgoCD Setup

### Install ArgoCD on the Cluster

```bash
kubectl create namespace argocd

helm repo add argo https://argoproj.github.io/argo-helm
helm repo update


helm install argocd argo/argo-cd --namespace argocd

helm install argocd argo/argo-cd --version 9.4.10 --namespace argocd #Install by version

```

```bash

helm ls -n argocd

kubectl get all -n argocd
kubectl get pods -n argocd
kubectl get service -n  argocd
```

### Apply ArgoCD Application Manifests

```bash
# Create the ArgoCD project
kubectl apply -f argocd/project.yaml

# Register dev and prod applications
kubectl apply -f argocd/applications/kustomize-application-dev.yaml
kubectl apply -f argocd/applications/kustomize-application-prod.yaml
```

### `argocd/applications/kustomize-application-dev.yaml` 

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: grade-submission-dev
  namespace: argocd
spec:
  project: default

  source:
    repoURL: https://github.com/aslamchandio/gcp-oidc-gitops-app-repo.git
    targetRevision: HEAD
    path: kustomize/overlays/dev

  destination:
    server: https://kubernetes.default.svc
    namespace: dev-ns

  syncPolicy:
    automated:
      prune: true
      selfHeal: true
    syncOptions:
    - CreateNamespace=true
```

### ``argocd/applications/kustomize-application-prod.yaml``

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: grade-submission-prod
  namespace: argocd
spec:
  project: default

  source:
    repoURL: https://github.com/aslamchandio/gcp-oidc-gitops-app-repo.git
    targetRevision: HEAD
    path: kustomize/overlays/prod

  destination:
    server: https://kubernetes.default.svc
    namespace: argocd-prod

  syncPolicy:
    automated:
      prune: true
      selfHeal: true
    syncOptions:
    - CreateNamespace=true
```

### Access the ArgoCD UI

```bash
# Get the initial admin password
kubectl -n argocd get secret argocd-initial-admin-secret \
  -o jsonpath="{.data.password}" | base64 -d

# Port-forward the UI
kubectl port-forward svc/argocd-server -n argocd 8080:443

# Open https://localhost:8080

# Patch with loadbalancer 
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'

# Open https://192.168.111.225
# Open https://argocd.techscloud.online
```

---

## 🎛️ Kustomize Environments

Kustomize uses a **base + overlay** pattern. The base holds all shared manifests; overlays layer environment-specific differences on top.

### Base (`k8s/base/kustomization.yaml`)

```yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
- myapp1-deployment.yaml
- myapp1-clusterip-service.yaml
- myapp1-gateway.yaml
- myapp1-http-route.yaml
```

### Dev Overlay (`k8s/overlays/dev/kustomization.yaml`)

```yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
- ../../base

patches:
- path: replicas.yaml
  target:
    kind: Deployment
    name: myapp1-deployment
- path: limits.yaml
  target:
    kind: Deployment
    name: myapp1-deployment
```

**`k8s/overlays/dev/replica-patch.yaml`:**
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: myapp1-deployment
  namespace: dev-ns
  labels:
    app: myapp1-pod
spec:
  replicas: 3
```
**`k8s/overlays/dev/limits-patch.yaml`:**
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: myapp1-deployment
  namespace: dev-ns
  labels:
    app: myapp1-pod
spec:
  template:
    spec:
      containers:
      - name: myapp1-container
        resources:
          requests:
            memory: "40Mi"
            cpu: "40m"
          limits:
            memory: "50Mi"
            cpu: "50m"
```

### Prod Overlay (`k8s/overlays/prod/kustomization.yaml`)

```yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
- ../../base

patches:
- path: replicas.yaml
  target:
    kind: Deployment
    name: myapp1-deployment
- path: limits.yaml
  target:
    kind: Deployment
    name: myapp1-deployment
```

**`k8s/overlays/prod/replica-patch.yaml`:**
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: myapp1-deployment
  namespace: argocd-prod
  labels:
    app: myapp1-pod
spec:
  replicas: 5
```
**`k8s/overlays/dev/limits-patch.yaml`:**
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: myapp1-deployment
  namespace: dev-ns
  labels:
    app: myapp1-pod
spec:
  template:
    spec:
      containers:
      - name: myapp1-container
        resources:
          requests:
            memory: "40Mi"
            cpu: "40m"
          limits:
            memory: "50Mi"
            cpu: "50m"
```

---
## ⚙️ GitHub Actions Workflows

### Workflow (`.github/workflows/cicd-deploy.yaml`)

```yaml
name: cicd-gcp-gitops
on:
  push:
    branches: [ "main" ]

env:
  GCP_REPOSITORY_NAME: my-artifact-gitops-repo # <-- UPDATE: Your ECR Repository Name
  CONFIG_REPO: https://github.com/aslamchandio/gcp-oidc-gitops-app-repo.git # <-- UPDATE: Argo Manifest Repository URL
  CONFIG_REPO_PATH: kustomize/base/myapp1-deployment.yaml # <-- Path to the manifest file in argo-repo
  CONFIG_REPO_BRANCH: main # <-- Branch in argo-repo to commit to  
  IMAGE_NAME: myapp
  REGION_NAME: us-west1

jobs:   
  build-and-push:
    runs-on: ubuntu-latest
    # These permissions are needed to interact with GitHub's OIDC Token endpoint. New
    permissions:
      id-token: write
      contents: read  

    steps:
      - name: "Checkout"
        uses: 'actions/checkout@v4'

      - name: Configure GCP credentials
        id: auth
        uses: google-github-actions/auth@v2
        with:
          # Value from command: gcloud iam workload-identity-pools providers describe github-actions --workload-identity-pool="github-actions-pool" --location="global"
          workload_identity_provider: '${{ secrets.WORKLOAD_IDENTITY_PROVIDER }}'
          create_credentials_file: true
          service_account: '${{ secrets.SERVICE_ACCOUNT }}'    
          token_format: "access_token"
          access_token_lifetime: "120s"

      
                # Install gcloud SDK (Required!)
      - name: Setup Cloud SDK
        uses: google-github-actions/setup-gcloud@v2

      # Configure Docker auth
      - name: Configure Docker Auth
        run: |
          gcloud auth configure-docker ${{ env.REGION_NAME }}-docker.pkg.dev --quiet

      
      # Generate short commit SHA
      - name: Extract short SHA
        id: vars
        run: echo "IMAGE_TAG=$(git rev-parse --short=7 HEAD)" >> $GITHUB_OUTPUT

      # Build & Push image
      - name: Build and Push Container Image
        run: |
          IMAGE=${{ env.REGION_NAME }}-docker.pkg.dev/${{ secrets.PROJECT_ID }}/${{ env.GCP_REPOSITORY_NAME }}/${{ env.IMAGE_NAME }}:${{ steps.vars.outputs.IMAGE_TAG }}  

          docker build -t $IMAGE .
          docker push $IMAGE

      # Update GitOps repo manifest 
      - name: Update Kubernetes Manifest with new Tag
        run: |
          # Install yq for YAML manipulation
          sudo snap install yq
        
         
          git config --global user.email "github-actions[bot]@users.noreply.github.com"
          git config --global user.name "GitHub Actions CI"

          git clone https://x-access-token:${{ secrets.GITOPS_PAT }}@github.com/aslamchandio/gcp-oidc-gitops-app-repo.git config_repo
          cd config_repo


          yq e '(.spec.template.spec.containers[0].image) = "${{ env.REGION_NAME }}-docker.pkg.dev/${{ secrets.PROJECT_ID }}/${{ env.GCP_REPOSITORY_NAME }}/${{ env.IMAGE_NAME }}:${{ steps.vars.outputs.IMAGE_TAG }}"' -i ${{ env.CONFIG_REPO_PATH }}

          git add .
          git commit -m "CI: Update image tag to ${{ steps.vars.outputs.IMAGE_TAG }}"
          git push origin ${{ env.CONFIG_REPO_BRANCH }}
```

---

## 🔁 Deployment Flow

```
Developer pushes to 'dev' branch
         │
         ▼
GitHub Actions triggers ci-dev.yml
         │
         ├─── OIDC token exchanged for short-lived GCP credentials
         │
         ├─── Docker image built
         │
         ├─── Image pushed to Artifact Registry
         │         us-central1-docker.pkg.dev/project/registry/app:{sha}
         │
         ├─── kustomize edit set image (updates kustomization.yaml)
         │
         └─── Manifest committed and pushed to repo
                      │
                      ▼
              ArgoCD detects change (polls every 3 min or via webhook)
                      │
                      ▼
              ArgoCD syncs 'dev' namespace on GKE
                      │
                      ▼
              New pods roll out (RollingUpdate strategy)
                      │
                      ▼
              ✅ Application deployed to dev
```

For **prod**, the same flow applies — but the `production` GitHub environment gate requires a human approver before the workflow continues.

---

## 🔑 Environment Variables & Secrets

### GitHub Repository Secrets

| Secret | Description |
|--------|-------------|
| `PROJECT_ID` | Your Google Cloud Project ID |
| `WORKLOAD_IDENTITY_PROVIDER` | Workload Identity Provider resource name |
| `SERVICE_ACCOUNT` | Service account email for GitHub Actions |
` 'GITOPS_PAT` | Personal access tokens (which have repo full control) |

Github secrets for cicd pipeline:

```bash

PROJECT_ID  dev-project-123456
WORKLOAD_IDENTITY_PROVIDER   projects/123456789/locations/global/workloadIdentityPools/github-actions-cicd-gcp-pool/providers/my-github-actions-cicd-gcp-oidc

SERVICE_ACCOUNT   cicd-oidc-gcp-sa@dev-project-123456.iam.gserviceaccount.com
GITOPS_PAT Personal access tokens (which have repo full control)

Note: Above secrets apply on gcp-oidc-gitops-code-repo repo
```

### GitHub Environments

Create two environments in **Settings → Environments**:

| Environment | Protection Rules |
|-------------|-----------------|
| `development` | None (auto-deploy) |
| `production` | Required reviewers, deployment branch: `main` |

---

## 📊 Monitoring & Observability

### Check ArgoCD Application Status

```bash
# List all apps
argocd app list

# Get detailed status
argocd app get my-app-prod

# Manually trigger a sync
argocd app sync my-app-prod

# View recent sync history
argocd app history my-app-prod
```

### Check Kubernetes Resources

```bash
# Dev namespace
kubectl get all -n dev-ns
kubectl get gateway -n dev-ns
kubectl get httproute -n dev-ns

# Prod namespace
kubectl get all -n prod-ns
kubectl get gateway -n prod-ns
kubectl get httproute -n prod-ns

# View rollout status
kubectl rollout status deployment/prod-my-app -n prod-ns

# View logs
kubectl logs -f -l app=my-app -n prod-ns
```

### Recommended Add-ons

- **Prometheus + Grafana** — cluster and application metrics
- **Google Cloud Logging** — centralized log aggregation (enabled by default on GKE)
- **Alertmanager** — alerting on deployment failures or pod restarts

---

## 🛠️ Troubleshooting

### OIDC Authentication Fails

```bash
# Verify the Workload Identity Pool exists
gcloud iam workload-identity-pools list --location=global

# Check provider configuration
gcloud iam workload-identity-pools providers describe github-provider \
  --workload-identity-pool=github-actions-pool \
  --location=global
```

Common causes:
- `id-token: write` permission missing in the workflow's `permissions` block
- The `attribute.repository` condition doesn't match `org/repo` format

### Image Push Fails

```bash
# Re-authenticate Docker
gcloud auth configure-docker us-central1-docker.pkg.dev

# Check service account has Artifact Registry Writer role
gcloud projects get-iam-policy $PROJECT_ID \
  --flatten="bindings[].members" \
  --filter="bindings.members:serviceAccount:github-actions@*"
```

### ArgoCD Out of Sync

```bash
# Force a hard refresh (clears cache)
argocd app get my-app-dev --hard-refresh

# Check sync errors
argocd app get my-app-dev -o json | jq '.status.conditions'
```

### Kustomize Build Errors

```bash
# Validate overlay locally before pushing
kustomize build k8s/overlays/dev | kubectl apply --dry-run=client -f -
kustomize build k8s/overlays/prod | kubectl apply --dry-run=client -f -
```

---

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/my-feature`
3. Commit your changes: `git commit -m 'feat: add my feature'`
4. Push to your branch: `git push origin feature/my-feature`
5. Open a Pull Request targeting `dev`

All PRs to `main` must go through `dev` first and pass the automated checks.

---

## 📄 License

This project is licensed under the MIT License — see the [LICENSE](LICENSE) file for details.

---

<div align="center">

**Built with ❤️ using GKE · Terraform · ArgoCD · GitHub Actions**

</div>
