# Drone-Runner-Kube

The Drone Kubernetes runner launches builds in Kubernetes Jobs.

Chart version : 1.0.0

Default Drone-Runner-Kube image [here](https://github.com/drone-runners/drone-runner-kube)

Current Drone-Runner-Kube image version: [1.0.0-beta.8](https://github.com/drone-runners/drone-runner-kube/tree/v1.0.0-beta.8)


## Prerequisites
- Kubernetes 1.20
- Helm 3+


## Installing the Chart

Add JOSA's chart repository to Helm:

```console
$ helm repo add josa https://charts.josa.ngo
$ helm repo update
```

Install the chart with the release name `my-release`:

```console
$ helm install my-release josa/drone-runner-kube
```

These commands deploy Drone-Runner-Kube on the Kubernetes cluster in the default configuration. The [Values](#values) section lists the parameters that can be configured during installation.


## Uninstalling the Chart

To uninstall/delete the `my-release` release:

```console
$ helm delete my-release
```

## Enviroment Variables

See `values.yaml` for available enviroment variables. 


## Values

The following tables lists the configurable parameters of the Drone-Runner-Kube chart and their default values per section/component:


### Deployment values

| Parameter                       | Description                                                           | Default                                       |
|---------------------------------|-----------------------------------------------------------------------|-----------------------------------------------|
| `imagePullSecrets`              | Docker registry secret names as an array                              | `[]`                                          |
| `nameOverride`                  | String to partially override drone-runner-kube.fullname               | `nil`                                         |
| `fullnameOverride`              | String to fully override drone-runner-kube.fullname                   | `nil`                                         |
| `image.repository`              | Drone-Runner-Kube image                                               | `drone/drone-runner-kube`                     |
| `image.tag`                     | Drone-Runner-Kube image tag                                           | `""` (defaults to chart appVersion if empty)  |
| `image.pullPolicy`              | Drone-Runner-Kube image pull policy                                   | `IfNotPresent`                                |
| `replicaCount`                  | Number of Drone-Runner-Kube replicas to deploy                        | `1`                                           |
| `affinity`                      | Affinity for pod assignment                                           | `{}` (evaluated as a template)                |
| `nodeSelector`                  | Node labels for pod assignment                                        | `{}` (evaluated as a template)                |
| `tolerations`                   | Tolerations for pod assignment                                        | `[]` (evaluated as a template)                |
| `podAnnotations`                | Annotations for Drone-Runner-Kube pods                                | `{}` (evaluated as a template)                |
| `podSecurityContext`            | Drone-Runner-Kube pods' Security Context                              | `{}` (evaluated as a template)                |
| `securityContext`               | Drone-Runner-Kube containers' Security Context                        | `{}` (evaluated as a template)                |
| `resources`                     | The resources for the Drone-Runner-Kube container                     | `{}` (evaluated as a template)                |
| `env`                           | Environment variables to configure Drone-Runner-Kube container        | `{}` (evaluated as a configMap)               |
| `secretNamesForEnv`             | Array of secrets names contaning extra env vars                       | `[]`                                          |
| `terminationGracePeriodSeconds` | Time is seconds to wait after a runner pod receives a SIGTERM/SIGINT  | `3600`                                        |


### Exposure values

| Parameter                             | Description                                      | Default                        |
|---------------------------------------|--------------------------------------------------|------------------------------- |
| `service.type`                        | Kubernetes service type                          | `ClusterIP`                    |
| `service.port`                        | Service HTTP port                                | `80`                           |
| `ingress.enabled`                     | Enable ingress controller resource               | `false`                        |
| `ingress.annotations`                 | Ingress annotations                              | `{}` (evaluated as a template) |
| `ingress.className`                   | Ingress className                                | `""`                           |
| `ingress.hosts`                       | Hosts array for the ingress resource             | `[]`                           |
| `ingress.hosts[0].host`               | Host for the ingress resource                    | `[]`                           |
| `ingress.hosts[0].paths`              | paths array for the ingress resource host        | `[]`                           |
| `ingress.hosts[0].paths[0].path`      | Ingress path                                     | `/`                            |
| `ingress.hosts[0].paths[0].pathType`  | Ingress path type                                | `ImplementationSpecific`       |
| `ingress.tls`                         | TLS configuration for the hosts                  | `[]`                           |
| `ingress.tls[0].hosts`                | Hosts to be covered with the TLS configuration   | `nil`                          |
| `ingress.tls[0].secretName`           | TLS configuration secret name                    | `nil`                          |


### Persistence values

| Name            | Description                                                                                    | Value  |
| ----------------|------------------------------------------------------------------------------------------------|--------|
| `volumes`       | Declare volumes per Pod spec's "volumes" section                                               | `[]`   |
| `volumeMounts`  | If you have declared volumes, mount them here, per the Pod Container's "volumeMounts" section  | `[]`   |


### RBAC values

| Parameter                     | Description                                                     | Default                                                   |
|-------------------------------|-----------------------------------------------------------------|-----------------------------------------------------------|
| `serviceAccount.name`         | Name of the created ServiceAccount                              | Generated using the `drone-runner-kube.fullname` template |
| `serviceAccount.annotations`  | Annotations to add to the service account                       | `{}` (evaluated as a template)                            |
| `rbac.buildNamespaces`        | A Role is created for every namespace we want to run builds in  | `[default]`                                               |


### Other values

| Parameter                                       | Description                          | Default    |
|-------------------------------------------------|--------------------------------------|------------|
| `autoscaling.enabled`                           | Enable autoscaling for Strapi        | `false`    |
| `autoscaling.minReplicas`                       | Minimum number of Strapi replicas    | `1`        |
| `autoscaling.maxReplicas`                       | Maximum number of Strapi replicas    | `100`      |
| `autoscaling.targetCPUUtilizationPercentage`    | Target CPU utilization percentage    | `80`       |
| `autoscaling.targetMemoryUtilizationPercentage` | Target Memory utilization percentage | `80`       |
