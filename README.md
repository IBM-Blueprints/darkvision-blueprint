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


-------------------------------------

_This is for demostration purposes only; this repository does not contain working code_
