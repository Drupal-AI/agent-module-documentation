# Logger — manual setup guide

**Logger** (`logger`) is a lightweight, production‑oriented logging backend for
Drupal. Where core writes fairly rigid log records, Logger produces **structured
JSON logs** that include only the fields you want, and — crucially — it lets you
attach **arbitrary custom metadata** to any log entry as a nested data structure.
It has no external library dependencies and works the moment you enable it.

You write logs exactly as you always have: through the standard PSR‑3 logger
interface. To attach structured metadata, you simply pass it under
`$context['metadata']` as a free‑form nested array when you log — no new API to
learn. Logger can also store the *raw* message with its placeholders left
unreplaced, keeping the placeholder values in separate JSON fields, which is handy
for machine parsing.

Logger can write to several destinations: a **file**, **syslog**,
**stdout/stderr**, the **database**, HTTP, and cloud targets, and it is extensible
by plugins for new targets. Out of the box it writes to a JSON‑lines file
(`temporary://drupal-log.jsonl`) so it works on any environment immediately — but
files are not the best choice for production. The recommended production approach
is to write to **stderr**, which a log scraper (Grafana Loki, Fluentd, the ELK
stack, OpenTelemetry, Datadog, and similar) can capture and parse. For local
development and testing, the companion **Logger DB** module lets you store logs in
the SQL database and browse them in the admin panel.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (it works immediately with sensible defaults).
2. [Configuration](configuration/index.md) — choose your log target and tune what
   gets stored, on the Logger settings page.

## Where it lives in the admin menu

Once enabled, Logger's settings form sits at **Configuration → Development →
Logger** (`/admin/config/development/logger`). This is where you change the
default output target away from the temporary file and adjust the other logging
options.

## A word on sensitive data

Log entries — and any custom metadata you attach — can contain sensitive detail.
Avoid logging secrets or personal data, and if you write to a file, place that
file **outside the web root** so it is never web‑servable.
