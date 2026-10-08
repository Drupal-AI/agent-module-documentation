# heartbeat.sh — manual setup guide

**heartbeat.sh** (`heartbeat_sh`) connects Drupal to the
[heartbeat.sh](https://heartbeat.sh/) monitoring service as a **dead-man's
switch** for your cron. On every Drupal cron run, the module sends a "beat" ping
to heartbeat.sh. As long as the beats keep arriving on schedule, all is well — but
if cron stalls and the pings stop, heartbeat.sh notices the silence and raises an
alert. It's the mirror image of ordinary uptime monitoring: instead of watching
for a failure, it watches for the *absence* of a regular signal.

That makes it a neat, infrastructure-free way to know when a scheduled job has
quietly stopped running — a stalled cron queue, a broken scheduler, a server that
went to sleep. You create a "beat" on heartbeat.sh, tell Drupal your account
subdomain and the beat's name, and enable cron beats.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — entering your heartbeat.sh account
   details, setting timeouts, and making sure Drupal cron actually runs.

## Where it lives in the admin menu

Once enabled, its settings form sits at **Configuration → Web services →
heartbeat.sh** (`/admin/config/services/heartbeat_sh/settings_form`), gated by
the **`administer heartbeat_sh`** permission. See
[Configuration](configuration/index.md).

## How it works

When cron runs and beats are enabled, the module makes a single outbound HTTPS
request to `https://<your-subdomain>.heartbeat.sh/beat/<beat-name>`, passing your
warning and error timeouts as query parameters, and logs the response. There are
no public endpoints and nothing anonymous — just the admin form and that
cron-triggered outbound ping. For it to work reliably, Drupal cron must run on a
dependable schedule (a real system cron, not only occasional visitor-triggered
runs).
