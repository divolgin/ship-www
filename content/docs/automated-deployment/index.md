---
date: "2018-05-01T19:00:00Z"
title: "Automated Deployment"
description: "Automated Deployment"
weight: "30003"
gradient: "greenToGreen"
icon: "replicatedCircle"
---

# Automated Deployment

Applications delivered in Replicated Ship can be deployed using automation instead of manually running installation scripts. It's possible to deploy the first release of an application completely automated, even to airgapped environments. The process to automate deployment of an application varies, depending on the automation tools used. This document defines the steps involved in automating the deployment of an on-prem application, with links to specific implementations, when possible.

The process to automate deployment of an application involves 3 steps:

1. Create the initial `state.json` and `release.yml`.
1. From these 2 files, automate creation of all required assets
1. Execute the install script to deploy

## Create state.json and release.yml

From a workstation (not the server) running Docker, run the setup command provided by the software vendor. For example:

```shell
curl -sSL https://get.replicated.com/ship?customer_id=<your_license_key> | docker-compose -f - up
```

This will download a couple of Docker containers and then show a message similar to this:

```shell
Please visit the following URL in your browser to continue the installation

        http://localhost:8800

```

Next, open the URL provided (http://localhost:8800). This is the Admin Console. This UI will prompt for some input values and provide instructions to install. Using the Admin Console, supply all of the intial configuration values and click Save and then Continue.

### Extract the state.json and ship.yml

At this point, there are two new directories created on the workstation: `.ship` and `installer`.

`./installer`: This directory contains generated scripts and assets that are needed to deploy the application. This contains docker images, kubernetes manifests, or anything else needed to deploy and run the application in an airgapped environment. Because the goal is to automate deployment, this directory isn't needed now. It's ok to delete.

`./ship`: This directory contains the two files that are needed to automate the initial installation. Find the files named `./ship/state.json` and `./ship/release.yml`. These files are described below:

### state.json

The configured state will be in a single file, stored in `.ship/state.json`. This file may contain secrets and confidental information such as database passwords and more. Don't check this file into source control without taking [proper steps to ensure it remains secret](../manage-state).

### release.yaml

The original YAML file that the software vendor created and was used as an input to create the local assets is stored in `./.ship/release.yaml`. This file doesn't contain any secrets, it's a generic release manifest. This file can be commited to a configuration management repo or any other tool to automate deployment.

## Automate release creation

From the `state.json` and `release.yml`, it's possible to generate all assets that were originally created under the `installer/` directory, using the following command:

```shell
$ docker run -v `PWD`:/in  -v`PWD`:/out \
    -e CUSTOMER_ID=<customer_id> replicated/ship:1 \
    --headless \
    --studio-file=./ship/release.yml
```

This will pull the Replicated Ship container, then it will use the Ship container to build and fetch all required assets. The command will mount the `release.yml` and `state.json` files into known locations for the `replicated/ship` container to read. Using the customer_id provided (the license key), the ship container will pull all images or artifacts, and apply the state.json values to them to create the deployable assets.

## Deploy

Deploying the application is as simple as running `./installer/scripts/install.sh`. This installer is customized with the configuration info that was passed in, and will deploy to the target servers or clusters that are defined.

---

## Related documents

- [Automated Deployment of a Kubernetes application](../automated-deployment-kubernetes-app)
- [Automated Updates with CircleCI](../automated-updates-circleci)
- [Automated Testing](../automated-testing)
