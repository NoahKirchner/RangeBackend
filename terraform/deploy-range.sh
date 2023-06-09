#!/bin/bash 

(cd ./range-topology && terraform apply --var-file=../credentials.tfvars --auto-approve)
