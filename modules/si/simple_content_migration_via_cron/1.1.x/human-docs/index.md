# Migrate content via cron jobs — manual setup guide

**Migrate content via cron jobs** (`simple_content_migration_via_cron`) runs
Migrate API migrations automatically during Drupal's cron runs, each on its own
schedule, so imports happen unattended instead of being kicked off by hand with
Drush or the migrate UI.

Normally you run a migration when you remember to. This module lets you list one
or more migration machine names in configuration, give each an interval, and let
cron re‑run them when that interval has elapsed. Per‑migration flags mirror the
familiar Drush options: `update` re‑imports rows that were already migrated, and
`sync` deletes destination items that have disappeared from the source. It keeps a
`<key>_next_execution` timestamp for each migration so a job only runs again once
enough time has passed, and it skips a configured name safely if that migration no
longer exists, so a stale entry will not break cron.

The module depends on **Migrate Plus** (`migrate_plus`). It ships an example SQL
source plugin (`content_migration`) that reads a legacy `products` table (title,
sku, price, valid_date, keyed by sku) into a Drupal `product` content type, plus a
matching example migration you can copy and adapt. There is **no admin settings
form** — everything is configured in your site's `settings.php` (the external
source database connection and the migration schedule), so this is a
developer/operator tool rather than a point‑and‑click one.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer alongside Migrate
   Plus, enable both, and register your source database in `settings.php`.
2. [Configuration](configuration/index.md) — the `settings.php` migration schedule
   block, field by field, and how the example migration fits in.

## How to use it

Once your source database and migration schedule are in `settings.php` and cron is
running, the module drives your migrations on its own. Each cron run checks every
listed migration, and any whose interval has elapsed is forced to idle and then
imported. You define the actual migrations yourself (typically as Migrate Plus
config entities) and simply list their machine names in the module's config; the
bundled `content_migration` example is a working starting template you can adapt to
your own source table.
