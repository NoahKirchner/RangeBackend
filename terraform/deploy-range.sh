#!/bin/bash 

(cd ./range-topology && terraform apply --var-file=../credentials.tfvars --parallelism 6 --auto-approve)
