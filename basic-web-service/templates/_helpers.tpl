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

{{/*
Configures probe paths
*/}}
{{- define "web-service.probesEnabled" -}}
{{- default .Values.probes.liveness.enabled .Values.probes.readiness.enabled }}
{{- end }}

{{- define "web-service.livenessProbePath" -}}
{{- $rawPath := default .Values.probes.path .Values.probes.liveness.path | trim -}}
{{- $fakeUrl := printf "http://example.com%s" $rawPath -}}
{{- with urlParse $fakeUrl -}}
{{- .path -}}
{{- end }}
{{- end }}

{{- define "web-service.readinessProbePath" -}}
{{- $rawPath := default .Values.probes.path .Values.probes.readiness.path | trim -}}
{{- $fakeUrl := printf "http://example.com%s" $rawPath -}}
{{- with urlParse $fakeUrl -}}
{{- .path -}}
{{- end }}
{{- end }}

{{/*
Write probe paths in nginx syntax so that they can be inserted into,
saml-proxy configurations as holes in the proxy,
allowing probes to get through.
*/}}
{{- define "web-service.probeNginxLocations" }}
{{- $livenessPath := include "web-service.livenessProbePath" . -}}
{{- $readinessPath := include "web-service.readinessProbePath" . -}}
{{- if eq $livenessPath $readinessPath -}}
    {{- $livenessPath }}
{{- else -}}
    {{- printf "(%s|%s)" $livenessPath $readinessPath | cat "~" -}}
{{- end -}}
{{- end -}}
