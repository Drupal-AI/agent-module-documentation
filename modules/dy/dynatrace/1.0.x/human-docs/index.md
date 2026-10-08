# Dynatrace — manual setup guide

**Dynatrace** (`dynatrace`) connects your Drupal site to
[Dynatrace](https://www.dynatrace.com/), a commercial application performance
monitoring (APM) platform. It does two related things: it **surfaces the current
Dynatrace OneAgent trace context** (trace id, span id, and whether the trace is
valid) on an admin page so you can line up a Drupal request with its trace during
debugging, and it provides an **API for posting your own custom application
metrics** — gauges and counts — to Dynatrace's metric ingest endpoint, so business
signals like "orders placed" or "queue depth" can land on your Dynatrace
dashboards.

It's an integration module, so how much it does depends on what's available in your
environment. The **trace‑info** page only shows meaningful data when the Dynatrace
**OneAgent PHP extension** is installed on the server; without it, the page simply
reports that OneAgent isn't configured. The **metric ingest** side needs a Dynatrace
environment (tenant) and an API token, which you supply in the module's settings.
Pushing metrics themselves is done from your own code, typically wired to cron or
domain events.

Because it talks to a third‑party service, two cautions matter up front. First, the
**Dynatrace API token is a secret** — treat it like a password (see Installation for
how to store it safely). Second, this creates **outbound traffic to Dynatrace**:
metric payloads (and, via OneAgent, trace/host context) leave your infrastructure
for Dynatrace's, so make sure that egress and the data it carries are acceptable
under your privacy and data‑handling policies, and that the ingest URL points at
your own Dynatrace tenant over HTTPS. The module requires **PHP 8.1** and Drupal
9.4 or 10.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and store the API token securely.
2. [Configuration](configuration/index.md) — enter your Dynatrace environment and
   token, and view the trace‑info page.

## Where it lives in the admin menu

Settings live at **Configuration → Development → Dynatrace**
(`/admin/config/development/dynatrace`), and the trace‑info page at
`/admin/config/development/dynatrace/trace-info`. Both require the dedicated
**Administer Dynatrace** permission.
