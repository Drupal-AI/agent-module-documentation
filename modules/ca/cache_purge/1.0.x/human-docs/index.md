# Cache Purge — manual setup guide

**Cache Purge** (`cache_purge`) stops Drupal's database cache tables from growing
without limit. On busy sites the `cache_*` tables (render cache, dynamic page cache,
and so on) can swell to gigabytes, bloating the database and its backups. Cache
Purge watches how large those tables get and, when one crosses a megabyte limit you
set, truncates it to reclaim the space.

The size check and the purge run on **cron**. On each cron run the module lists the
cache tables, measures each one, and empties any that are over your configured
threshold. There is nothing to do by hand once it is set up — as long as cron runs
regularly, oversized cache tables get trimmed automatically.

This is useful mainly where the database has limited space: shared database hosts,
size quotas, or sites whose backups have grown unwieldy because of huge cache
tables. It complements — rather than replaces — Drupal's own cache lifetime
settings.

The module works on Drupal 9 and 10.

This guide is written for a **human** working through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — set the size limit that triggers a
   purge.

## Where it lives in the admin menu

Cache Purge's settings form sits at **Configuration → System → Cache Purge**
(`/admin/config/system/cache-purge`). Reaching it requires the core **Administer
site configuration** permission.

## How to use it

Enable the module, open the settings form, and set the megabyte threshold at which a
cache table should be purged. From then on, each cron run measures the cache tables
and truncates any that exceed the limit — no further action needed.
