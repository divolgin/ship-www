---
date: "2018-05-01T19:00:00Z"
title: "Initial configuration"
description: "Configuring an application for the first deployment"
weight: "30003"
gradient: "greenToGreen"
---

# Initial Configuration

When configurating and deploying a Ship application, it's common to create the initial configuration, then build a audited, workflow-driven process to automate the deployment and future updates. When initially configuring and deploying an unfamiliar application, it's helpful to start with some easy-to-use tools to help bootstrap the process.

The best way to deploy a Replicated Ship application is to run the `replicated/ship` process on a workstation that doesn't have direct access to the production servers. Complete the initial configuration process and create all assets from this workstation. Ship provides a web-based UI that runs locally (in Docker) to make this process similar across different applications.

## Generating the initial configuration

Before an application can be installed, the initial configuration should be generated. Start with a workstation (MacOS, Windows, Linux) that has Docker installed. This process is designed to run on a workstation that can pull external resources (not airgapped), and prepare them for deployment inside the network. The workstation running the configuration isn't required to have access to the target server(s).

To start, run the command that the software vendor provided. For example:

```shell
curl -sSL https://get.replicated.com/ship?customer_id=<your_license_key> | docker-compose -f - up
```

This will download a couple of Docker containers and then show a message similar to this:

```shell
Please visit the following URL in your browser to continue the installation

        http://localhost:8800

```

## The Admin Console

Visiting this URL from the same workstation will open a web-based workflow to configure the application and bring all initial artifacts and configuration into a directory on the workstation, to be deployed at any time.

Each application will require different inputs to generate the initial configuration. Once you complete this, a message will show you that it's completed, and show the next steps.

The next steps will vary, depending on the application being configured. Be sure to read these.

## Deploying

After completing the initial configuration steps using the Admin Console, most applications will download and generate various assets (configuration files, docker images, kubernetes manifests, etc). By default, these will be stored in a directory named `./installer` (relative to the directory the Admin Console was started from).

Ship application will create several directories:

```
└── ./ship
│     │
│     └── state.json
│     └── release.yaml
│
└── ./installer
│      │
│      └── scripts
│            │
│            └── install.sh
│            └── test.sh
│
└── images
└── k8s
```

### ./ship/

Every Ship application will create a `.ship` directory with two files:

- `state.json`: This file contains the version information and all values provided to the the Admin Console
- `release.yaml`: This is the raw, configured application manifest that can be used to automate the installation from a script

### installer/

Every Ship application will create a `installer` directory. This contains all scripts and assets that are needed to be present to deploy the application. The `replicated/ship` container will produce everything in this directory when given a `./ship/state.json` and a `./ship/release.yaml` (defined above).

### installer/scripts

By convention, a Ship application will create a `installer/scripts` directory. This directory will contain any scripts necessary to install, update or test the application.

### installer/images

For applications that are packaged in Docker containers, the `installer/images` directory will contain exported, `.tar` files for all application images that are required to run the application.

## Deploying

Once the application has been configured locally, the `./ship/state.json` and `./ship/release.yaml` can be [securely stored](../manage-state) and then configured to be [automatically deployed](../automated-deployment).
