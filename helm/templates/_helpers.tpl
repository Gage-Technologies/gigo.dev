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
gigoComponent: core
app.kubernetes.io/name: {{ include "core.name" . }}
{{ include "core.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
gigoComponent: core
{{- end }}

{{/*
Common labels
*/}}
{{- define "ws.labels" -}}
helm.sh/chart: {{ include "core.chart" . }}
gigoComponent: core
app.kubernetes.io/name: {{ include "ws.name" . }}
{{ include "ws.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
gigoComponent: ws
{{- end }}

{{/*
Selector labels
*/}}
{{- define "core.selectorLabels" -}}
gigoComponent: core
app.kubernetes.io/name: {{ include "core.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "ws.selectorLabels" -}}
gigoComponent: ws
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

{{/* SYSTEM CONFIGURATIONS */}}

{{/*
Core misc system config
*/}}
{{- define "core.config.misc" }}
node_id: 0
access_url: http://gigo.gage.intranet/
logger_id: "prod"
stripe_key: "secret://gigo-stripekey"
{{- end }}

{{/*
Core storage system config
*/}}
{{- define "core.config.storage" }}
storage_config:
  engine: s3
  s3:
    bucket: gigo-core
    region: us-east-1
    access_key: gigo
    secret_key: secret://gigo-corebucket
    endpoint: minio
{{- end }}

{{/*
Core http server config
*/}}
{{- define "core.config.http" }}
http_server_config:
  hostname: gigo.gage.intranet
  domain: gage.intranet
  address: "0.0.0.0"
  port: "42069"
  development_mode: true
  git_webhook_secret: "secret://gigo-gitwebhook"
  stripe_webhook_secret: "secret://gigo-stripewebhook"
{{- end }}

{{/*
Core tidb system config
*/}}
{{- define "core.config.tidb" }}
ti_config:
  db_host: "tidb"
  db_port: "4000"
  db_name: "gigo"
  db_user: "gigo"
  db_password: "secret://gigo-tidb"
{{- end }}

{{/*
Core elasticsearch system config
*/}}
{{- define "core.config.elastic" }}
elastic_config:
  elastic_nodes:
    - "elastic"
  elastic_pass: "secret://gigo-elastic"
{{- end }}

{{/*
Core redis system config
*/}}
{{- define "core.config.redis" }}
redis_config:
  redis_nodes:
    - "redis"
  redis_db: 8
  redis_type: "local"
  redis_pass: "secret://gigo-redis"
{{- end }}

{{/*
Core gitea system config
*/}}
{{- define "core.config.gitea" }}
gitea_config:
  host_url: "gitea"
  username: "gigo"
  password: "secret://gigo-gitea"
{{- end }}

{{/*
Core workspace system config
*/}}
{{- define "core.config.ws" }}
ws_config:
  host: ws
  port: 45246
{{- end }}

{{/*
Core derp server config
*/}}
{{- define "core.config.derp" }}
derp:
  server:
    enable: true
{{- end }}

{{/*
Core meili server config
*/}}
{{- define "core.config.meili" }}
meili_config:
  host: meili
  token: secret://gigo-meili
{{- end }}

{{/*
Core meili indices config
*/}}
{{- define "core.config.meiliIndices" }}
indices:
  posts:
    name: posts
    primary_key: _id
    update_config: false
    searchable_attributes:
      - title
      - description
      - author
    filterable_attributes:
      - languages
      - attempts
      - completions
      - coffee
      - views
      - tags
      - post_type
      - visibility
      - created_at
      - updated_at
      - published
      - tier
      - author_id
    sortable_attributes:
      - attempts
      - completions
      - coffee
      - views
      - created_at
      - updated_at
      - tier
      - _id
  users:
    name: users
    primary_key: _id
    update_config: false
    searchable_attributes:
      - user_name
    sortable_attributes:
      - _id
  tags:
    name: tags
    primary_key: _id
    update_config: false
    searchable_attributes:
      - value
    filterable_attributes:
      - official
    sortable_attributes:
      - _id
      - official
  discussion:
    name: discussion
    primary_key: _id
    update_config: false
    searchable_attributes:
      - body
      - author
      - title
    filterable_attributes:
      - author_id
      - created_at
      - updated_at
      - author_tier
      - awards
      - coffee
      - post_id
      - tags
    sortable_attributes:
      - _id
      - created_at
      - updated_at
      - author_tier
      - coffee
  comment:
    name: comment
    primary_key: _id
    update_config: false
    searchable_attributes:
      - body
      - author
    filterable_attributes:
      - author_id
      - created_at
      - author_tier
      - awards
      - coffee
      - discussion_id
      - lead
    sortable_attributes:
      - _id
      - created_at
      - author_tier
      - coffee
      - lead
  thread_comment:
    name: thread_comment
    primary_key: _id
    update_config: false
    searchable_attributes:
      - body
      - author
    filterable_attributes:
      - author_id
      - created_at
      - author_tier
      - awards
      - coffee
      - discussion_id
      - lead
    sortable_attributes:
      - _id
      - created_at
      - author_tier
      - coffee
      - lead
  workspace_configs:
    name: workspace_configs
    primary_key: _id
    update_config: false
    searchable_attributes:
      - title
      - description
      - content
    filterable_attributes:
      - author_id
      - revision
      - official
      - tags
      - languages
    sortable_attributes:
      - _id
      - revision
      - official
{{- end }}
