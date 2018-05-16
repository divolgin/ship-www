---
date: "2018-05-01T19:00:00Z"
title: "Managing State"
description: "Best practices to securely store and maange state"
weight: "30003"
gradient: "greenToGreen"
resources:
    - title: "ship_spec.yaml"
      src: "resources/ship_spec.yaml"
    - title: "circle.config"
      src: "resources/circle.config"
---
When a Replicated Ship application is initially configured, a state file is created and stored in `.ship/state.json`. This file contains all generated and manually entered values from the initial setup. When an upgrade is available for the application, the state file is read and applied to the new update. This is a useful way to install application updates.

## Secrets in State

The state file will often contain secrets and confidental information such as database passwords and keys. This file should be stored securely. We recommend encrypting it and storing it on a secure, internal storage location that can be used in a CI/CD workflow to help manage future updates to the application.

## Storing State

A Ship state file is a simple JSON text file. The state file should be accessible to the automation procss that's performing an update. Once an update is generated and deployed, it's important to update the original state file. An application update can generate new values or config automatically, and these will be written to the state file when the update is built.

### Storing State in S3

A private, secured S3 bucket can be used to store the state file, if desired. Before storing a Ship state file in S3, it's recommended to:

1. Enable encryption-at-rest in the bucket properties
1. Encrypt the state file before uploading

An example of downloading, decrypting and then updating a state file in an S3 bucket named `third-party-applications`:

```shell
# Download the state file from S3
$ aws s3 cp s3://third-party-applications/application-name/state.json.enc ./.ship/state.json.enc

# Decrypt the state file
$ openssl enc -d -aes-256-cbc -pass pass:$ENCRYPTION_KEY -in ./.ship/state.json.enc -out ./.ship/state.json

# Ship build phase executes
$ docker run replicated/ship: ...  # Customized ship build command

# Encrypt the updated state file
$ openssl enc -aes-256-cbc -salt -pass pass:$ENCRYPTION_KEY -in ./.ship.state.json -out ./.ship/state.json.enc

# Upload the updated state file to S3
$ aws s3 cp ./.ship/state.json.enc s3://third-party-applications/application-name/state.json
```

### Storing State in GitHub Enterprise

A repository on a GitHub Enterprise server can be used to securely store state files, if they are encrypted before commiting.

An example of including a state file in the repo with the Ship YAML:

```bash
# Clone the repo
$ git clone git@github.com:thirdpartyapps/application-name.git
$ cd application-name

# Decrypt the state file
$ openssl enc -d -aes-256-cbc -a -pass pass:$ENCRYPTION_KEY -in ./.ship/state.json.enc -out ./.ship/state.json

# Ship build phase executes
$ docker run replicated/ship: ...  # Customized ship build command

# Encrypt the updated state file, and base64 encode it
$ openssl enc -aes-256-cbc -a -salt -pass pass:$ENCRYPTION_KEY -in ./.ship/state.json -out ./.ship/state.json.enc

# Add the updated state file and Ship YAML to the repo and commit
$ git add ./.ship/state.json.enc
$ git add ./installer/ship.yml
$ git commit -m "Update my-application release"
$ git push origin master
```
