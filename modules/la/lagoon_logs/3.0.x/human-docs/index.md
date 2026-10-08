# Lagoon Logs — manual setup guide

**Lagoon Logs** (`lagoon_logs`) is a near zero‑configuration logging bridge for
sites hosted on the [Lagoon](https://lagoon.sh) platform (from amazee.io). It takes
every message Drupal writes to its log (the same messages you'd see in the Reports
→ Recent log messages / watchdog) and ships them over UDP to Lagoon's central
Logstash endpoint, formatted as structured Logstash JSON via Monolog.

The point of the module is that on Lagoon it "just works". The defaults already
point at Lagoon's in‑cluster log collector (`application-logs.lagoon.svc:5140`),
and the module automatically tags each record with the project and branch it came
from (read from Lagoon's environment variables), so logs from every project and
feature branch stay distinguishable in the aggregator. Each record also carries
useful request context — IP, request URI, user id, and referring link.

It's designed to be resilient: if the log target is unreachable, the failure is
swallowed so logging never breaks a page request. Because the defaults are meant to
work unchanged inside Lagoon, the settings form is deliberately minimal — it exists
mainly for troubleshooting and for temporarily switching logging off.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the four settings (host, port,
   identifier, disable), the settings form, and the Lagoon environment variables.

## Where it lives in the admin menu

The settings form sits at **Configuration → Development → Lagoon Logs settings**
(`/admin/config/development/lagoon_logs`), gated by the core **Administer site
configuration** permission.

## How to use it

On Lagoon, install and enable the module and you're essentially done — logs start
flowing to Logstash with the built‑in defaults. If you run a custom log collector,
or you're not on Lagoon, point the host and port at your own Logstash endpoint (see
[Configuration](configuration/index.md)). To pause log shipping, tick the **Disable
module** checkbox on the settings form.
