# Cron Time — manual setup guide

**Cron Time** (`cron_time`) lets an administrator set a custom interval for
Drupal's automated cron. Out of the box, core offers a fixed list of run intervals
on its Cron settings page; Cron Time gives you control over how frequently
automated cron fires so you can match it to what your site actually needs.

It's a simple administration/performance setting with no content or access-control
role — all it changes is *when* cron runs. Set it more frequently if you have
time-sensitive work (queues, indexing, scheduled publishing) that shouldn't wait;
set it less frequently to reduce background load. Two things to keep in mind: an
interval that is too infrequent can delay scheduled tasks such as search indexing
and cleanup, and if you disable automatic cron altogether you must then trigger
cron externally (a system cron job hitting Drupal's cron URL or `drush cron`).

The module works across Drupal 9, 10, and 11 and has no other dependencies.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — set the custom cron interval on the
   core Cron settings page.

## Where it lives in the admin menu

Cron Time doesn't add a separate page — it extends the core Cron settings form at
**Configuration → System → Cron** (`/admin/config/system/cron`), where you'll find
its custom-interval control.
