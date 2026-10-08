# Cache Debug — manual setup guide

**Cache Debug** (`cache_debug`) is a developer aid that **logs cache tags** so you can see
what Drupal is caching and what is being cleared. It records two things independently: the
**cache tags of each cacheable response**, and the **cache tags as they are invalidated**
(including invalidations triggered from the command line by Drush). That makes it much
easier to answer "why is this page cached / not cached?" and "which tag cleared this
page?".

Where those logs go is up to you. Cache Debug uses a small plugin system with three
built‑in sinks — a **File** (written under `private://cache_debug` by default), the
**Drupal logger channel** (watchdog), and **Sentry** (via the Raven module) — and you pick
one for responses and one for invalidations. New sinks can be added by writing a
`CacheDebugLogger` plugin.

You configure it on a settings form; until you choose loggers it does nothing. Cache tags
are internal identifiers (like `node:1` or `config:system.site`), not user data, and the
module writes them only to the sink you choose — **never** to HTTP response headers, and it
exposes no public route beyond the permission‑gated settings form. So it does not leak
cache internals to anonymous users or in production headers by default. The main
operational care is to keep the file log under the **private** scheme (the default) and to
**disable the loggers when you are not actively debugging** — this is a development/staging
tool.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module.
2. [Configuration](configuration/index.md) — choose the response and invalidated loggers
   and set the file log path.

## Where it lives in the admin menu

The settings form is at **Configuration → Development → Cache Debug**
(`/admin/config/development/cache-debug`, route `cache_debug.admin.settings`), gated by the
**Configure cache debug** permission.

## How to use it

Enable the module in a development or staging environment, open the settings form, and pick
a **response logger** and an **invalidated logger**. Then browse the site (or run the Drush
commands you want to trace) and read the chosen sink — the log file, the Drupal log, or
Sentry — to see the cache tags being set and cleared. Set both loggers back to *none* when
you are done.
