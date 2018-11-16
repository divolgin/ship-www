---
categories:
- lifecycle
date: 2018-01-17T23:51:55Z
description: A `terraform` step will deploy terraform resources.
index: docs
title: terraform
weight: "100"
gradient: "purpleToPink"
---

[Assets](/reference/assets/overview) | [Config](/reference/config/overview) | [Lifecycle](/reference/lifecycle/overview)

## terraform

A `terraform` step will deploy terraform resources.





### Optional Parameters


- `path` - the directory within `installer` within which to run terraform.


### Examples

```yaml
lifecycle:
  v1:
    - terraform: {}
```

```yaml
lifecycle:
  v1:
    - terraform:
        path: terraform/
```
