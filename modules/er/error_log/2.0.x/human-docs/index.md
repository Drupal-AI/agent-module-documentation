# Error Log — manual setup guide

**Error Log** (`error_log`) registers PHP's own `error_log()` function as a Drupal
logger. In plain terms: it makes Drupal's log messages reappear in the **same web
server error log, stderr, or syslog** that PHP was already writing to before
Drupal even bootstrapped. If you'd rather read Drupal's logs alongside your Apache
or nginx errors — or ship them to a log aggregator that tails the PHP error log —
this is the module that gets them there.

It's a lightweight logger with no external service dependency, and it happily runs
*alongside* core's Database Logging (dblog) or Syslog modules — Drupal supports
several loggers at once. Because it writes through PHP's `error_log()`, it can even
keep an error trail when the database is unavailable. Where those lines physically
land is decided by PHP's `error_log` ini directive, not by Drupal.

You control which messages get through and how each line looks: toggle exactly
which severities are logged, ignore noisy channels (like 404 "page not found" or
403 "access denied"), and customize the log line with a set of placeholders. The
module requires **Drupal 11.1+ / 12**, has no dependencies beyond core, and adds
no permissions, routes, or Drush commands of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — the severities, ignored channels, and
   line‑format options (added to core's Logging and errors page), field by field.

## Where it lives in the admin menu

There is no settings page of its own. The module adds an **Error Log** section to
core's **Logging and errors** form at **Configuration → Development → Logging and
errors** (`/admin/config/development/logging`), which needs the **Administer site
configuration** permission.

## How to use it

Once enabled, Drupal log messages start flowing to PHP's error log automatically —
there's nothing you *must* configure. From then on it's about tuning: on the
**Logging and errors** page you can silence debug/info noise in production, add
chatty channels to the ignore list, and shape each log line to match an existing
log‑parsing pipeline. See [Configuration](configuration/index.md) for each option.

> **Heads‑up:** core itself calls `error_log()` for some fatal errors, so a few
> messages may appear twice — once from core and once from this module.
