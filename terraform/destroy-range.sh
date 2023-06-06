#!/bin/bash 

(cd ./range-topology && terraform destroy --var-file=../credentials.tfvars --auto-approve)
