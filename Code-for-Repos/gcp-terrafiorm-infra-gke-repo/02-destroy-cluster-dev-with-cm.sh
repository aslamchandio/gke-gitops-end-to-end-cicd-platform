#!/bin/bash
set -e

echo
echo "==============================="
echo "STEP-1: Destroy Dev GKE Cluster"
echo "==============================="
cd p2-gke-private-cluster/environments/dev
terraform init
terraform destroy -auto-approve
rm -rf .terraform .terraform.lock.hcl
echo "✅ GKE Cluster destroyed"

echo
echo "==============================="
echo "STEP-8: Destroy Dev VPC & CloudSQL"
echo "==============================="
cd ../../../p1-vpc-fw-vm-cloudsql-cm-custom-modules/environments/dev
terraform init
terraform destroy -auto-approve
rm -rf .terraform .terraform.lock.hcl
echo "✅ VPC & CloudSQL destroyed"

echo
echo "==============================="
echo "✅ DESTRUCTION COMPLETE"
echo "==============================="