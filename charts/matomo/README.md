# Matomo

Matomo is the leading open alternative to Google Analytics that gives you full control over your data.

Chart version : 1.0.0

Current Matomo version: [4.4.1](https://github.com/matomo-org/matomo/tree/4.4.1)

This chart uses Bitnami Matomo docker [image](https://github.com/bitnami/bitnami-docker-matomo)


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
$ helm install my-release josa/matomo
```

These commands deploy Matomo on the Kubernetes cluster in the default configuration. The [Values](#values) section lists the parameters that can be configured during installation.


## Uninstalling the Chart

To uninstall/delete the `my-release` release:

```console
$ helm delete my-release
```


## Enviroment Variables

See https://github.com/monicahq/matomo/blob/master/.env.example for available enviroment variables. 


## Values

The following tables lists the configurable parameters of the Matomo chart and their default values per section/component:


### Deployment values

| Parameter             | Description                                          | Default                                              |
|-----------------------|------------------------------------------------------|------------------------------------------------------|
| `imagePullSecrets`    | Docker registry secret names as an array             | `[]`                                                 |
| `nameOverride`        | String to partially override matomo.fullname         | `nil`                                                |
| `fullnameOverride`    | String to fully override matomo.fullname             | `nil`                                                |
| `image.repository`    | Matomo image                                         | `matomo`                                             |
| `image.tag`           | Matomo image tag                                     | `3.2-apache` (defaults to chart appVersion if empty) |
| `image.pullPolicy`    | Matomo image pull policy                             | `IfNotPresent`                                       |
| `replicaCount`        | Number of Matomo replicas to deploy                  | `1`                                                  |
| `affinity`            | Affinity for pod assignment                          | `{}` (evaluated as a template)                       |
| `nodeSelector`        | Node labels for pod assignment                       | `{}` (evaluated as a template)                       |
| `tolerations`         | Tolerations for pod assignment                       | `[]` (evaluated as a template)                       |
| `podAnnotations`      | Annotations for Matomo pods                          | `{}` (evaluated as a template)                       |
| `podSecurityContext`  | Matomo pods' Security Context                        | `{}` (evaluated as a template)                       |
| `securityContext`     | Matomo containers' Security Context                  | `{}` (evaluated as a template)                       |
| `resources`           | The resources for the Matomo container               | `{}` (evaluated as a template)                       |
| `env`                 | Environment variables to configure Matomo container  | `{}` (evaluated as a configMap)                      |
| `secretNamesForEnv`   | Array of secrets names contaning extra env vars      | `[]`                                                 |
| `livenessProbe.enabled`             | Enable/disable the liveness probe                                                           | `true` |
| `livenessProbe.initialDelaySeconds` | Delay before liveness probe is initiated                                                    | `60`   |
| `livenessProbe.periodSeconds`       | How often to perform the probe                                                              | `10`   |
| `livenessProbe.timeoutSeconds`      | When the probe times out                                                                    | `1`    |
| `livenessProbe.successThreshold `   |	Minimum consecutive successes for the probe to be considered successful after having failed |	`1`    |
| `livenessProbe.failureThreshold`    | Minimum consecutive failures for the probe to be considered failed after having succeeded   | `3`    |
| `readinessProbe.enabled`            | Enable/disable the readiness probe                                                          | `true` |
| `readinessProbe.initialDelaySeconds`| Delay before readiness probe is initiated                                                   | `60`   |
| `readinessProbe.periodSeconds`      | How often to perform the probe                                                              | `10`   |
| `readinessProbe.timeoutSeconds`     | When the probe times out                                                                    | `1`    |
| `readinessProbe.successThreshold`   | Minimum consecutive successes for the probe to be considered successful after having failed | `1`    |
| `readinessProbe.failureThreshold`   | Minimum consecutive failures for the probe to be considered failed after having succeeded   | `3`    |


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
| `persistence.enabled`           | Enable persistence                                                                                        | `false`           |
| `persistence.accessMode`        | Access mode to the PV                                                                                     | `[ReadWriteOnce]` |
| `persistence.storageClass`      | Storage class to use with the PVC                                                                         | `""`              |
| `persistence.existingClaim`     | If you want to reuse an existing claim, you can pass the name of the PVC using the existingClaim variable | `""`              |
| `persistence.size`              | Size for the PV                                                                                           | `1Gi`             |
| `persistence.annotations`       | Annotations for Matomo PVC                                                                                | `{}`              |


### RBAC values

| Parameter                     | Description                                               | Default                                           |
|-------------------------------|-----------------------------------------------------------|---------------------------------------------------|
| `serviceAccount.create`       | Enable the creation of a ServiceAccount for Matomo pods   | `true`                                            |
| `serviceAccount.name`         | Name of the created ServiceAccount                        | Generated using the `matomo.fullname` template    |
| `serviceAccount.annotations`  | Annotations to add to the service account                 | `{}` (evaluated as a template)                    |


### Other values

| Parameter                                       | Description                          | Default    |
|-------------------------------------------------|--------------------------------------|------------|
| `autoscaling.enabled`                           | Enable autoscaling for Strapi        | `false`    |
| `autoscaling.minReplicas`                       | Minimum number of Strapi replicas    | `1`        |
| `autoscaling.maxReplicas`                       | Maximum number of Strapi replicas    | `100`      |
| `autoscaling.targetCPUUtilizationPercentage`    | Target CPU utilization percentage    | `80`       |
| `autoscaling.targetMemoryUtilizationPercentage` | Target Memory utilization percentage | `80`       |


### MySQL values

| Parameter                     | Description               | Default     |
|-------------------------------|---------------------------|-------------|
| `mysql.enabled`               | Enable MySQL deployment   | `true`      |
| `mysql.auth.rootPassword`     | MySQL root password       | `""`        |
| `mysql.auth.database`         | MySQL database name       | `"matomo"`  |
| `mysql.auth.username`         | MySQL database username   | `"matomo"`  |
| `mysql.auth.password`         | MySQL database password   | `"secret"`  |


## Database connection

This Matomo chart contains a bundled MySQL as subchart which is enabled by default using the `mysql.enabled=true` value. To further customize this deployment modify the values under `mysql`.

To see the full configuration for this subchart check https://github.com/bitnami/charts/tree/master/bitnami/mysql#parameters 

### Use a remote database

To use a remote MySQL database set `mysql.enabled=false` and set the database enviroment variables:

```
DB_HOST:
DB_PORT:
DB_DATABASE:
DB_USERNAME:
DB_PASSWORD:
```
