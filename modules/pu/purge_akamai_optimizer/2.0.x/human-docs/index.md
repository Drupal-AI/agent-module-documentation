# Purge Akamai Optimizer — manual setup guide

**Purge Akamai Optimizer** (`purge_akamai_optimizer`) sits on top of the **Purge**
and **Akamai** modules to make cache‑tag purging efficient at CDN scale. Akamai
imposes limits on its edge cache‑tag header — a maximum length (8192 characters)
and a cap on the number of tags per page — and on a large Drupal site those
limits are easy to hit. This module solves that by hashing and reducing the set
of cache tags before they're sent, so invalidations stay within Akamai's limits.

Its main jobs are:

- **Hashing cache tags** into short (5‑character) identifiers, so the edge
  cache‑tag header stays under the 8192‑character limit.
- **Reducing the number of tags** on a page (Akamai caps this around 128) by
  collapsing tags that match configured **prefixes** into a single identifier,
  and sending the right replacement tags at purge time.
- **Tracking priority tags** and cleaning up old identifier records via cron.
- Adding a **site identifier** tag to every HTML page, plus a file identifier,
  which enables an **"Akamai purge everything"** purger for full‑cache
  invalidation.
- Optionally **disabling Akamai caching** when you need to.

This is purely a performance/operations layer — it processes no untrusted input
and its only user‑facing surface is an admin settings form. Note it doesn't talk
to Akamai directly: the actual API calls (and your Akamai credentials) live in
the **Akamai** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Purge/Akamai dependencies.
2. [Configuration](configuration/index.md) — the optimizer settings, plus where
   your Akamai credentials belong and how to store them securely.

## Where it lives in the admin menu

After enabling, the settings form sits at **Configuration → Akamai → Purge
Akamai Optimizer settings**
(`/admin/config/akamai/purge-akamai-optimizer-settings`) and requires the
**Administer Akamai** permission. Because this module builds on Purge and Akamai,
most of your setup is actually in *those* modules — see
[Configuration](configuration/index.md).
