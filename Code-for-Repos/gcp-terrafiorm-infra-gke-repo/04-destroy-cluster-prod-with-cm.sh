#!/bin/bash
set -e

echo
echo "==============================="
echo "STEP-1: Destroy Prod GKE Cluster"
echo "==============================="
cd p2-gke-private-cluster/environments/prod
terraform init
terraform destroy -auto-approve
rm -rf .terraform .terraform.lock.hcl
echo "✅ GKE Cluster destroyed"

echo
echo "==============================="
echo "STEP-8: Destroy Prod VPC & CloudSQL"
echo "==============================="
cd ../../../p1-vpc-fw-vm-cloudsql-cm-custom-modules/environments/prod
terraform init
terraform destroy -auto-approve
rm -rf .terraform .terraform.lock.hcl
echo "✅ VPC & CloudSQL destroyed"

echo
echo "==============================="
echo "✅ DESTRUCTION COMPLETE"
echo "==============================="