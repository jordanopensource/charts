# wazuh

![Version: 1.0.3](https://img.shields.io/badge/Version-1.0.3-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 4.8.3](https://img.shields.io/badge/AppVersion-4.8.3-informational?style=flat-square)

A Helm chart for Wazuh the open source security platform that unifies XDR and SIEM protection for endpoints and cloud workloads.

## Getting started

To get started, first install our helm repo

```bash
helm repo add josa https://charts.josa.ngo
helm repo update
```

Once your values.yaml configuration is ready use

**Read the [Configurations notes](#configurations-notes) before installing the chart**

```bash
helm install wazuh josa/wazuh
```

### Configurations notes

#### Release Name

We strongly recommend setting the release name to "wazuh" in order to avoid issues with the manager configuration. The reason for this is that the wazuh manager nodes uses the name "wazuh" by default.

If you want to change the name you will need to provide your own wazuh-manager configuration under `manager.config.customManagerConfig`.

You will need to provide your own `master.conf` and `worker.conf` in your config maps, containing the your release name.

**Example on the release name:**

If your release name is `my-release`, the manager node references in the configuration files should look like:

```yaml
my-release-manager-master-0.my-release-cluster
```

> Make sure that the cluster name matches the release name (my-release in this example)

**Example of the node name under `master.conf` and `worker.conf`:**

```conf
  <cluster>
    <name>my-release</name>
    <node_name>my-release-manager-master</node_name>
    <node_type>master</node_type>
    <key>to_be_replaced_by_cluster_key</key>
    <port>1516</port>
    <bind_addr>0.0.0.0</bind_addr>
    <nodes>
        <node>my-release-manager-master-0.my-release-cluster</node>
    </nodes>
    <hidden>no</hidden>
    <disabled>no</disabled>
  </cluster>
```

You can take a look at our configuration in our templates [here](./configs/wazuh_conf/).

#### TLS

We need to note that TLS is enabled and required at all times in our chart. In order to get this chart working you will need to provide the following tls configuration.

The easiest way, and the one we recommend is that you enable the certification creation in our chart if your cluster has  [cert-manager](https://cert-manager.io/docs/installation/helm/) installed.

If you don't have a cert-manager. You can generate the required certificates and provide them as secrets under `tls.secretName`

The required certificates you will need in your secrets are the following:

- admin-key.pem
- admin.pem
- node-key.pem (referenced in the docs as index-key.pem and indexer.pem)
- node.pem
- root-ca.pem
- server.key
- server.cert
- key.pem
- cert.pem
- filebeat-key.pem
- filebeat.pem

For more information on how to generate these .pem files refer to the [wazuh Deployment kubernets](https://documentation.wazuh.com/current/deployment-options/deploying-with-kubernetes/kubernetes-deployment.html#setup-ssl-certificates)
> You may notice that we did not provide the files dashboard-key.pem and dashboard.pem.
>
>This is because the Wazuh Kubernetes setup uses multiple names for the same certificate. Specifically, it utilizes key.pem and cert.pem alongside dashboard.pem and dashboard-key.pem, even though they refer to the same underlying certificates.
>
>In other words, different names are used interchangeably for the same certificate files across the setup.

## Helpful links

- [Wazuh documentation](https://documentation.wazuh.com/current/deployment-options/deploying-with-kubernetes/index.html)

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
| dashboard.image.tag | string | `"4.8.2"` |  |
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
| indexer.image.tag | string | `"4.8.2"` |  |
| indexer.imagePullSecrets | list | `[]` |  |
| indexer.nodeSelector | object | `{}` |  |
| indexer.podAnnotations | object | `{}` |  |
| indexer.podLabels | object | `{}` |  |
| indexer.podSecurityContext | object | `{}` |  |
| indexer.replicaCount | int | `1` |  |
| indexer.resources | object | `{}` |  |
| indexer.securityContext.capabilities.add[0] | string | `"SYS_CHROOT"` |  |
| indexer.storage.existingClaim | string | `""` |  |
| indexer.storage.size | string | `"25Gi"` |  |
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
| manager.image.tag | string | `"4.8.2"` |  |
| manager.imagePullSecrets | list | `[]` |  |
| manager.master.affinity | object | `{}` |  |
| manager.master.nodeSelector | object | `{}` |  |
| manager.master.podAnnotations | object | `{}` |  |
| manager.master.podLabels | object | `{}` |  |
| manager.master.podSecurityContext.fsGroup | int | `101` |  |
| manager.master.resources | object | `{}` |  |
| manager.master.securityContext.capabilities.add[0] | string | `"SYS_CHROOT"` |  |
| manager.master.storage.existingClaim | string | `""` |  |
| manager.master.storage.size | string | `"25Gi"` |  |
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
| manager.workers.storage.size | string | `"25Gi"` |  |
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
| tls.secretName | string | `""` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
