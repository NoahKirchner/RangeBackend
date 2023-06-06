#!/bin/bash 
./scripts/download-images.sh
./terraform/terraform-initial-setup.sh
./terraform/deploy-blank-images.sh

echo "A group of images have just been deployed to terraform with the prefix 'blank'. Go through the installation process on them and ensure that you use the same username and password for all of them."
