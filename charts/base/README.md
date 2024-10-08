# base

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![AppVersion: 0.1.0](https://img.shields.io/badge/AppVersion-0.1.0-informational?style=flat-square)

A general helm chart for any container

**Homepage:** <https://josa.ngo>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| Jordan open source association |  | <https://github.com/jordanopensource/charts/> |

## Source Code

* <https://github.com/jordanopensource/charts/tree/main/charts/base>

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| commonAnnotations | object | `{}` |  |
| commonLabels | object | `{}` |  |
| fullnameOverride | string | `""` |  |
| nameOverride | string | `""` |  |
| namespaceOverride | string | `""` |  |
| workload.affinity | object | `{}` |  |
| workload.autoscaling.enabled | bool | `false` |  |
| workload.autoscaling.maxReplicas | int | `100` |  |
| workload.autoscaling.minReplicas | int | `1` |  |
| workload.autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| workload.autoscaling.targetMemoryUtilizationPercentage | int | `80` |  |
| workload.env | list | `[]` |  |
| workload.envFrom | list | `[]` |  |
| workload.image.pullPolicy | string | `"IfNotPresent"` |  |
| workload.image.repository | string | `"REPOSITORY_NAME/DOCKER_IMAGE_NAME"` |  |
| workload.image.tag | string | `""` |  |
| workload.imagePullSecrets | list | `[]` |  |
| workload.ingress.annotations | object | `{}` |  |
| workload.ingress.className | string | `""` |  |
| workload.ingress.enabled | bool | `false` |  |
| workload.ingress.hosts[0].host | string | `"chart-example.local"` |  |
| workload.ingress.hosts[0].paths[0].path | string | `"/"` |  |
| workload.ingress.hosts[0].paths[0].pathType | string | `"ImplementationSpecific"` |  |
| workload.ingress.tls | list | `[]` |  |
| workload.initContainers | list | `[]` |  |
| workload.livenessProbe.httpGet.path | string | `"/"` |  |
| workload.livenessProbe.httpGet.port | string | `"http"` |  |
| workload.nodeAffinityPreset.key | string | `""` |  |
| workload.nodeAffinityPreset.type | string | `""` |  |
| workload.nodeAffinityPreset.values | list | `[]` |  |
| workload.nodeSelector | object | `{}` |  |
| workload.persistence.accessModes[0] | string | `"ReadWriteOnce"` |  |
| workload.persistence.annotations | object | `{}` |  |
| workload.persistence.datasource | object | `{}` |  |
| workload.persistence.enabled | bool | `false` |  |
| workload.persistence.existingClaim | string | `""` |  |
| workload.persistence.labels | object | `{}` |  |
| workload.persistence.path | string | `"/test"` |  |
| workload.persistence.persistentVolumeClaimRetentionPolicy.enabled | bool | `false` |  |
| workload.persistence.persistentVolumeClaimRetentionPolicy.whenDeleted | string | `"Retain"` |  |
| workload.persistence.persistentVolumeClaimRetentionPolicy.whenScaled | string | `"Retain"` |  |
| workload.persistence.selector | object | `{}` |  |
| workload.persistence.size | string | `"8Gi"` |  |
| workload.persistence.storageClass | string | `""` |  |
| workload.persistence.subPath | string | `""` |  |
| workload.podAffinityPreset | string | `""` |  |
| workload.podAnnotations | object | `{}` |  |
| workload.podAntiAffinityPreset | string | `"soft"` |  |
| workload.podLabels | object | `{}` |  |
| workload.podSecurityContext | object | `{}` |  |
| workload.readinessProbe.httpGet.path | string | `"/"` |  |
| workload.readinessProbe.httpGet.port | string | `"http"` |  |
| workload.replicaCount | int | `1` |  |
| workload.resources | object | `{}` |  |
| workload.resourcesPreset | string | `"micro"` |  |
| workload.securityContext | object | `{}` |  |
| workload.service.annotations | object | `{}` |  |
| workload.service.port | int | `3000` |  |
| workload.service.type | string | `"ClusterIP"` |  |
| workload.serviceAccount.annotations | object | `{}` |  |
| workload.serviceAccount.automount | bool | `true` |  |
| workload.serviceAccount.create | bool | `true` |  |
| workload.serviceAccount.name | string | `""` |  |
| workload.sideCars | list | `[]` |  |
| workload.tolerations | list | `[]` |  |
| workload.type | string | `"Deployment"` |  |
| workload.volumeMounts | list | `[]` |  |
| workload.volumes | list | `[]` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
