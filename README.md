# Hiddify-Configurator

This repository contains a setup script for automating the deployment and configuration of the **Hiddify** application on a virtual machine using Terraform and Ansible.


## Table of Contents

- Overview
- Prerequisites
- Configuration
- Installation
- Contributing
- Licence

## Overview
The **Hiddify Setup Script** provides a streamlined way to deploy and configure the [**Hiddify**](https://github.com/hiddify/hiddify-config) application on a Digital Ocean Droplet. This script utilizes [Terraform ↗](https://www.terraform.io/) to provision the virtual machine on Digital Ocean and [Ansible ↗](https://www.ansible.com/) to install the required packages and configure the application.

## Prerequisites

Before using the setup script, ensure you have the following prerequisites:

- [Terraform ↗](https://www.terraform.io/) installed on your local machine.
- [Ansible ↗](https://www.ansible.com/) installed on your local machine.
- A Digital Ocean account with API credentials.
- A Digital Ocean private key location
- A Cloudflare account with API credentials with write access to your DNS zone
- A Cloudflare zone id

## Configuration
Before you run the script you have to update the variable files to set your api keys. The file name that you have to modify is `terraform.tfvars`. Here is a sample configuration:
```
do_token="YOUR_DIGITAL_OCEAN_API_KEY"
pvt_key="YOUR_DIGITAL_OCEAN_PRIVATE_KEY_LOCATION"
region="ZONE_THAT_YOU_WANT_TO_HOST_DROPLET (Default if france)"
cloudflare_api_token="YOUR_CLOUDFLARE_API_TOKEN"
cloudflare_zone_id="YOUR_DNS_ZONE_ID"
```
## Usage
To use the setup script, you just have to run the following command on your terminal:
```bash
./init.sh
```
## Contributing

Contributions to this project are welcome! If you find any issues or have suggestions for improvements, please feel free to open an issue or submit a pull request.

## License

This project is licensed under the  GPL-3.0 License. Feel free to use and modify this script as per your requirements.
