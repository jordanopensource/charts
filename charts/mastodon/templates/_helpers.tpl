{{/*
Expand the name of the chart.
*/}}
{{- define "mastodon.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "mastodon.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "mastodon.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "mastodon.labels" -}}
helm.sh/chart: {{ include "mastodon.chart" . }}
{{ include "mastodon.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "mastodon.selectorLabels" -}}
app.kubernetes.io/name: {{ include "mastodon.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "mastodon.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "mastodon.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Whether postgres CA certificate is configured (from Secret or ConfigMap).
*/}}
{{- define "mastodon.postgresCertificateEnabled" -}}
{{- $creds := .Values.postgres.credentials -}}
{{- if and $creds.certificate (or $creds.certificate.secret $creds.certificate.configMap) -}}
true
{{- end -}}
{{- end -}}

{{/*
Postgres CA certificate volume (Secret or ConfigMap). Mount as root.crt in .postgresql.
*/}}
{{- define "mastodon.postgresCertificateVolume" -}}
{{- $c := .Values.postgres.credentials.certificate -}}
{{- if $c.secret -}}
- name: certificates
  secret:
    secretName: {{ $c.secret.name | quote }}
    items:
    - key: {{ default "db-certificate.crt" $c.secret.key | quote }}
      path: root.crt
{{- else if $c.configMap -}}
- name: certificates
  configMap:
    name: {{ $c.configMap.name | quote }}
    items:
    - key: {{ default "ca.crt" $c.configMap.key | quote }}
      path: root.crt
{{- end -}}
{{- end }}
