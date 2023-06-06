#!/bin/bash 

(cd ./core-topology && terraform apply --var-file=../credentials.tfvars --auto-accept)
