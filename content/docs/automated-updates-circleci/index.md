---
date: "2018-05-01T19:00:00Z"
title: "Automated Updates with CircleCI"
description: "Automated Updates with CircleCI"
weight: "30003"
icon: "replicatedCircleCI"
gradient: "greenToGreen"
resources: 
    - title: "ship_spec.yaml"
      src: "resources/ship_spec.yaml"
    - title: "circle.config"
      src: "resources/circle.config"
---
CircleCI (and CircleCI Enterprise) workflows can be used to automatically deploy updates to a Ship application when there's an update available.

This document will walk through setting up an automated process to update an already-deployed Ship application whenever an update is available. The end result here is two environments running the application; one for testing and validation, and one for production. The process defined here will automatically deploy to the test environment, and then deploy to production when the tests pass.

The following workflow will be created in CircleCI:

1. On commit (updated Ship YAML), a build will start
1. CircleCI will download the state from a GitHub Enterprise repository, and decrypt it
1. CircleCI will pull the `replicated/ship` container image
1. The new release will be built
1. The release will be deployed to a test environmnet
1. Vendor supplied tests will be run against the test environment
1. Once validated, the production release will be updated

## Prepare the CircleCI build environment

The CircleCI build environment will need to have access to some secrets. Add the following secrets into the CircleCI project settings:

1. STATE_ENCRYPTION_KEY. This variable will be used to encrypt the state file before storing in a GitHub Enterprise repository
1. CUSTOMER_ID. This variable is static, and supplied by the application vendor.
1. Credentials needed to deploy the application. In this case, it's a Kubernetes application, so credentials to log in to the cluster using `kubectl`.

## Download and descrypt state

## Pull the latest Ship container

## Build the latest release

## Deploy to a test envrionment

## Execute tests

## Deploy to the production environment


```yaml
defaults: &defaults
  docker:
    - image: replicated/ship:1
  working_directory: ~/repo

version: 2
jobs:
  configure:
    <<: *defaults
    steps:
      - checkout

      - run:
          name: fetch state
          command: s3 cli download && descrypt

      - run:
          name: connfigure
          command: ship ...

      - store_test_results:
          path: results

      - persist_to_workspace:
          root: ~/repo
          paths:
            - ./.ship/state.json
            - ./installer

workflows:
  version: 2
  btd:
    jobs:
      - configure
      - build_test:
          requires:
            - configure
      - deploy_to_test:
          requires:
            - build_test
      - test_test:
          requires:
            - deploy_to_test
      - build_prod:
          requires:
            - test_test
      - deploy_to_prod:
          requires:
            - build_prod
      - test_prod:
          requires:
            - deploy_to_prod
```