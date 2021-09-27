{{/*
Expand the name of the chart.
*/}}
{{- define "mailman.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "mailman.fullname" -}}
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
Create mailman core fullname
*/}}
{{- define "mailman.core.fullname" -}}
{{ include "mailman.fullname" . }}-core
{{- end }}

{{/*
Create mailman web fullname
*/}}
{{- define "mailman.web.fullname" -}}
{{ include "mailman.fullname" . }}-web
{{- end }}

{{/*
Create mailman postfix fullname
*/}}
{{- define "mailman.postfix.fullname" -}}
{{ include "mailman.fullname" . }}-postfix
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "mailman.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "mailman.labels" -}}
helm.sh/chart: {{ include "mailman.chart" . }}
{{ include "mailman.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "mailman.selectorLabels" -}}
app.kubernetes.io/name: {{ include "mailman.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Selector labels for mailman core
*/}}
{{- define "mailman.core.selectorLabels" -}}
app.kubernetes.io/name: {{ include "mailman.core.fullname" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Selector labels for mailman web
*/}}
{{- define "mailman.web.selectorLabels" -}}
app.kubernetes.io/name: {{ include "mailman.web.fullname" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Selector labels for mailman postfix
*/}}
{{- define "mailman.postfix.selectorLabels" -}}
app.kubernetes.io/name: {{ include "mailman.postfix.fullname" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}


{{/*
Create the name of the service account to use
*/}}
{{- define "mailman.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "mailman.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
