#!/bin/bash
set -e

echo "==============================="
echo "STEP-1: Create Prod VPC & Cloud Sql using Terraform"
echo "==============================="
cd p1-vpc-fw-vm-cloudsql-cm-custom-modules/environments/prod
terraform init 
terraform apply -auto-approve

echo
echo "==============================="
echo "STEP-2: Create Prod GKE Cluster using Terraform"
echo "==============================="
cd ../../../p2-gke-private-cluster/environments/prod
terraform init 
terraform apply -auto-approve

echo
echo "==============================="
echo "SUMMARY"
echo "==============================="
echo "✅ VPC created successfully"
echo "✅ Cloud Sql created successfully"
echo "✅ GKE Cluster created successfully"

echo
echo "Your Prod GKE Cluster with NAP and ComputeClass is now fully configured and ready to use!"
echo "==============================="