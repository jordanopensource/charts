# Statping

Status Page for monitoring your websites and applications with beautiful graphs, analytics, and plugins.

Chart version : 1.0.0

Default Statping image [here](https://github.com/statping/statping)

Current Statping image version: [v0.90.74](https://github.com/statping/statping/tree/v0.90.74)


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
$ helm install my-release josa/statping
```

These commands deploy Statping on the Kubernetes cluster in the default configuration. The [Values](#values) section lists the parameters that can be configured during installation.


## Uninstalling the Chart

To uninstall/delete the `my-release` release:

```console
$ helm delete my-release
```


## Values

The following tables lists the configurable parameters of the Statping chart and their default values per section/component:


### Deployment values

| Parameter             | Description                                            | Default                                           |
|-----------------------|--------------------------------------------------------|---------------------------------------------------|
| `imagePullSecrets`    | Docker registry secret names as an array               | `[]`                                              |
| `nameOverride`        | String to partially override statping.fullname         | `nil`                                             |
| `fullnameOverride`    | String to fully override statping.fullname             | `nil`                                             |
| `image.repository`    | Statping image                                         | `statping/statping`                               |
| `image.tag`           | Statping image tag                                     | `""` (defaults to chart appVersion if empty)      |
| `image.pullPolicy`    | Statping image pull policy                             | `IfNotPresent`                                    |
| `replicaCount`        | Number of Statping replicas to deploy                  | `1`                                               |
| `affinity`            | Affinity for pod assignment                            | `{}` (evaluated as a template)                    |
| `nodeSelector`        | Node labels for pod assignment                         | `{}` (evaluated as a template)                    |
| `tolerations`         | Tolerations for pod assignment                         | `[]` (evaluated as a template)                    |
| `podAnnotations`      | Annotations for Statping pods                          | `{}` (evaluated as a template)                    |
| `podSecurityContext`  | Statping pods' Security Context                        | `{}` (evaluated as a template)                    |
| `securityContext`     | Statping containers' Security Context                  | `{}` (evaluated as a template)                    |
| `resources`           | The resources for the Statping container               | `{}` (evaluated as a template)                    |
| `env`                 | Environment variables to configure Statping container  | `{}` (evaluated as a configMap)                   |
| `secretNamesForEnv`   | Array of secrets names contaning extra env vars        | `[]`                                              |


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

| Name                            | Description                                                                                               | Value             |
| --------------------------------|-----------------------------------------------------------------------------------------------------------|-------------------|
| `persistence.enabled`           | Enable persistence                                                                                        | `true`            |
| `persistence.accessMode`        | Access mode to the PV                                                                                     | `[ReadWriteOnce]` |
| `persistence.storageClass`      | Storage class to use with the PVC                                                                         | `""`             |
| `persistence.existingClaim`     | If you want to reuse an existing claim, you can pass the name of the PVC using the existingClaim variable | `""`              |
| `persistence.size`              | Size for the PV                                                                                           | `1Gi`             |
| `persistence.annotations`       | Annotations for Statping PVC                                                                              | `{}`              |


### RBAC values

| Parameter                     | Description                                               | Default                                           |
|-------------------------------|-----------------------------------------------------------|---------------------------------------------------|
| `serviceAccount.create`       | Enable the creation of a ServiceAccount for Statping pods | `true`                                            |
| `serviceAccount.name`         | Name of the created ServiceAccount                        | Generated using the `statping.fullname` template  |
| `serviceAccount.annotations`  | Annotations to add to the service account                 | `{}` (evaluated as a template)                    |


### Other values

| Parameter                                       | Description                          | Default    |
|-------------------------------------------------|--------------------------------------|------------|
| `autoscaling.enabled`                           | Enable autoscaling for Strapi        | `false`    |
| `autoscaling.minReplicas`                       | Minimum number of Strapi replicas    | `1`        |
| `autoscaling.maxReplicas`                       | Maximum number of Strapi replicas    | `3`      |
| `autoscaling.targetCPUUtilizationPercentage`    | Target CPU utilization percentage    | `80`       |
| `autoscaling.targetMemoryUtilizationPercentage` | Target Memory utilization percentage | `80`       |
