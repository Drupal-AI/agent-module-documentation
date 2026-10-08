# Purge control — manual setup guide

**Purge control** (`purge_control`) adds a pause switch to the Purge pipeline. In
normal editing, Purge does exactly what it should — every entity save queues cache
invalidations that get forwarded to your CDN or Varnish. But during a migration, a
bulk resave, or a large import, that same behavior queues hundreds of thousands of
invalidations in minutes. The consequences range from a rate-limit ban at your CDN
to a cache stampede as the edge refetches everything at once. This module lets you
**pause purging before the bulk operation and resume it afterward** — cleanly, and
without disabling Purge and hoping you remember to turn it back on.

The real value is in automation. Purge control ships **Drush commands** so a
deployment or migration script can pause, do its work, and resume as part of the
job. There is also a settings form for pausing by hand, and an "automation"
option that will re-enable purging on the next cron run if it was left off.

It requires **PHP 8.1+** and **Purge `^3.0.0`**, and runs on Drupal `^10 || ^11`.
One operational caution matters: **invalidations that happen while paused are not
deferred — they are simply skipped.** So plan a full cache clear (an "everything"
invalidation) after resuming, to catch anything that changed during the pause. The
companion **Purge Everything Queuer** module makes that easy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside Purge.
2. [Configuration](configuration/index.md) — the pause/automation settings form
   and the Drush commands for scripting.

## Where it lives in the admin menu

The settings form sits at **Configuration → Development → Performance → Purge →
Purge control** (`/admin/config/development/performance/purge/purge-control`),
behind the **Administer site configuration** permission.
