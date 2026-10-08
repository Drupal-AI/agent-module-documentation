# Monitoring Endpoint — manual setup guide

**Monitoring Endpoint** (`monitoring_endpoint`) exposes a single JSON API
endpoint — **`/monitoring/status`** — that external monitoring tools can poll to
read the results of your site's [Monitoring](https://www.drupal.org/project/monitoring)
sensors (and, where present, Ultimate Cron job statuses). The response is a
machine-readable summary — a count of critical failures plus the status of each
enabled sensor — designed to drop straight into tools like Uptime Kuma, Nagios or
Icinga, or any custom script that can parse JSON.

The endpoint is meant to be reached without a Drupal login (a monitoring probe has
no session), so access is gated by a **token** passed as a query parameter:
`/monitoring/status?token=YOUR-TOKEN`, matched against a configured
`endpoint_key`. Each sensor reports a standard status — `OK`, `WARNING`,
`CRITICAL` or `INFO` — and results are uncached by default so monitors always see
real-time data.

This module needs one piece of configuration before use: **set an endpoint key
after enabling it.** It depends on the Monitoring module and requires PHP 8.1.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — set the endpoint key, point your
   monitor at the endpoint, and lock it down.

## Where it lives in the admin menu

The settings form is a simple configuration UI restricted to users with the
**Administer site configuration** permission (you can also configure the endpoint
directly in `settings.php`). Once configured, the JSON is served at
**`/monitoring/status?token=YOUR-TOKEN`**.

## Set the key before use

The first thing to do after enabling this module is set a strong endpoint key.
Serve the endpoint only over **HTTPS** and treat the token as a
bearer secret. Full steps are in [Configuration](configuration/index.md).
