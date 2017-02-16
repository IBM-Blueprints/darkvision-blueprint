# Darkvision Blueprint

[![Build Status](https://travis-ci.org/IBM-Bluemix/openwhisk-darkvisionapp.svg?branch=master)](https://travis-ci.org/IBM-Bluemix/openwhisk-darkvisionapp) ![Bluemix Deployments](https://deployment-tracker.mybluemix.net/stats/ad94d1daf817a5fd818f977c0a7cf632/badge.svg)

An IBM Bluemix Blueprint to provision and manage infrastructure for the [OpenWhisk Darkvision App](https://github.com/IBM-Bluemix/openwhisk-darkvisionapp)

This Blueprint will allow you to provision and manage infrastructure as a single unit using [Terraform](terraform.io). This Blueprint can be used with the [IBM Bluemix Blueprint Service](bluemix.com) 

It will deploy the following architecture:

![arch](assets/darkvision.jpg)

This is comprised of the following components:

  * [Watson Visual Recognition](https://console.ng.bluemix.net/catalog/services/watson_vision_combined)
  * [OpenWhisk](console.ng.bluemix.net/openwhisk/)
  * [Cloudant](https://console.ng.bluemix.net/catalog/services/cloudantNoSQLDB)
  * [Object Storage](https://console.ng.bluemix.net/catalog/services/Object-Storage)

## Using this Blueprint

To use this Blueprint from your local workstation, you'll first need to download [Terraform](terraform.io) and be sure you've read the [Terraform Getting Started Guide](https://www.terraform.io/intro/getting-started/install.html).

You can see the infrastructure that this Blueprint will create by checking out this repository, supplying the necessary variables, and running `terraform plan`.
You can then provision the infrastructure by running a `terraform apply`.

-------------------------------------

_This is for demostration purposes only; this repository does not contain working code_
