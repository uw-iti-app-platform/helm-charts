{{/*
Expand the name of the chart.
*/}}
{{- define "web-service.name" -}}
{{- default .Chart.Name .Values.app.name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "web-service.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "web-service.labels" -}}
helm.sh/chart: {{ include "web-service.chart" . }}
{{ include "web-service.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "web-service.selectorLabels" -}}
app.kubernetes.io/name: {{ include "web-service.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
