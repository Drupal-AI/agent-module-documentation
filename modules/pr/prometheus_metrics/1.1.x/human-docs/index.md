# Prometheus Metrics — manual setup guide

**Prometheus Metrics** (`prometheus_metrics`) exposes metrics about your Drupal
site in the **Prometheus text format** through a scrape endpoint, so a Prometheus
monitoring server can collect them — and a tool like Grafana can graph them. Out
of the box you get useful insight: request timings and request counts (broken down
by route, method, and status code) and entity CRUD metrics (creates, updates, and
deletes, by bundle). An optional **Prometheus Metrics: Commerce**
(`prometheus_metrics_commerce`) submodule adds commerce-specific metrics.

By default the endpoint is served at `/metrics` with a metric namespace of
`drupal`, and both are adjustable on the module's settings form. Under the hood
the metrics are collected and rendered with the PromPHP `prometheus_client_php`
library, which supports several storage backends — in-memory (the default), APCu,
or Redis — selected in your `settings.php`.

**The endpoint is protected by default.** Its access checker defaults to requiring
authentication and then the **Access prometheus metrics** permission, so an
anonymous scraper is denied unless you deliberately open it up. That is the safe
posture — metrics can reveal operational detail such as route names and traffic
patterns, so you should keep access as tight as your monitoring setup allows.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and (optionally) the Commerce submodule.
2. [Configuration](configuration/index.md) — the endpoint path and namespace, how
   to protect the endpoint, and how to choose a storage backend.

## Where it lives in the admin menu

The settings form is at **Configuration → System → Prometheus**
(`/admin/config/system/prometheus`), gated by the **Administer site configuration**
permission. The scrape endpoint itself defaults to `/metrics`.
