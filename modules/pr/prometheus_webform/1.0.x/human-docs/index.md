# Prometheus Exporter - Webform — manual setup guide

**Prometheus Exporter - Webform** (`prometheus_webform`) is an add-on for the
[Prometheus Exporter](https://www.drupal.org/project/prometheus_exporter) module
that publishes **per-webform submission totals** as a Prometheus metric, so you can
graph and alert on form activity in Grafana or any Prometheus-based stack.

It is deliberately tiny: it registers a single metrics collector,
`webform_submissions`, which builds a Prometheus **gauge** named
`<namespace>_total` with one value per webform, labelled `webform="<webform_id>"`,
taken from each webform's total number of results. It adds **no endpoint of its
own** — the metrics are surfaced through the parent Prometheus Exporter module's
`/metrics` endpoint.

The data it exposes is **aggregate counts only** — how many submissions each
webform has, not the submission field values. Still, submission volumes can be
operationally sensitive, so make sure the parent exporter's `/metrics` endpoint is
protected (see below).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside Prometheus Exporter and Webform.
2. [Configuration](configuration/index.md) — enable the collector and confirm the
   parent `/metrics` endpoint is protected.

## Where it lives in the admin menu

This add-on has no settings page of its own. You enable and disable its collector
on the **Prometheus Exporter settings form**, and the metrics appear on the
exporter's `/metrics` endpoint. See [Configuration](configuration/index.md).
