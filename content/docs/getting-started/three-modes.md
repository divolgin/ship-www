---
date: "2016-07-03T04:02:20Z"
title: "Three Modes of Ship"
description: "The Three Modes Of Ship"
weight: "100"
index: ["docs"]
gradient: "purpleToPink"
---

There are three distinct steps involved in running external applications in Kubernetes:

![Ship Lifecycle](/images/ship-flow.png)

## ship init
The init mode of ship facilitiates the process of getting started with a new application. This is normally a one-time process that involves providing the initial configuration values, generating any patches or overlays required to run in the target environment, and then validating the application. Once the initial configuration of the application is confirmed, existing tools can be used to deploy it.

Ship init allows for creation of custom values and custom patches and overlays using [Kustomize](https://kustomize.io).

## ship watch
The watch mode of ship will periodically poll the upstream application (Helm chart, Kubernetes manifest, etc) and will exit when the upstream content changes. This mode enables triggering a workflow (CI/CD) step to update a running application. Watch does not update the application, it simply triggers an event when an update is available.

## ship update
The update mode of ship will pull the upstream application from the source, apply any values, and then render a new base directory. This should be the step that is run in a CI/CD process, triggered when the watch command detects an update. Using ship watch and ship update like this is a way to keep third-party applications constantly updated.