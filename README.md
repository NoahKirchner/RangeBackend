# RangeBackend

This repository contains a series of bootstrapping scripts, configuration files, and virtualization tools used to deploy a "red vs. blue" cybersecurity range from a blank proxmox server. Installation should be fairly simple using the setup.sh script in the root directory. However, in the event something fails, the instructions will also be available below to perform the installation manually.

## Setup

1. ### Dependency Installation
This application is dependant on Proxmox, terraform, and packer to operate correctly.

Proxmox installation instructions: https://www.proxmox.com/en/proxmox-ve/get-started

Once Proxmox is installed on your hardware, you need to update both your apt repositories and your operating system using `apt-get update`. Once this has been updated, install the newest versions of terraform and packer using `apt-get install terraform` and `apt-get install packer`.

After these are installed, your dependencies have been installed.

2. ### Cloning the repository

Navigate to the home page of this repository (you should already be here). Click the "code" button in the top right, select the "https" format and copy that URL to your clipboard.

![image](https://github.com/NoahKirchner/RangeBackend/assets/18649015/a5d773e6-6be5-4822-9afd-8762731f5a67)

Go to your proxmox terminal and run the command `git clone [url]` (without the brackets). If the "git" command is not recognized, you may have to run `apt-get install git` first.

3. ### Initial Setup

If possible, you should attempt to run the `setup.sh` script in the root directory. This should handle most of the bootstrapping for you, including downloading .iso files you will need in the future and moving them to the correct location. If this fails for any reason, you can follow the instructions below to manually set up the backend infrastructure.

4. ### Downloading VM Images

Navigate to the `scripts` directory and run the `download-images.sh` script. If this does not work, there may either be a problem with one of the links in `mirrorlist`, or something is wrong with the script itself. Manually installing these (or any other) .iso is not very complicated, however.

To operate, you will need images of the following operating systems.
* pfSense
* Windows 10
* Kali Linux
* Windows Server 2019
* Security Onion
* Debian

Find a location to install an iso of these operating systems and copy the URL of the download link to your clipboard. Navigate to the `images` directory and install them using the following command.
`wget [url] .`. Some of the images might be gzipped, which you can unzip using `gzip -d [filename]`. If they need to be unzipped, run `file [filename]` to confirm that they are ISO files. Compare the sha256 hash of the files with the ones provided by the website by using `sha256sum [filename]`.

If the hashes match, rename the files in the following manner:
* pfSense -> pfsenseraw.iso
* Windows 10 -> win10raw.iso
* Kali Linux -> kaliraw.iso
* Windows Server 2019 -> winserverraw.iso
* Security Onion -> seconionraw.iso
* Debian -> debianraw.iso

5. ### Terraform Setup

Navigate to the `terraform` directory. Here, you should run the `terraform-initial-setup.sh` script and enter a password when prompted. If it fails, however, perform the following actions.

Come up with a good password in your head.

You need to run the two following commands to create the terraform user, giving terraform permissions in proxmox to engage in certain functions.

First we will create the role with:
`pveum role add TerraformProv -privs "Datastore.AllocateSpace Datastore.Audit Pool.Allocate Sys.Audit Sys.Console Sys.Modify VM.Allocate VM.Audit VM.Clone VM.Config.CDROM VM.Config.Cloudinit VM.Config.CPU VM.Config.Disk VM.Config.HWType VM.Config.Memory VM.Config.Network VM.Config.Options VM.Migrate VM.Monitor VM.PowerMgmt"`
Then the user with:
`pveum user add terraform-prov@pve --password [password]`
We will now modify the user account's ACL as such:
`pveum aclmod / -user terraform-prov@pve -role TerraformProv`

Now we have given terraform a user and have to ensure that terraform knows its own credentials by making it a variable file. Create the file in the terraform directory like this:
`touch credentials.tfvars`

Using your text editor of choice, replicate the following format inside of the file.

```
PM_USER="terraform-prov@pve"
PM_PASSWORD="[password]"
```

Write & quit from the file. Terraform should now be able to see its own credentials.

To prepare each of the topology directories (and to ensure that terraform is working), ssh into each of:
* terraform/core-topology
* terraform/init-topology
* terraform/range-topology

And run the command `terraform init`.

6. ### Creating Templates

Terraform requires templates with standardized names to operate. Until Packer is working, you need to go through their installation process manually. You should be able to run the `deploy-blank-images.sh`, but if this fails you will need to manually move the .iso files to their destination and start them.

You have already downloaded all of the necessary images, but you need to move them so terraform can access them.

The directory for these files is `/var/lib/vz/template/iso/`. You should copy each of the images to the destination using `cp [filename] /var/lib/vz/template/iso/[filename]`.

You should now be able to deploy the `init-topology`. Navigate to the `terraform/init-topology` directory and run the command `terraform apply --var-file=../credentials.tfvars`. When prompted, type `yes`, and leave the shell you have open up for the next ~10 minutes while the images deploy. 

If this does not work, terraform has not successfully installed, there is an issue with a script, or there is a skill issue with Proxmox. Google the error message and attempt to solve the problem. If it is an issue regarding `local` vs. `local-lvm`, attempt changing the `/etc/pve/storage.cfg` file to have `dir: local` contain `content vztmpl,rootdir,snippets,iso,images,backup` instead of the default. If it is neither of these things, go back over the instructions and do some troubleshooting.

After ~10 minutes, you should have provisioned one of each of the images you installed as a VM, in the format `blank-[os-name]`. Navigate to each console and go through the installation process. Give them them all a common username/password combination (we recommend whitecell/whitecell).

Once all have been installed, you get to save them as a template. Shut each of the virtual machines down. Right click each of them and click `convert to template`. You should now have a templated version of each, but you must change their names. Click on each of the templates, go to the `options` tab, and double click on the `name` section. Rename them as the following:
* blank-pfsense -> pfSense
* blank-win10 -> Windows10Pro
* blank-kali -> Kali
* blank-debian -> Debian
* blank-win2019-server -> WindowsServer2019
* blank-seconion-standalone -> SecurityOnion

7. ### Core Deployment

You are now ready to deploy your first infrastructure! Use the `deploy-core.sh` script in the `terraform` directory, or from `terraform/core-topology`, use the command `terraform apply --var-file=../credentials.tfvars`. This should start a securityonion instance and three routers. Fun! I hope you enjoy configuring seconion because you now get to do it (the devops part has concluded).

First though, we have configurations for the routers. Terraform should have deployed three pfSense routers, one called `wan-router-tf`, one called `dmz-router-tf`, and one called `core-router-tf`. The names are important. Open up another proxmox window, and navigate on it to scripts/orchestration. Run this command: `python3 -m http.server` from that directory to host a webserver so you can pull the scripts to the routers.

In the other window, navigate to each of the routers. When there, navigate to `/conf`. You should see a file named config.xml. Rename it using `mv config.xml config.xml.backup`, and then find the orchestration file that corresponds to the "type" of router you are in (for example, in the "wan" router find the "wan" configuration in `/scripts/orchestration/`. Now, pull the configuration file over using `curl [proxmox IP]:8000/[config] -o config.xml`. Repeat this for every router.

Now log into security onion and configure it however you see fit. Have fun!

8. ### Range Deployment

Now that the core infrastructure is deployed, you can run the `deploy-range.sh` script in `terraform/` to deploy the range itself. If this does not work, navigate to `terraform/range-topology` and run `terraform apply --var-file=../credentials.tfvars` and wait the ~10 or so minutes for the hosts to deploy. The routers should assign them IP addresses via DHCP if they are attached to certain bridges, or on others you may need to assign static IP addresses. Congratulations, you now have a working range!

9. ### Orchestration

Orchestration is a work in progress, but there are a number of scripts to use in /scripts/orchestration that you may find useful for configuring things such as domain controllers or workstations. Eventually their deployment will be automated, but for now it is up to you to figure out how to do that. We did most of the work for you up to this point, so enjoy!


