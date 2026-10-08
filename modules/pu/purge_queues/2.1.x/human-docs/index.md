# Purge queue with unique items — manual setup guide

**Purge queue with unique items** (`purge_queues`) is an add‑on for the
[Purge](https://www.drupal.org/project/purge) module that fixes a well‑known
annoyance: the Purge queue filling up with duplicate cache‑invalidation items. On a
busy site, the same URL or cache tag can get queued for purging over and over — a
bursty content save can pile thousands of identical tag purges into the queue,
bloating the database and wasting time and bandwidth when they're processed against
your reverse proxy or CDN. This module adds smarter queue backends that keep each
invalidation in the queue only once.

It provides three queue plugins that slot into Purge's existing queue layer:

- **Database (extended)** (`database_alt`) — works like Purge's built‑in database
  queue, but also stores each item's invalidation type and expression in their own
  columns, making the queue queryable (handy for debugging). No deduplication on its
  own.
- **Database unique** (`database_unique`) — builds on the extended queue and checks
  for a matching item before inserting, so the same type + expression is never
  queued twice.
- **Database unique (upsert)** (`database_unique_upsert`) — achieves the same
  deduplication more efficiently using a hashed key and an SQL "upsert", so
  re‑queuing the same invalidation is a single write. This is the best choice for
  high‑churn sites.

Switching to one of these is a drop‑in change: you just select the queue in Purge's
own settings, and nothing else about your purgers, processors, or queuers needs to
change. The module has no admin UI, permissions, config schema, or Drush commands of
its own — it purely contributes queue options to Purge.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There's no page of its own. You select the active queue on Purge's configuration
page at **Configuration → Development → Performance → Purge**
(`/admin/config/development/performance/purge`).

## How to use it

1. Make sure the Purge module is installed and configured for your CDN/reverse
   proxy, then enable this module (see [Installation](installation/index.md)).
2. Go to **Configuration → Development → Performance → Purge**.
3. In the **Queue** section, change the queue engine to **Database unique** or
   **Database unique (upsert)** (or **Database (extended)** if you only want the
   extra queryable columns without deduplication).
4. Save. From now on the Purge queue deduplicates its items — the same invalidation
   won't be queued twice.

For repeatable deployments you can set the queue in configuration instead. The
choice is stored by Purge itself in `purge.plugins:queue`; the cleanest way to set
it programmatically is through Purge's own API so the runtime queue is
reinitialised:

```php
\Drupal::service('purge.queue')->setPluginsEnabled(['database_unique_upsert']);
```

You can confirm which queue is active with:

```bash
drush php:eval 'print current(\Drupal::service("purge.queue")->getPluginsEnabled());'
```

which prints `database` by default, or the plugin id you selected.
