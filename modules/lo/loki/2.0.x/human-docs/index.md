# Loki — manual setup guide

**Loki** (`loki`) is a **development / chaos‑testing** module. Despite the name,
it is **not** the Grafana Loki log shipper — it's named after the Norse trickster
god, and it lives up to it: when enabled, it randomly returns configurable **5xx
server errors** to selected roles instead of the real page response.

The point is to test how the infrastructure *in front of* Drupal copes when the
origin misbehaves. Its main use case is verifying **CDN and reverse‑proxy
behaviour** — especially `Stale-If-Error` (RFC 5861) configuration, where you want
the proxy to keep serving cached ("stale") content when the origin returns a 5xx.
By making Drupal fail on demand, you can confirm your edge actually does the right
thing, that monitoring fires on 5xx spikes, and that front‑end retry logic holds
up.

Triggering is tightly controlled by several settings that all have to line up: a
master **enable** flag (off by default), a per‑request **percentage chance** of
failure, an optional **time‑of‑day window**, the **roles** affected (anonymous
only by default), and which **5xx status codes** are eligible (500/502/503/504 by
default). Everything is admin‑gated behind a dedicated **Administer Loki**
permission, and Loki's own settings page is always exempt from the chaos, so you
can never lock yourself out.

Because it deliberately breaks responses, **only use it in development, staging,
or a controlled test environment** — never leave it enabled on a production site
serving real users. The module is marked unsupported / no further development
upstream, so treat it as a purpose‑built testing tool.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — turn the chaos on, and set the
   probability, roles, time window, and error codes.

## Where it lives in the admin menu

The settings form is at **Configuration → Development → Loki**
(`/admin/config/development/loki`) and requires the **Administer Loki**
permission. That page is always served normally, even while Loki is injecting
errors elsewhere.
