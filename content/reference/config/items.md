---
categories:
- config
date: 2018-01-17T23:51:55Z
description: The `items` property is a grouping of similar config items.
index: docs
title: items
weight: "100"
gradient: "purpleToPink"
---

[Assets](/reference/assets/overview) | [Config](/reference/config/overview) | [Lifecycle](/reference/lifecycle/overview)

## items

The `items` property is a grouping of similar config items.




### Examples

```yaml
config:
  v1:
    - items:
        name: http_enabled
        title: HTTP Enabled
        help_text: When enabled we will listen to http
        type: bool
        default: '0'
```
