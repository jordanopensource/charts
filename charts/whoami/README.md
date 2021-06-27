# Whoami

Whoami is tiny Go webserver that prints os information and HTTP request to output

Chart version : 1.0.0

Default Whoami image [here](https://github.com/containous/whoami)

Current Whoami image version: v1.5.0


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
$ helm install my-release josa/whoami
```

These commands deploy Whoami on the Kubernetes cluster in the default configuration. The [Values](#values) section lists the parameters that can be configured during installation.


## Uninstalling the Chart

To uninstall/delete the `my-release` release:

```console
$ helm delete my-release
```


## Values

The following tables lists the configurable parameters of the Whoami chart and their default values per section/component:


### Deployment values

| Parameter             | Description                                   | Default                                           |
|-----------------------|-----------------------------------------------|---------------------------------------------------|
| `imagePullSecrets`    | Docker registry secret names as an array      | `[]`                                              |
| `nameOverride`        | String to partially override whoami.fullname  | `nil`                                             |
| `fullnameOverride`    | String to fully override whoami.fullname      | `nil`                                             |
| `image.registry`      | Whoami image registry                         | `docker.io`                                       |
| `image.repository`    | Whoami image                                  | `containous/whoami`                               |
| `image.tag`           | Whoami image tag                              | `""` (defaults to chart appVersion if empty)      |
| `image.pullPolicy`    | Whoami image pull policy                      | `IfNotPresent`                                    |
| `replicaCount`        | Number of Whoami replicas to deploy           | `1`                                               |
| `affinity`            | Affinity for pod assignment                   | `{}` (evaluated as a template)                    |
| `nodeSelector`        | Node labels for pod assignment                | `{}` (evaluated as a template)                    |
| `tolerations`         | Tolerations for pod assignment                | `[]` (evaluated as a template)                    |
| `podAnnotations`      | Annotations for Whoami pods                   | `{}` (evaluated as a template)                    |
| `podSecurityContext`  | Whoami pods' Security Context                 | `{}` (evaluated as a template)                    |
| `securityContext`     | Whoami containers' Security Context           | `{}` (evaluated as a template)                    |
| `resources`           | The resources for the Whoami container        | `{}` (evaluated as a template)                    |


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


### RBAC values

| Parameter               | Description                                               | Default                                         |
|-------------------------|-----------------------------------------------------------|-------------------------------------------------|
| `serviceAccount.create` | Enable the creation of a ServiceAccount for Whoami pods   | `true`                                          |
| `serviceAccount.name`   | Name of the created ServiceAccount                        | Generated using the `whoami.fullname` template  |
| `annotations`           | Annotations to add to the service account                 | `{}` (evaluated as a template)                  |


### Other values

| Parameter                                       | Description                          | Default    |
|-------------------------------------------------|--------------------------------------|------------|
| `autoscaling.enabled`                           | Enable autoscaling for Whoami        | `false`    |
| `autoscaling.minReplicas`                       | Minimum number of Whoami replicas    | `1`        |
| `autoscaling.maxReplicas`                       | Maximum number of Whoami replicas    | `100`      |
| `autoscaling.targetCPUUtilizationPercentage`    | Target CPU utilization percentage    | `80`       |
| `autoscaling.targetMemoryUtilizationPercentage` | Target Memory utilization percentage | `80`       |
