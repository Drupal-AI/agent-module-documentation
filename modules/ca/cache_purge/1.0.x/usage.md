<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Cache Purge watches the size of database `cache%` tables and truncates them when they exceed a configured megabyte limit, preventing runaway cache tables from bloating the database. The size check and purge run on cron.

Use it on sites where cache tables (render, dynamic_page_cache, etc.) grow very large and periodic trimming is desired.
---
Enable with `drush en cache_purge`. Configure the size limit at `/admin/config/system/cache-purge` (route `cache_purge.settings`), gated by the core `administer site configuration` permission. The module also declares an `administer cache purge` permission in `cache_purge.permissions.yml`, though the settings route itself uses `administer site configuration`.

On cron, `cache_purge.module` enumerates tables via `SHOW TABLES LIKE 'cache%'`, computes each table's size from `information_schema.TABLES` (parameterized by table name), and truncates those over the limit.
---
- Cap the on-disk size of cache tables.
- Automatically trim bloated render caches.
- Prevent cache tables from filling the database.
- Purge oversized cache bins on cron.
- Set a per-site megabyte threshold for purging.
- Reclaim database space from stale cache rows.
- Avoid manual cache-table truncation.
- Keep a shared DB host within size quotas.
- Reduce backup size caused by huge cache tables.
- Detect which cache tables exceed the limit.
- Compute table sizes from information_schema.
- Schedule purges via the normal cron run.
- Protect performance on constrained databases.
- Complement Drupal's own cache lifetime settings.
- Configure the threshold through an admin form.
- Mitigate cache-table growth on high-traffic sites.