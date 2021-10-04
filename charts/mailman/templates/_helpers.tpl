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

{{/*
Define postfix required domain name
*/}}
{{- define "mailman.domainName" -}}
{{- required "Required parameter domainName is missing!" .Values.mailman.domainName }}
{{- end -}}

{{/*
Define postfix required host name
*/}}
{{- define "mailman.hostName" -}}
{{- required "Required parameter mailHostName is missing!" .Values.mailman.hostName -}}
{{- end -}}

{{/*
Define postfix required enviroment variable
*/}}
{{- define "mailman.postfix.env" -}}
- name: MAIL_DOMAIN
  value: {{ include "mailman.domainName" . }}
{{- if .Values.postfix.relay.enabled }}
- name: RELAY_HOST
  value: {{ .Values.postfix.relay.host }}
- name: RELAY_PORT
  value: {{ .Values.postfix.relay.port | quote }}
{{- end }}
- name: SMTP_USER
{{- if .Values.postfix.existingSecret.userAndPasswordKey }}
  valueFrom:
    secretKeyRef:
      name: {{ .Values.postfix.existingSecret.secretName }}
      key: {{ .Values.postfix.existingSecret.userAndPasswordKey }}
{{- else }}
  value: "{{ .Values.postfix.username }}:{{ .Values.postfix.password }}"
{{- end }}
{{- if .Values.postfix.relay.enabled }}
- name: RELAY_USERNAME
{{- if .Values.postfix.relay.existingSecret.userKey }}
  valueFrom:
    secretKeyRef:
      name: {{ .Values.postfix.relay.existingSecret.secretName }}
      key: {{ .Values.postfix.relay.existingSecret.userKey }}
{{- else }}
  value: {{ .Values.postfix.relay.username }}
{{- end }}
- name: RELAY_PASSWORD
{{- if .Values.postfix.relay.existingSecret.passwordKey }}
  valueFrom:
    secretKeyRef:
      name: {{ .Values.postfix.relay.existingSecret.secretName }}
      key: {{ .Values.postfix.relay.existingSecret.passwordKey }}
{{- else }}
  value: {{ .Values.postfix.relay.password }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create the name for the Postgresql service to use.
*/}}
{{- define "mailman.postgresql.fullname" -}}
{{- printf "%s-%s" .Release.Name "postgresql" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create the hostname for the Postgresql service to use.
*/}}
{{- define "mailman.postgresql.host" -}}
{{- if .Values.postgresql.internal }}
{{- include "mailman.postgresql.fullname" . }}-headless:5432
{{- else }}
{{- printf "%s:%s" .Values.postgresql.postgresqlHost .Values.postgresql.postgresqlPort -}}
{{- end -}}
{{- end -}}

{{/*
Define mailman web required enviroment variable
*/}}
{{- define "mailman.web.env" -}}
- name: SERVE_FROM_DOMAIN
  value: {{ include "mailman.domainName" . }}
- name: DJANGO_ALLOWED_HOSTS
  value: {{ include "mailman.web.fullname" . }}
- name: MAILMAN_HOSTNAME
  value: "http://{{ include "mailman.web.fullname" . }}:8000"
- name: POSTORIUS_TEMPLATE_BASE_URL
  value: "http://{{ include "mailman.web.fullname" . }}:8000"
- name: MAILMAN_REST_URL
  value: "http://{{ include "mailman.core.fullname" . }}:8001"
- name: SMTP_HOST_USER
{{- if .Values.postfix.existingSecret.usernameKey }}
  valueFrom:
    secretKeyRef:
      name: {{ .Values.postfix.existingSecret.secretName }}
      key: {{ .Values.postfix.existingSecret.usernameKey }}
{{- else }}
  value: {{ .Values.postfix.username }}
{{- end }}
- name: SMTP_HOST_PASSWORD
{{- if .Values.postfix.existingSecret.passwordKey }}
  valueFrom:
    secretKeyRef:
      name: {{ .Values.postfix.existingSecret.secretName }}
      key: {{ .Values.postfix.existingSecret.passwordKey }}
{{- else }}
  value: {{ .Values.postfix.password | quote }}
{{- end }}
- name: SECRET_KEY
{{- if .Values.mailman.existingSecret.secretKey }}
  valueFrom:
    secretKeyRef:
      name: {{ .Values.mailman.existingSecret.secretName }}
      key: {{ .Values.mailman.existingSecret.secretKey }}
{{- else }}
  value: {{ .Values.mailman.secretKey | quote }}
{{- end }}
- name: MAILMAN_ADMIN_USER
{{- if .Values.mailman.existingSecret.adminUserKey }}
  valueFrom:
    secretKeyRef:
      name: {{ .Values.mailman.existingSecret.secretName }}
      key: {{ .Values.mailman.existingSecret.adminUserKey }}
{{- else }}
  value: {{ .Values.mailman.adminUser | quote }}
{{- end }}
- name: MAILMAN_ADMIN_EMAIL
{{- if .Values.mailman.existingSecret.adminEmailKey }}
  valueFrom:
    secretKeyRef:
      name: {{ .Values.mailman.existingSecret.secretName }}
      key: {{ .Values.mailman.existingSecret.adminEmailKey }}
{{- else }}
  value: {{ .Values.mailman.adminEmail | quote }}
{{- end }}
{{- end }}


{{/*
Define required mailman common (web and core) enviroment variable
*/}}
{{- define "mailman.common.env" -}}
- name: DATABASE_TYPE
  value: postgres
- name: DATABASE_CLASS
  value: "mailman.database.postgresql.PostgreSQLDatabase"
- name: DATABASE_URL
{{- if .Values.postgresql.existingSecret.databaseUrlKey }}
  valueFrom:
    secretKeyRef:
      name: {{ .Values.postgresql.existingSecret.secretName }}
      key: {{ .Values.postgresql.existingSecret.databaseUrlKey }}
{{- else }}
  value: "{{ "postgres://" }}{{ .Values.postgresql.postgresqlUsername }}{{ ":" }}{{ .Values.postgresql.postgresqlPassword }}{{ "@" }}{{ include "mailman.postgresql.host" . }}{{ "/" }}{{ .Values.postgresql.postgresqlDatabase }}"
{{- end }}
- name: HYPERKITTY_URL
  value: "http://{{ include "mailman.web.fullname" . }}:8000/hyperkitty"
- name: HYPERKITTY_API_KEY
{{- if .Values.mailman.existingSecret.apiKey }}
  valueFrom:
    secretKeyRef:
      name: {{ .Values.mailman.existingSecret.secretName }}
      key: {{ .Values.mailman.existingSecret.apiKey }}
{{- else }}
  value: {{ .Values.mailman.apiKey | quote }}
{{- end }}
- name: MTA
  value: postfix
- name: SMTP_HOST
  value: {{ include "mailman.postfix.fullname" . }}
{{- if .Values.postfix.certSecret }}
- name: SMTP_PORT
  value: "587"
- name: SMTP_USE_TLS
  value: "True"
{{- end }}
{{- end }}
