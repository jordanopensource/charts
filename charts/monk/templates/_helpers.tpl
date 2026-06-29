{{/*
Expand the name of the chart.
*/}}
{{- define "monk.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "monk.fullname" -}}
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
{{- define "monk.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "monk.labels" -}}
helm.sh/chart: {{ include "monk.chart" . }}
{{ include "monk.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "monk.selectorLabels" -}}
app.kubernetes.io/name: {{ include "monk.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "monk.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "monk.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Container image reference.
*/}}
{{- define "monk.image" -}}
{{- printf "%s:%s" .Values.image.repository (.Values.image.tag | default .Chart.AppVersion) -}}
{{- end }}

{{/*
Shared envFrom for the init and main containers.
*/}}
{{- define "monk.envFrom" -}}
- configMapRef:
    name: {{ include "monk.fullname" . }}
{{- if not .Values.existingSecret.enabled }}
- secretRef:
    name: {{ include "monk.fullname" . }}
{{- end }}
{{- end }}

{{/*
Environment variables when using an existing Secret.
*/}}
{{- define "monk.secretEnv" -}}
{{- if .Values.existingSecret.enabled }}
{{- if .Values.existingSecret.adminUsernameKey }}
- name: LISTMONK_app__admin_username
  valueFrom:
    secretKeyRef:
      name: {{ .Values.existingSecret.secretName }}
      key: {{ .Values.existingSecret.adminUsernameKey }}
{{- end }}
{{- if .Values.existingSecret.adminPasswordKey }}
- name: LISTMONK_app__admin_password
  valueFrom:
    secretKeyRef:
      name: {{ .Values.existingSecret.secretName }}
      key: {{ .Values.existingSecret.adminPasswordKey }}
{{- end }}
- name: LISTMONK_db__password
  valueFrom:
    secretKeyRef:
      name: {{ .Values.existingSecret.secretName }}
      key: {{ .Values.existingSecret.databasePasswordKey }}
{{- end }}
{{- end }}
