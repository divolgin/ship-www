---
date: "2016-07-03T04:02:20Z"
title: "Default Helm Chart ship.yaml"
description: "Ship default yaml for Helm charts"
weight: "100"
index: ["docs"]
gradient: "purpleToPink"
draft: true
---

When Ship detects a Helm chart that doesn't have a `ship.yaml` present, Ship will apply a default ship.yaml to enable the `ship init` experience.

The following YAML matches the default `ship.yaml` that is implied when Ship is run against a Helm chart that doesn't specify a different YAML:

