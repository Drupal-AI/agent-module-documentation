# Log Cache Tags — manual setup guide

**Log Cache Tags** (`log_cache_tags`) is a small **development tool** that logs
cache tag activity so you can debug caching and cache-invalidation problems. When
you're chasing why something isn't updating — or updating too often — it helps to
see exactly which cache tags are being invalidated and when. This module writes
those invalidations to Drupal's log so you can watch them happen while you work.

It's deliberately focused: enable the module, flip a toggle, and cache-tag
invalidations start appearing in the database log under the **`log_cache_tags`**
channel in **Reports → Recent log messages**. The toggle matters, because logging
every cache-tag invalidation is verbose — the switch lets you turn it on only while
you're actively investigating (for example the well-known `node:list` invalidation
behavior) and turn it back off so you're not flooding dblog with cache-tag data.

Because it is a debugging aid, keep it to **development and staging** environments.
Logging all cache-tag invalidations is noisy and adds overhead, so it should never
be left switched on in production. It has no content role and no access role of its
own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the on/off toggle and where to read
   the log.

## Where it lives in the admin menu

The toggle is at **Configuration → Log Cache Tags** (`/admin/config/log_cache_tags`).
The resulting entries appear in the database log at **Reports → Recent log
messages** (`/admin/reports/dblog`) under the `log_cache_tags` channel.
