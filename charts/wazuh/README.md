# wazuh

![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 4.8.1](https://img.shields.io/badge/AppVersion-4.8.1-informational?style=flat-square)

A Helm chart for Wazuh the open source security platform that unifies XDR and SIEM protection for endpoints and cloud workloads.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| dashboard.affinity | object | `{}` |  |
| dashboard.config.ServerSSL | bool | `true` |  |
| dashboard.config.dashboardCustomConfig | string | `""` | -------------- The configmap name that includes the dashboard custom config file Must have the key 'opensearch_dashboards.yml' |
| dashboard.config.secrets.dashboardPassword | string | `"kibanaserver"` |  |
| dashboard.config.secrets.dashboardUsername | string | `"kibanaserver"` | ----------------- WARN: Those are the default indexer dashboard credentials, do not change unless you changed the passwords and the usernames using the indexerInternalUsersSecretName in the indexer section |
| dashboard.config.secrets.existingSecretName | string | `""` | ----------------- The secret must have the following keys DASHBOARD_USERNAME, DASHBOARD_PASSWORD |
| dashboard.image.pullPolicy | string | `"IfNotPresent"` |  |
| dashboard.image.repository | string | `"wazuh/wazuh-dashboard"` |  |
| dashboard.image.tag | string | `"4.8.1"` |  |
| dashboard.imagePullSecrets | list | `[]` |  |
| dashboard.ingress.annotations | object | `{}` |  |
| dashboard.ingress.className | string | `"nginx"` |  |
| dashboard.ingress.enabled | bool | `false` |  |
| dashboard.ingress.hosts[0].host | string | `"chart-example.local"` |  |
| dashboard.ingress.hosts[0].paths[0].path | string | `"/"` |  |
| dashboard.ingress.hosts[0].paths[0].pathType | string | `"ImplementationSpecific"` |  |
| dashboard.ingress.tls | list | `[]` |  |
| dashboard.livenessProbe.failureThreshold | int | `3` |  |
| dashboard.livenessProbe.httpGet.path | string | `"/"` |  |
| dashboard.livenessProbe.httpGet.port | string | `"dashboard"` |  |
| dashboard.livenessProbe.initialDelaySeconds | int | `60` |  |
| dashboard.livenessProbe.periodSeconds | int | `10` |  |
| dashboard.livenessProbe.successThreshold | int | `1` |  |
| dashboard.livenessProbe.timeoutSeconds | int | `5` |  |
| dashboard.nodeSelector | object | `{}` |  |
| dashboard.podAnnotations | object | `{}` |  |
| dashboard.podLabels | object | `{}` |  |
| dashboard.podSecurityContext | object | `{}` |  |
| dashboard.readinessProbe.failureThreshold | int | `3` |  |
| dashboard.readinessProbe.httpGet.path | string | `"/"` |  |
| dashboard.readinessProbe.httpGet.port | string | `"dashboard"` |  |
| dashboard.readinessProbe.initialDelaySeconds | int | `60` |  |
| dashboard.readinessProbe.periodSeconds | int | `10` |  |
| dashboard.readinessProbe.successThreshold | int | `1` |  |
| dashboard.readinessProbe.timeoutSeconds | int | `5` |  |
| dashboard.replicaCount | int | `1` |  |
| dashboard.resources | object | `{}` |  |
| dashboard.securityContext | object | `{}` |  |
| dashboard.service.port | int | `5601` |  |
| dashboard.service.type | string | `"ClusterIP"` |  |
| dashboard.tolerations | list | `[]` |  |
| dashboard.volumeMounts | list | `[]` |  |
| dashboard.volumes | list | `[]` |  |
| fullnameOverride | string | `""` |  |
| global.indexerUrl | string | `"https://wazuh-indexer:9200"` |  |
| global.wazuhApiUrl | string | `"https://wazuh-master"` |  |
| indexer.affinity | object | `{}` |  |
| indexer.config.indexerCustomConfig | string | `""` |  |
| indexer.config.indexerInternalUsersSecretName | string | `""` |  |
| indexer.config.sslEnabled | bool | `true` |  |
| indexer.image.pullPolicy | string | `"IfNotPresent"` |  |
| indexer.image.repository | string | `"wazuh/wazuh-indexer"` |  |
| indexer.image.tag | string | `"4.8.1"` |  |
| indexer.imagePullSecrets | list | `[]` |  |
| indexer.nodeSelector | object | `{}` |  |
| indexer.podAnnotations | object | `{}` |  |
| indexer.podLabels | object | `{}` |  |
| indexer.podSecurityContext | object | `{}` |  |
| indexer.replicaCount | int | `1` |  |
| indexer.resources | object | `{}` |  |
| indexer.securityContext.capabilities.add[0] | string | `"SYS_CHROOT"` |  |
| indexer.storage.existingClaim | string | `""` |  |
| indexer.storage.size | string | `"1Gi"` |  |
| indexer.storage.storageClassName | string | `""` |  |
| indexer.tolerations | list | `[]` |  |
| indexer.volumeMounts | list | `[]` |  |
| indexer.volumes | list | `[]` |  |
| manager.config.customManagerConfig | string | `""` |  |
| manager.config.filebeatSSLVerificationMode | string | `"none"` |  |
| manager.config.secrets.existingSecretName | string | `""` |  |
| manager.config.secrets.indexerPassword | string | `"SecretPassword"` |  |
| manager.config.secrets.indexerUsername | string | `"admin"` | -----------------  WARN: Those are the default indexer credentials for the wazuh-manager, do not change unless you changed the passwords and the usernames using the indexerInternalUsersSecretName in the indexer section |
| manager.config.secrets.wazuhApiPassword | string | `"Pho8OH1voo6eew@ahVui4Ahghu6leith"` |  |
| manager.config.secrets.wazuhApiUsername | string | `"wazuh"` | ----------------- |
| manager.config.secrets.wazuhAuthDPass | string | `"password"` |  |
| manager.config.secrets.wazuhClusterKey | string | `"123a45bc67def891gh23i45jk67l8mn9"` |  |
| manager.image.pullPolicy | string | `"IfNotPresent"` |  |
| manager.image.repository | string | `"wazuh/wazuh-manager"` |  |
| manager.image.tag | string | `"4.8.1"` |  |
| manager.imagePullSecrets | list | `[]` |  |
| manager.master.affinity | object | `{}` |  |
| manager.master.nodeSelector | object | `{}` |  |
| manager.master.podAnnotations | object | `{}` |  |
| manager.master.podLabels | object | `{}` |  |
| manager.master.podSecurityContext.fsGroup | int | `101` |  |
| manager.master.resources | object | `{}` |  |
| manager.master.securityContext.capabilities.add[0] | string | `"SYS_CHROOT"` |  |
| manager.master.storage.existingClaim | string | `""` |  |
| manager.master.storage.size | string | `"1Gi"` |  |
| manager.master.storage.storageClassName | string | `""` |  |
| manager.master.tolerations | list | `[]` |  |
| manager.master.volumeMounts | list | `[]` |  |
| manager.master.volumes | list | `[]` |  |
| manager.service.annotations | object | `{}` |  |
| manager.service.type | string | `"LoadBalancer"` |  |
| manager.workers.affinity | object | `{}` |  |
| manager.workers.nodeSelector | object | `{}` |  |
| manager.workers.podAnnotations | object | `{}` |  |
| manager.workers.podLabels | object | `{}` |  |
| manager.workers.podSecurityContext.fsGroup | int | `101` |  |
| manager.workers.replicaCount | int | `1` |  |
| manager.workers.resources | object | `{}` |  |
| manager.workers.securityContext.capabilities.add[0] | string | `"SYS_CHROOT"` |  |
| manager.workers.storage.existingClaim | string | `""` |  |
| manager.workers.storage.size | string | `"1Gi"` |  |
| manager.workers.storage.storageClassName | string | `""` |  |
| manager.workers.tolerations | list | `[]` |  |
| manager.workers.volumeMounts | list | `[]` |  |
| manager.workers.volumes | list | `[]` |  |
| nameOverride | string | `""` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.automount | bool | `true` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `""` |  |
| tls.certManager.caCrtSecretName | string | `"node-tls"` |  |
| tls.certManager.commonName | string | `"wazuh.example.com"` |  |
| tls.certManager.dnsNames[0] | string | `"wazuh.example.com"` |  |
| tls.certManager.dnsNames[1] | string | `"www.wazuh.example.com"` |  |
| tls.certManager.duration | string | `"2160h"` |  |
| tls.certManager.enabled | bool | `true` |  |
| tls.certManager.issuer.kind | string | `"ClusterIssuer"` |  |
| tls.certManager.issuer.name | string | `"your-issuer"` |  |
| tls.certManager.renewBefore | string | `"360h"` |  |
| tls.enabled | bool | `true` |  |
| tls.secretName | string | `""` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
