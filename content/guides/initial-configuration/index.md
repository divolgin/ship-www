---
date: "2018-05-01T19:00:00Z"
title: "Initial configuration"
description: "This is a test chapter and doesn't have any content"
weight: "30003"
gradient: "greenToGreen"
resources: 
    - title: "ship_spec.yaml"
      src: "resources/ship_spec.yaml"
    - title: "circle.config"
      src: "resources/circle.config"
---

# Initial Configuration

While applications delivered in Replicated Ship can be initially configured in a fully automated way, nfiguratint's common to create the initial configuration manully, then building a audited, workflow-driven process to automate deployment and future updates. When getting started configuring and deplying an unfamiliar application, it's common to start with some easy-to-use tools to help bootstrap the process.

A good practice is to run the `replicated/ship` process on a laptop to walk through the initial configuration process, and create the assets. Ship provides a web-based UI that runs locally (in Docker) to make this process similar across any application.

## Generating the initial configuration

When starting to prepare a new Ship application for installation, start with a workstation (MacOS, Windows, Linux) that has Docker installed. This process is designed to run on a workstation that can pull external resources (not airgapped), and prepare them for deployment inside the network. The workstation running the configuration isn't required to have access to the target server(s).

To start, run the command that the software vendor provided. For example:

```shell
curl -sSL https://get.replicated.com/ship?customer_id=<your_license_key> | docker-compose -f - up
```

This will download a couple of Docker containers and then show a message similar to this:

```shell
Please visit the following URL in your browser to continue the installation

        http://localhost:8800

```

### The Admin Console

Visiting this URL from the same workstation will open a web-based workflow to configure the application and bring all initial artifacts and configuration into a directory on the workstation, to be deployed at any time.

Each application will likely have a slightly different workflow to generate all required configuration. Once you complete this, a message will show you that it's completed, and show the next steps.

The next steps will vary, depending on the application being configured. Be ssure to read these.

## Deploying

After completing the initial configuration steps using the Admin Console, most applications will download and generate various assets (configuration files, docker images, kubernetes manifests, etc). By default, these will be stored in a directory named `./installer` (relative to the directory the Admin Conosle was started from).

By convention, a Ship application will create several directories:

```
./installer
  |
  |- /scripts
  |- /images
  |- /secrets
  |- /tests
  |- /k8s (or /helm or any manifests needed to deploy)

```

## Storing Config