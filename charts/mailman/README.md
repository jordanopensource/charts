# Mailman

Mailman is free software for managing electronic mail discussion and e-newsletter lists.

Mailman version: [`3.3.5`](https://gitlab.com/mailman/mailman/-/tree/3.3.5)

This chart uses [`maxking/docker-mailman:0.4.1`](https://github.com/maxking/docker-mailman/tree/v0.4.1)


## Prerequisites
- Kubernetes 1.20+
- Helm 3+


## Installing the Chart

Add JOSA's chart repository to Helm:

```console
$ helm repo add josa https://charts.josa.ngo
$ helm repo update
```

Install the chart with the release name `my-release`:

```console
$ helm install my-release josa/mailman
```

These commands deploy Mailman on the Kubernetes cluster in the default configuration. The [Values](#values) section lists the parameters that can be configured during installation.


## Uninstalling the Chart

To uninstall/delete the `my-release` release:

```console
$ helm delete my-release
```

## Values
