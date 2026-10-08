# Warmer — manual setup guide

**Warmer** (`warmer`) is a framework for **cache warming** — pre‑fetching
expensive caches so they are already populated before a real visitor triggers
them. Instead of the first person after a deployment or cache clear paying the
cost of a cold cache, Warmer enqueues items in batches and processes them ahead of
time, so pages, entities, or CDN edges stay hot.

On its own, Warmer ships **no warmers** — it provides the plumbing: a `warmer`
plugin type, a shared settings object where every warmer stores its **frequency**
(how often to re‑warm) and **batch size**, a reliable queue, a cron hook that
re‑enqueues warmers whose frequency window has elapsed, and Drush commands. Two
submodules provide the actual warmers you'll use:

- **Entity warmer** (`warmer_entity`) — warms the entity cache for selected entity
  types and bundles, with an optional "published only" filter.
- **CDN warmer** (`warmer_cdn`) — issues HTTP GET requests to warm edge/Varnish/
  page caches, either from an explicit list of URLs or from one or more XML
  sitemaps, with custom headers, SSL‑verification control, and a concurrency
  limit.

You can warm on a schedule (via cron and per‑warmer frequency), on demand from the
"Warm caches" admin form, or from the command line as a post‑deploy step — for
example `drush warmer:enqueue cdn,entity --run-queue`. Warmer has no permissions of
its own; its admin pages are gated by the core **Administer site configuration**
permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and pick the warmer submodules you need.
2. [Configuration](configuration/index.md) — the settings form, per‑warmer
   options, manual warming, cron, and the Drush commands.

## Where it lives in the admin menu

Warmer adds a **Cache warming** menu link under **Configuration → Development**:

- **Settings:** `/admin/config/development/warmer/settings` — configure each
  warmer.
- **Warm caches (manual):** `/admin/config/development/warmer` — enqueue selected
  warmers now.

## How to use it

Enable Warmer plus at least one submodule (Entity and/or CDN), configure the
warmers on the settings form, and let cron re‑warm them on a schedule — or trigger
a warm manually from the form or Drush. See
[Configuration](configuration/index.md) for the details.
