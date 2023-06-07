#!/bin/bash 

# Exports credentials.tfvars to environment variable to be used by packer. Since environment variables are nuked when you click away from the shell, we will have to do this every time.

export $(xargs < ./credentials.env)

