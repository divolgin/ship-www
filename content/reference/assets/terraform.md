---
categories:
- assets
date: 2018-01-17T23:51:55Z
description: A `terraform` asset is text specified directly in your Ship application's spec.
index: docs
title: terraform
weight: "100"
gradient: "purpleToPink"
---

[Assets](/reference/assets/overview) | [Config](/reference/config/overview) | [Lifecycle](/referenc/lifecycle/overview)

## terraform

A `terraform` asset is text specified directly in your Ship application's spec.





### Required Parameters


- `inline` - The contents of the file



### Optional Parameters


- `dest` - A path to which the file should be written when generating assets. Defaults to `main.tf`


- `mode` - Specifies file mode of the created asset, defaults to `0644`


- `when` - This asset will be included when 'when' is omitted or true


### Examples

```yaml
assets:
  v1:
    - terraform:
        inline: >-
          resource "random_id" "server" { byte_length = {{repl ConfigOption
          "id_length" | ParseInt}}}
```

```yaml
assets:
  v1:
    - terraform:
        dest: terraform/random_id.tf
        inline: >-
          resource "random_id" "server" { byte_length = {{repl ConfigOption
          "id_length" | ParseInt}}}
```
