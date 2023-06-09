#!/bin/bash 

source ../scripts/lib.sh

while read -r name address sha256hash; do 
    if test -f ../images/$name.iso; then
        cp ../images/$name.iso /var/lib/vz/template/iso/$name.iso
        echo -e "$okay Moved $name to Proxmox template directory."
    else 
        echo -e "$warn $name not found in images directory."
    fi 
done < "../scripts/mirrorlist"

if test -f credentials.tfvars; then
    echo -e "$okay Credential file found."
else 
    echo -e "$warn No credential file found. Have you run terraform_setup.sh?"
fi 

(cd ./init-topology && terraform apply --var-file=../credentials.tfvars --auto-approve)


    






































