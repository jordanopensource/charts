{{/*
Expand the name of the chart.
*/}}
{{- define "wazuh.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "wazuh.fullname" -}}
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
{{- define "wazuh.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "wazuh.labels" -}}
helm.sh/chart: {{ include "wazuh.chart" . }}
{{ include "wazuh.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "wazuh.selectorLabels" -}}
app.kubernetes.io/name: {{ include "wazuh.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "wazuh.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "wazuh.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create a name for the indexer readiness check init container
*/}}
{{- define "wazuh.indexerReadinessCheck" -}}
- name: wait-for-indexer
  image: curlimages/curl:latest
  command:
    - sh
    - -c
    - |
      until curl -k -u $INDEXER_USERNAME:$INDEXER_PASSWORD "https://$INDEXER_SERVICE:9200/_cluster/health?wait_for_status=green&timeout=50s"; do
        echo "Waiting for indexer to be ready with green status..."
        sleep 10
      done
  env:
    - name: INDEXER_SERVICE
      value: {{ include "wazuh.fullname" . }}-indexer
    - name: INDEXER_USERNAME
      valueFrom:
        secretKeyRef:
          {{- if .Values.manager.config.secrets.existingSecretName }}
          name: {{ .Values.manager.config.secrets.existingSecretName }}
          {{- else }}
          name: {{ include "wazuh.fullname" . }}-manager
          {{- end }}
          key: INDEXER_USERNAME
    - name: INDEXER_PASSWORD
      valueFrom:
        secretKeyRef:
          {{- if .Values.manager.config.secrets.existingSecretName }}
          name: {{ .Values.manager.config.secrets.existingSecretName }}
          {{- else }}
          name: {{ include "wazuh.fullname" . }}-manager
          {{- end }}
          key: INDEXER_PASSWORD
{{- end }}
