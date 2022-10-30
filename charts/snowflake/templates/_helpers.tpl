{{/*
Expand the name of the chart.
*/}}
{{- define "snowflake.name-web" -}}
{{- default .Chart.Name .Values.web.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- define "snowflake.name-proxy" -}}
{{- default .Chart.Name .Values.proxy.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "snowflake.fullname-web" -}}
{{- if .Values.web.fullnameOverride }}
{{- .Values.web.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.web.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{- define "snowflake.fullname-proxy" -}}
{{- if .Values.proxy.fullnameOverride }}
{{- .Values.proxy.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.proxy.nameOverride }}
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
{{- define "snowflake.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "snowflake.labels-web" -}}
helm.sh/chart: {{ include "snowflake.chart" . }}
{{ include "snowflake.selectorLabels-web" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "snowflake.labels-proxy" -}}
helm.sh/chart: {{ include "snowflake.chart" . }}
{{ include "snowflake.selectorLabels-proxy" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "snowflake.selectorLabels-web" -}}
app.kubernetes.io/name: {{ include "snowflake.name-web" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "snowflake.selectorLabels-proxy" -}}
app.kubernetes.io/name: {{ include "snowflake.name-proxy" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "snowflake.serviceAccountName-web" -}}
{{- if .Values.web.serviceAccount.create }}
{{- default (include "snowflake.fullname-web" .) .Values.web.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.web.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "snowflake.serviceAccountName-proxy" -}}
{{- if .Values.proxy.serviceAccount.create }}
{{- default (include "snowflake.fullname-proxy" .) .Values.proxy.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.proxy.serviceAccount.name }}
{{- end }}
{{- end }}
