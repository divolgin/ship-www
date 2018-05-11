

# A Ship Application Lifecycle

A Replicated Ship application is designed to be installed, updated and operated in a workflow that's compatible with modern devops best practices.

When installing or updating an application, there are 4 phases that are available to any application.

// TODO image
Configure -> Build -> Deploy -> Test

## Configure

The configure phase is the time that all required user-supplied, generated and detected values are supplied to the Ship environment. This can be performed using the web-based Admin Console, a previously generated state file, or supplied in the environment.

## Build

The build phase is when the `replicated/ship` container applies the configured inputs to the applications YAML manifest, and generates all required assets. Assets include text files, scripts, docker containers, secrets and anhything else required by the application.

## Deploy

Once the build phase is complete, the application can be deployed using the vendor-supplied ./installer/scripts/install.sh script, or by manually deploying the application, following the instructions provided. The deploy phase can be run from an automation tool such as Ansible, Chef or Puppet, or can be executed as part of a CI/CD workflow.

## Test

After the application is deployed to any environment (test or production), the application can be tested using the vendor-supplied ./installer/scripts/test.sh script.
