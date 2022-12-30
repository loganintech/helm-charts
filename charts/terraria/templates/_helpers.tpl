{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "terraria.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "terraria.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "terraria.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
     Return the number representing the world size string
*/}}
{{- define "terraria.worldsize" -}}
{{- if contains "large" .Values.terraria.world.worldsize }}
{{- printf "3" }}
{{- else if contains "medium" .Values.terraria.world.worldsize }}
{{- printf "2" }}
{{- else if contains "small" .Values.terraria.world.worldsize }}
{{- printf "1" }}
{{- end -}}
{{- end -}}

{{/*
     Return the number representing the world difficulty string
*/}}
{{- define "terraria.difficulty" -}}
{{- if contains "normal" .Values.terraria.world.difficulty }}
{{- printf "0" }}
{{- else if contains "expert" .Values.terraria.world.difficulty }}
{{- printf "1" }}
{{- else if contains "master" .Values.terraria.world.difficulty }}
{{- printf "2" }}
{{- else if contains "journey" .Values.terraria.world.difficulty }}
{{- printf "3" }}
{{- end -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "terraria.labels" -}}
app.kubernetes.io/name: {{ include "terraria.name" . }}
helm.sh/chart: {{ include "terraria.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "terraria.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "terraria.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}


{{/*
Create the name of the service account to use
*/}}
{{- define "terraria.worldfile" -}}
"{{ .Values.terraria.world.worldsize }}-{{ .Values.terraria.world.difficulty }}.wld"
{{- end -}}

