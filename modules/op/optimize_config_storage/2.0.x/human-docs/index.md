# Optimize config storage — manual setup guide

**Optimize config storage** (`optimize_config_storage`) is a small performance
module that changes *how* Drupal reads its configuration from the database. Out of
the box, Drupal fetches configuration objects one at a time, issuing a separate SQL
query for each. On a cold cache — for example the first request after a
`drush cr` — a page that reads a lot of small config objects can rack up a lot of
those queries.

This module swaps in a smarter active‑config storage that runs a **single query to
load the whole config table once per request** and then serves every subsequent
config read from an in‑memory map. Writes (saving, renaming, or deleting config)
reset that in‑memory cache so later reads stay consistent. The net effect is far
fewer database round‑trips while Drupal builds its config cache, in exchange for a
little extra request memory to hold the full config set.

It is a **drop‑in with no settings, no routes and no permissions** — you install
it and the swap happens automatically. Because it is an infrastructure‑level change,
it is most useful on sites with a large number of small config objects, and it is
worth benchmarking config‑read performance on your own site before and after, and
validating it under real load before relying on it in production. If you ever want
to revert, simply uninstall it and Drupal returns to core's storage.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it has no settings form,
routes or permissions. The optimisation takes effect the moment the module is
enabled.

## How to use it

There is nothing to configure. Enable the module and Drupal's active config storage
is replaced automatically. After enabling, rebuild caches (`drush cr`) and, if you
want to confirm the benefit, compare the number of config‑read queries on a cold
cache before and after — for example with a query‑logging tool or your APM. To roll
back, uninstall the module.
