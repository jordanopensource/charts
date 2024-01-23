# JOSA Helm Charts for Kubernetes

Popular applications, provided by [JOSA](https://josa.ngo), ready to launch on Kubernetes using [Kubernetes Helm](https://helm.sh).

## TL;DR

```bash
$ helm repo add josa https://charts.josa.ngo
$ helm search repo josa
$ helm install my-release josa/<chart>
```

### Prerequisites
- Kubernetes 1.20+
- Helm 3+

### Setup a Kubernetes Cluster

For setting up Kubernetes refer to the Kubernetes [getting started guide](http://kubernetes.io/docs/getting-started-guides).

### Install Helm

Helm is a tool for managing Kubernetes charts. Charts are packages of pre-configured Kubernetes resources.

To install Helm, refer to the [Helm install guide](https://helm.sh/docs/intro/install).

### Add Repo

The following command allows you to download and install all the charts from this repository:

```bash
$ helm repo add josa https://charts.josa.ngo
```

### Using Helm

Once you have installed the Helm client, you can deploy a JOSA Helm Chart into a Kubernetes cluster.

Please refer to the [Quick Start guide](https://helm.sh/docs/intro/quickstart/) if you wish to get running in just a few commands, otherwise the [Using Helm Guide](https://helm.sh/docs/intro/using_helm/) provides detailed instructions on how to use the Helm client to manage packages on your Kubernetes cluster.

Useful Helm Client Commands:
* View available charts: `helm search repo`
* Install a chart: `helm install my-release josa/<package-name>`
* Upgrade your application: `helm upgrade`


### License
