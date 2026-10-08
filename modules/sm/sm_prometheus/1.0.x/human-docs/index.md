# Symfony Messenger Prometheus — manual setup guide

**Symfony Messenger Prometheus** (`sm_prometheus`) exposes your Symfony Messenger
metrics to **Prometheus**. It provides plugins for the **Prometheus Exporter**
module that surface the statistics recorded by **Symfony Messenger Metrics** —
message queue throughput, failures, and processing timings — in the Prometheus
scrape format.

The problem it solves is production observability. Once these metrics are exposed
to Prometheus, your operations team can scrape them and build **Prometheus /
Grafana dashboards and alerts** around async message processing, giving proper
visibility into how the message bus is performing over time.

It is a monitoring/observability integration only — it has no content or
access-control role of its own. It depends on **Symfony Messenger** (`sm`) and
the **Prometheus Exporter** (`prometheus_exporter`) module, and requires **Drupal
11.3+**. It provides its own permissions. Note the module is **minimally
maintained** and is **not covered by Drupal's security advisory policy**, so
weigh that before relying on it.

This guide is written for a **human** installing the module. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

Once enabled, the module registers its metric plugins with the Prometheus
Exporter, so the Symfony Messenger statistics appear on the exporter's metrics
endpoint. Point your Prometheus server at that endpoint to scrape them, then
visualise or alert on them in Grafana. Because the numbers come from Symfony
Messenger Metrics, make sure that module is installed and collecting data. When
exposing a metrics endpoint, treat access to it the way you would any operational
endpoint — restrict who can reach it.
