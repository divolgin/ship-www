---
date: "2018-05-01T19:00:00Z"
title: "Automated Deployment with a Kubenretes App"
description: "Automated Deployment with a Kubenretes App"
weight: "30003"
gradient: "greenToGreen"
icon: "replicatedKubernetes"
resources: 
    - title: "ship_spec.yaml"
      src: "resources/ship_spec.yaml"
    - title: "circle.config"
      src: "resources/circle.config"
---
Kubernetes applications delivered in Replocated Ship can be deployed using automation instead of manually running `kubectl` to deploy from a laptop. It's possible to deploy the first release of an application completely automated, even to airgapped environmnets. This document walks through an example application and how it will be configured and initially deployed.

## Prerequisites

In addition to any external resources the software vendor requries (databases, etc), you'll need to have:

- a version control system (VCS) ,such as GitHub Enterprise
- a secure storage location, that can store a single, small, encrypted file
- a continuous intergration / continuous delivery platform, such as CircleCI Enterprise or TravisCI Enterprise
- a local Docker Registry, that is accessible to the target Kubernetes cluster, such as Artifactory
- a working Kubernetes cluster that meets the minimum requirements provided by the software vendor

## Overview

The process to deploy the first release, complete automated is to configure the release from a laptop running MacOS, Windows or Linux, and then store the release source file (`ship.yaml`) in a local VCS, and the configured Ship state (`state.json`) in a secure storage location. Then, a workflow can be built to take these two inputs and automate a build and deployment to the target Kubernetes cluster.

## Initial Configuration

From a laptop running Docker, run the setup command provided by the software vendor:

```shell
curl -sSL https://get.replicated.com/ship?customer_id=<your_license_key> | docker-compose -f - up
```

This will download a couple of Docker containers and then show a message similar to this:

```shell
Please visit the following URL in your browser to continue the installation

        http://localhost:8800

```

Next, open the URL provided (http://localhost:8800), and supply all of the intial configuration values and click Save.

## Extract the state.json and ship.yml

At this point, the laptop has all of the required Docker images, configured Kubernetes manifests, and scripts needed to deploy this application using `kubectl`. That's not the goal here, so don't run the provided scripts or commands.

### state.json

The configured state should be in a single file, stored in `.ship/state.json`. This file may contain secrets and confidental information such as database passwords and more. Encrypt this file from the command line (// TODO provide an example here) and manually upload it to your secure storage location. For example:

```shell
$ aws s3 upload my-app-config | encrypt ./ship/state.json
```

### ship.yaml

The original YAML file that the software vendor created and was used as an input to create the local assets is stored in `./installer/ship/ship.yaml`. This file doesn't contain any secrets, it's a generic release manifest. Commit this file to a new repo in source control. For example:

```shell
cd installer/ship
git init
git add ship.yml
git remote add ...
git push origin master
```

## Configure a CI/CD workflow

Next, configure a CI/CD workflow to take the state.json and ship.yml as inputs, and run the ship container in a headless (automated) mode, which will produce the same assets that were created when running the Admin Console locally. The following commands should be added to the CI/CD process:

```shell
$ docker pull repliated/ship:1
$ aws s3 get my-app-config/state.json
$ decrypt state.json
$ docker run -v `PWD`:/in  -v`PWD`/installer:/out -e CUSTOMER_ID=<customer_id> replicated/ship:1 --headless
$ ./installer/scripts/install.sh
$ ./installer/scripts/test.sh
$ aws s3 upload my-app-config | encrypt ./ship/state.json
```

This will pull the Replicated Ship container, download the encrypted state, decrypt the state. Then it will use the Ship container to build and fetch all required assets. Then, the CI/CD server will run the installation script and then test the created installation. Finally, the above script will encrypt the latest state values, and store them securely for the next release.

