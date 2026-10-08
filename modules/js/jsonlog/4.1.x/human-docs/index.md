# JSON Log — manual setup guide

**JSON Log** (`jsonlog`) writes every Drupal log (watchdog) event, at or above a
severity you choose, as a single JSON object per line — either to a timestamped
log file or to STDOUT. That structured, one‑object‑per‑line format is exactly what
log pipelines like ELK / Logstash, Graylog, Loki, or a SIEM want to ingest, and
STDOUT output is ideal for Docker / Kubernetes where the platform collects the
container's output stream.

It runs *alongside* core's database log (dblog) rather than replacing it: the
module registers a PSR‑3 logger service that receives all log events, drops the
ones below your severity threshold or outside your channel whitelist, and serializes
the rest. Each JSON entry is rich with request context — a millisecond‑precision
`@timestamp`, a unique `message_id`, `site_id`, log channel, severity,
`request_uri`, `method`, `referer`, `client_ip`, and `uid` — so entries are easy to
filter, correlate, and deduplicate downstream.

A distinctive feature is that **every setting can be overridden by a
`drupal_<setting>` environment variable** (for example `drupal_jsonlog_dir` or
`drupal_jsonlog_stdout`), which wins over the stored config and greys out the
matching form field. That makes it a good fit for 12‑factor / per‑environment
configuration where each environment sets its own log directory, site id, or output
mode without changing site config.

Unlike most modules, JSON Log has no settings page of its own — its options are
injected into **core's** *Logging and errors* form. It adds no permissions and no
Drush commands; access uses core's *Administer site configuration*.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the JSON Log settings on core's
   Logging form, field by field, plus the environment‑variable overrides and how
   to send a test entry.

## Where it lives in the admin menu

JSON Log has no menu item of its own. Its settings appear as a **JSON Log**
section on the core **Configuration → Development → Logging and errors** page
(`/admin/config/development/logging`, route `system.logging_settings`).

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Open **Configuration → Development → Logging and errors** and set the log
   directory (or switch to STDOUT), the severity threshold, rotation, and any tags
   — see [Configuration](configuration/index.md) for each field.
3. Make sure the target log directory is writable by the web server user, then
   tick **Log test entry**, save, and confirm the entry appears at the reported
   file path.
