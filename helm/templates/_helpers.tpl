{{/*
Expand the name of the chart.
*/}}
{{- define "core.name" -}}
gigo-core
{{- end }}

{{/*
Expand the name of the chart.
*/}}
{{- define "ws.name" -}}
gigo-ws
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "core.fullname" -}}
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
{{- define "core.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "core.labels" -}}
helm.sh/chart: {{ include "core.chart" . }}
gigo/component: core
app.kubernetes.io/name: {{ include "core.name" . }}
{{ include "core.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
gigo/component: core
{{- end }}

{{/*
Common labels
*/}}
{{- define "ws.labels" -}}
helm.sh/chart: {{ include "core.chart" . }}
gigo/component: ws
app.kubernetes.io/name: {{ include "ws.name" . }}
{{ include "ws.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
gigo/component: ws
{{- end }}

{{/*
Selector labels
*/}}
{{- define "core.selectorLabels" -}}
gigo/component: core
app.kubernetes.io/name: {{ include "core.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "ws.selectorLabels" -}}
gigo/component: ws
app.kubernetes.io/name: {{ include "ws.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "core.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "core.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Core ingress wildcard hostname with the wildcard suffix stripped.
*/}}
{{- define "core.ingressWildcardHost" -}}
{{/* This regex replace is required as the original input including the suffix
   * is not a legal ingress host. We need to remove the suffix and keep the
   * wildcard '*'.
   *
   *   - '\\*'     Starts with '*'
   *   - '[^.]*'   Suffix is 0 or more characters, '-suffix'
   *   - '('       Start domain capture group
   *   -   '\\.'     The domain should be separated with a '.' from the subdomain
   *   -   '.*'      Rest of the domain.
   *   - ')'       $1 is the ''.example.com'
   */}}
{{- regexReplaceAll "\\*[^.]*(\\..*)" .Values.core.ingress.wildcardHost "*${1}" -}}
{{- end }}

