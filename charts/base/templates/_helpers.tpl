{{/*
Create the name of the service account to use
*/}}
{{- define "base.serviceAccountName" -}}
{{- if .Values.workload.serviceAccount.create }}
{{- default (include "base.names.fullname" .) .Values.workload.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.workload.serviceAccount.name }}
{{- end }}
{{- end }}