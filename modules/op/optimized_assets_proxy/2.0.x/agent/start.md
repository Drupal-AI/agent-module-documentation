<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CSS/JS Optimized Assets Proxy — agent index

Persists Drupal's aggregated CSS/JS in a DB table and restores files to disk on demand when
a requested aggregate is missing (after cache rebuilds, deploys, or on multi-server setups).

Quick facts:
- Store table: `optimized_assets_proxy` (filename + data + timestamp).
- Restore: `MissingAsset` REQUEST subscriber (priority 240) matches aggregate paths → `optimized_assets_proxy_restore_file()` reads the DB row (parameterized query), writes to disk, regenerates `.gz`, then 302-redirects to the file.
- Write path: overrides core `AssetDumper`; also stores each dumped aggregate.
- Maintenance: `hook_cron()` prunes rows past `system.performance` `stale_file_threshold`; `hook_cache_flush()` truncates the table.
- No admin UI, no permissions, no Drush. Not an SSRF surface — no remote fetch; restore key comes from the request path and is looked up locally.
