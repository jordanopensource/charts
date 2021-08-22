# Uptime-Kuma

A fancy self-hosted monitoring tool.

Chart version : 1.0.0

Default Uptime-Kuma image [here](https://github.com/louislam/uptime-kuma)

Current Uptime-Kuma image version: [1.3.2](https://github.com/louislam/uptime-kuma/releases/tag/1.3.2)


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
$ helm install my-release josa/uptime-kuma
```

These commands deploy Uptime-Kuma on the Kubernetes cluster in the default configuration. The [Values](#values) section lists the parameters that can be configured during installation.


## Uninstalling the Chart

To uninstall/delete the `my-release` release:

```console
$ helm delete my-release
```

## Enviroment Variables

See `values.yaml` for available enviroment variables. 


## Values

The following tables lists the configurable parameters of the Uptime-Kuma chart and their default values per section/component:


### Deployment values

| Parameter             | Description                                               | Default                                           |
|-----------------------|-----------------------------------------------------------|---------------------------------------------------|
| `imagePullSecrets`    | Docker registry secret names as an array                  | `[]`                                              |
| `nameOverride`        | String to partially override uptime-kuma.fullname         | `nil`                                             |
| `fullnameOverride`    | String to fully override uptime-kuma.fullname             | `nil`                                             |
| `image.repository`    | Uptime-Kuma image                                         | `louislam/uptime-kuma`                            |
| `image.tag`           | Uptime-Kuma image tag                                     | `""` (defaults to chart appVersion if empty)      |
| `image.pullPolicy`    | Uptime-Kuma image pull policy                             | `IfNotPresent`                                    |
| `replicaCount`        | Number of Uptime-Kuma replicas to deploy                  | `1`                                               |
| `affinity`            | Affinity for pod assignment                               | `{}` (evaluated as a template)                    |
| `nodeSelector`        | Node labels for pod assignment                            | `{}` (evaluated as a template)                    |
| `tolerations`         | Tolerations for pod assignment                            | `[]` (evaluated as a template)                    |
| `podAnnotations`      | Annotations for Uptime-Kuma pods                          | `{}` (evaluated as a template)                    |
| `podSecurityContext`  | Uptime-Kuma pods' Security Context                        | `{}` (evaluated as a template)                    |
| `securityContext`     | Uptime-Kuma containers' Security Context                  | `{}` (evaluated as a template)                    |
| `resources`           | The resources for the Uptime-Kuma container               | `{}` (evaluated as a template)                    |
| `env`                 | Environment variables to configure Uptime-Kuma container  | `{}` (evaluated as a configMap)                   |
| `secretNamesForEnv`   | Array of secrets names contaning extra env vars           | `[]`                                              |


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

| Name                            | Description                                                                                               | Default           |
| --------------------------------|-----------------------------------------------------------------------------------------------------------|-------------------|
| `persistence.enabled`           | Enable persistence                                                                                        | `true`            |
| `persistence.accessMode`        | Access mode to the PV                                                                                     | `[ReadWriteOnce]` |
| `persistence.storageClass`      | Storage class to use with the PVC                                                                         | `"-"`             |
| `persistence.existingClaim`     | If you want to reuse an existing claim, you can pass the name of the PVC using the existingClaim variable | `""`              |
| `persistence.size`              | Size for the PV                                                                                           | `4Gi`             |
| `persistence.annotations`       | Annotations for Uptime-Kuma PVC                                                                           | `{}`              |


### RBAC values

| Parameter                     | Description                                                   | Default                                                 |
|-------------------------------|---------------------------------------------------------------|-----------------------------------------------------|
| `serviceAccount.create`       | Enable the creation of a ServiceAccount for Uptime-Kuma pods  | `true`                                              |
| `serviceAccount.name`         | Name of the created ServiceAccount                            | Generated using the `uptime-kuma.fullname` template |
| `serviceAccount.annotations`  | Annotations to add to the service account                     | `{}` (evaluated as a template)                      |


### Other values

| Parameter                                       | Description                             | Default    |
|-------------------------------------------------|-----------------------------------------|------------|
| `autoscaling.enabled`                           | Enable autoscaling for Uptime-Kuma      | `false`    |
| `autoscaling.minReplicas`                       | Minimum number of Uptime-Kuma replicas  | `1`        |
| `autoscaling.maxReplicas`                       | Maximum number of Uptime-Kuma replicas  | `100`      |
| `autoscaling.targetCPUUtilizationPercentage`    | Target CPU utilization percentage       | `80`       |
| `autoscaling.targetMemoryUtilizationPercentage` | Target Memory utilization percentage    | `80`       |
