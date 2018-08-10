---
date: "2018-05-01T19:00:00Z"
title: "Automated Testing"
description: "Automated Testing"
weight: "30003"
gradient: "greenToGreen"
categories: [ "Testing" ]
index: "guides"
---

Before a process should be enabled to automatically deploy the latest version of an application to a production server, it's a good idea to deploy each release to a different environment and run a series of tests to confirm the application is working as expected.

A common feature of most Ship applications is to include everything necessary to test the application, packaged as a `bash` script. This enables you, the operator, to rely on the operational knowledge that the software vendor has included to ensure each deployment and update is successful.

## Understanding the tests

There are common tools and patterns used when testing an application. But it's nearly impossible to properly test an entire, complex application without a deep understanding of the architecture and how the application works.

To help here, Replicated Ship encourages every application vendor to write a bash script that will be created in `./installer/scripts/test.sh`. This bash script should be the entrypoint to testing the application, once it's deployed to a server. If this script exits with a `0` status code, all tests have passed and it's safe to deploy the version to a production server.

