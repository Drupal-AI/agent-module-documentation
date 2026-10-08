# Monolog Loki — manual setup guide

**Monolog Loki** (`monolog_loki`) sends your Drupal logs to
**[Grafana Loki](https://grafana.com/oss/loki/)** — a horizontally scalable
log-aggregation backend — through the
[Monolog](https://www.drupal.org/project/monolog) module. Once wired up, your
Drupal log records are pushed to a Loki endpoint where they can be stored,
queried with LogQL, and explored alongside your other observability data in
Grafana.

It's an operations/logging integration and depends on the Monolog module.
Unlike some Monolog "glue" modules, Monolog Loki lets you configure the Loki
connection and labels **either in the admin UI or in `settings.php`** — so you
can manage it through the browser during setup and still override sensitive
values from code or environment in production.

Because this ships logs to an **external endpoint**, keep the security basics in
mind: logs can contain sensitive data (user identifiers, request detail, and
occasionally secrets if code logs them), so use an **authenticated, TLS (HTTPS)**
Loki endpoint, store any Loki credentials as secrets, and practise good log
hygiene. The module plays no access-control role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Monolog.
2. [Configuration](configuration/index.md) — set the Loki push URL, credentials,
   and labels, and wire the handler into Monolog.

## Where it lives in the admin menu

Monolog Loki adds a settings form for the Loki connection and labels; the
credentials and labels can also be set in `settings.php`. See
[Configuration](configuration/index.md) for how to reach the form and what each
field does.
