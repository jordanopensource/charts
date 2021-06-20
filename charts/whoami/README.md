whoami
======
Tiny Go webserver that prints os information and HTTP request to output

Current chart version is `0.3.2`

Source code can be found [here](https://github.com/containous/whoami)



## Chart Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"containous/whoami"` |  |
| image.tag | string | `"{{ .Chart.AppVersion }}"` |  |
| ingress.annotations | object | `{}` |  |
| ingress.enabled | bool | `false` |  |
| ingress.hosts[0] | string | `"whoami.localhost"` |  |
| ingress.path | string | `"/"` |  |
| ingress.tls | list | `[]` |  |
| nodeSelector | object | `{}` |  |
| replicaCount | int | `1` |  |
| resources | object | `{}` |  |
| service.port | int | `80` |  |
| service.type | string | `"ClusterIP"` |  |
| tolerations | list | `[]` |  |
