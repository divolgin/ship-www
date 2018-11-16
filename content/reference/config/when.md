---
categories:
- config
date: 2018-01-17T23:51:55Z
description: The `when` property is used to control whether an item will be shown to the end user.
index: docs
title: when
weight: "100"
gradient: "purpleToPink"
---

[Assets](/reference/assets/overview) | [Config](/reference/config/overview) | [Lifecycle](/reference/lifecycle/overview)

## when

The `when` property is used to control whether an item will be shown to the end user.




### Examples

```yaml
config:
  v1:
    - when: >-
        '{{repl or (ConfigOptionEquals "select_one" "external")
        (ConfigOptionEquals "select_one" "embedded")}}'
```
