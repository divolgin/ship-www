---
categories: ["update"]
date: "2016-07-03T04:02:20Z"
title: "Update With GitOps"
description: "Updating with GitOps"
weight: "100"
index: ["docs"]
gradient: "purpleToPink"
---

Applications configured using Replicated Ship can be deployed using automation instead of manually running installation scripts. The steps to automate deployment of an application varies, depending on the automation tools used. This document defines the steps involved in automating the deployment of a third-part application that is configured and updated using Replicated Ship.

The process to automate deployment of an application involves 3 steps:

1. Create the initial configuration using `ship init`.
1. Using the `state.json` file, automate the `ship watch` and `ship update` commands.
1. Commit the output of `ship update` to a git repo, and let a GitOps tool deploy.

## Create state.json

From a workstation run the ship init command to get started creating the initial configuration and state:

```shell
ship init github.com/helm/charts/stable/graafana
```

This will download and analyze the application (this is the upstream application). Once ship determines the application type and workflow, it will prompt to open a browser. Complete this first configuration. For help here, visit the [ship init documentation](/docs/ship-init).

### Commit the output

At this point, there's a `.ship` directory, and two additional directories: `base/` and `/overlays`. The ship init command shows that `kustomize build overlays/ship` is the command to generate the deployment Kubernetes YAML. Commit all three of these directories to a git repo.

### Run update and commit the results

When an update is available (detected using [ship watch](/docs/ship-watch)), it can be automatically configured using `ship update`, if run from a location containing the `.ship/state.json` file.