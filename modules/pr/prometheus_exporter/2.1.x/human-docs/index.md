# Prometheus Exporter — manual setup guide

**Prometheus Exporter** (`prometheus_exporter`) publishes Drupal runtime metrics in
the Prometheus text exposition format at a **`/metrics`** endpoint, so a Prometheus
scraper (and a Grafana dashboard behind it) can graph things like user counts, node
counts per content type, queue sizes, active/anonymous/authenticated session counts,
and PHP runtime info over time.

Exactly *which* metrics are exported is decided by pluggable **metrics collectors**.
The module ships eight built‑in collectors, and — importantly — **every collector is
disabled by default**. A freshly enabled module exports nothing until an
administrator turns collectors on from the settings form, where they can also be
reordered and given per‑collector options (for example which content‑type bundles to
count, or the time window for "active users").

Two things are worth calling out up front about the endpoint:

- **The `/metrics` endpoint is closed by default.** It's gated by the **Access
  Prometheus metrics** permission, which is granted to *no role* out of the box, so
  the endpoint returns 403 until you deliberately open it.
- **Protect it.** Metrics can reveal operational detail — module versions, user and
  session counts, queue backlogs, PHP configuration. Grant the permission only to a
  role your scraper authenticates as, and ideally front the endpoint with a firewall,
  WAF, or basic auth so it isn't exposed to the public internet. Granting the
  permission to the anonymous role publishes all of that publicly, so only do that
  behind network controls.

There's also a `drush prometheus:export` command that prints the same output on the
command line (handy for cron push‑gateways or debugging), and three optional
submodules that add more collectors or alternative access. If you need a metric that
isn't built in, you can add your own by writing a metrics‑collector plugin — see the
[`agent/`](../agent/start.md) docs for the developer details.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and the optional submodules.
2. [Configuration](configuration/index.md) — the settings form, enabling and
   ordering collectors, the `/metrics` endpoint, and securing access.

## Where it lives in the admin menu

The settings form is at **Configuration → System → Prometheus Exporter**
(`/admin/config/system/prometheus_exporter`). The metrics themselves are served at
`/metrics`.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Open the settings form and **enable the collectors** you want, configure their
   options, and set their order (see [Configuration](configuration/index.md)).
3. **Grant access** to the `/metrics` endpoint — give the *Access Prometheus
   metrics* permission to the role your scraper uses, and protect the endpoint at the
   network level.
4. Point your Prometheus server at `https://your-site/metrics`, or run
   `drush prometheus:export` on the CLI to see the output.
