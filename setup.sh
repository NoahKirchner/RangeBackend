#!/bin/bash 
(cd ./scripts && ./download-images.sh)
(cd ./terraform && ./terraform-initial-setup.sh)
(cd ./terraform && ./deploy-blank-images.sh)

echo "A group of images have just been deployed to terraform with the prefix 'blank'. Go through the installation process on them and ensure that you use the same username and password for all of them."
