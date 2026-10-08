# LSCache — manual setup guide

**LSCache** (`lscache`) is a Drupal‑native integration for **LiteSpeed Cache**. If
your site runs on LiteSpeed Web Server (LSWS), OpenLiteSpeed, or a LiteSpeed PaaS
host, LiteSpeed can serve a full‑page cache in front of Drupal so that most
requests never reach PHP at all. But to do that safely it needs two things from
Drupal: it needs to know each response's cache lifetime (TTL) and which **Drupal
cache tags** it carries, and it needs a signal to drop cached pages the moment the
underlying content changes. This module provides both.

On every cacheable response, LSCache attaches the `X-LiteSpeed-Cache-Control`
(TTL) and `X-LiteSpeed-Tag` (Drupal cache tags) headers, so LiteSpeed caches each
page keyed by the same cache tags Drupal already uses (`node:42`, `user:7`, and so
on). The bundled **LSCache Purger** submodule then plugs into the
[Purge](https://www.drupal.org/project/purge) framework so that a node edit or
config save issues a tag‑scoped PURGE and LiteSpeed drops every cached response
carrying that tag — keeping the cache fresh automatically.

One crucial point: **emitting the headers does nothing on its own.** LiteSpeed
only consults its cache when you add a `CacheLookup public on` directive to your
`.htaccess`. The module ships Status‑report checks that tell you whether the
required directives, PURGE host, and host/scheme settings are correct.

Version 1.3.x adds several advanced capabilities: **private (per‑user) caching**
of authenticated pages (BigPipe‑ and drupalSettings‑aware, so it doesn't break
AJAX for logged‑in users), **vary‑by‑cookie** support, a **Host‑header override**,
a **URL/tag/auto PURGE strategy** for LiteSpeed builds that silently ignore
tag‑based PURGE, **ESI fragments** so a per‑user chunk can stay per‑user inside an
otherwise shared page, and Drush diagnostics (`lscache:diag`,
`lscache:list-tag-coverage`).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, add the
   `.htaccess` block, and enable the module (and the purger).
2. [Configuration](configuration/index.md) — the main settings, the purger, and
   the advanced options, field by field.

## Where it lives in the admin menu

The main settings form is at **Configuration → Development → Performance →
LSCache** (`/admin/config/development/performance/lscache`) and requires the
**Administer LSCache** permission. The purger's settings (once the
`lscache_purger` submodule is enabled) live at
`/admin/config/development/performance/lscache/purger`.
