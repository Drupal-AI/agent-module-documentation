# Log Stdout — manual setup guide

**Log Stdout** (`log_stdout`) sends every Drupal log message to the process's
**standard output** stream (`php://stdout`), and optionally warnings and errors to
**standard error** (`php://stderr`). That is exactly what container platforms
expect: with this module enabled, `docker logs` shows your Drupal log messages,
and Kubernetes, Fluentd, Loki, or any log collector that reads a container's
stdout/stderr picks them up automatically — no database table, no log file, no
syslog daemon required.

This is the standard "12-factor" logging approach for Docker, Kubernetes, and
other cloud-native hosting, where logs are treated as an event stream on the
container's output rather than something written to disk. It is especially handy on
read-only container filesystems, or when you want to keep log writes out of the
database on a high-traffic site.

Importantly, Log Stdout **adds** a log destination alongside Drupal's existing
loggers — it does not replace the core Database Logging (dblog) or Syslog modules.
Every logged event still reaches them too; if you want database logging off, you
uninstall dblog separately. You control which events are emitted (a minimum
severity threshold), how each log line is formatted, and whether warnings/errors
are diverted to stderr.

This guide is written for a **human** setting up logging on a containerised site.
If you want terse, token-cheap references for an AI coding agent — the config keys,
placeholders, and the service internals — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

Its settings are few, so they are described below rather than on a separate page.

## Where it lives in the admin menu

The settings form is at **Configuration → Development → Log Stdout**
(`/admin/config/development/log_stdout`), available to users with the **Administer
site configuration** permission.

## How to use it

Once the module is enabled, logging to stdout starts working immediately with
sensible defaults — there is nothing you *must* configure. To tune it, open
**Configuration → Development → Log Stdout** and adjust:

- **Format** (`format`) — the template for each log line. It supports placeholders
  including `@severity` (the level name), `@type` (the log channel), `@date`,
  `@message`, `@uid`, `@request_uri`, `@referer`, `@ip`, and `@link`. Unknown
  placeholders are left as-is, and an empty format falls back to the shipped
  default. A simple message-only template might be `[@severity] @type: @message`.
- **Use stderr** (`use_stderr`, default on) — when on, events at **Warning
  severity or worse** are written to `php://stderr`; everything less severe
  (Info, Notice, Debug) still goes to `php://stdout`. Turn it off to send
  everything to stdout. Orchestrators can then alert on the stderr stream for
  critical events.
- **Severity level** (`severity_level`, default **Error**) — the *minimum* severity
  that gets emitted. This is an RFC5424 level from 0 (Emergency) to 7 (Debug); an
  event is written only when it is at least this severe. Lower it toward Debug (7)
  during development to capture everything, or keep it at Error (3) in production
  to cut noise.

Changes take effect immediately — the logger re-reads its settings on every event,
so you do not need to rebuild caches.

### Setting it from the command line

You can also configure it with Drush, which is convenient in a container build:

```bash
drush cset -y log_stdout.settings severity_level 7          # log down to Debug
drush cset -y log_stdout.settings use_stderr 1              # warnings+ to stderr
drush cset -y log_stdout.settings format '[@severity] @type: @message'
```

> **Note on config schema:** due to a shipped quirk, the module's config schema
> file labels the object as `syslog.settings` rather than `log_stdout.settings`, so
> `log_stdout.settings` is effectively schema-less at runtime. When setting values
> directly, store `severity_level` as an integer and `use_stderr` as the string
> `'0'` or `'1'`, matching what the code expects. The [`agent/`](../agent/start.md)
> docs cover this in detail.
