#!/bin/bash 

(cd ./core-topology && terraform destroy --var-file=../credentials.tfvars --auto-approve)
