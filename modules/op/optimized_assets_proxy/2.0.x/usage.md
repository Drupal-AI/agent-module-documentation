<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CSS/JS Optimized Assets Proxy persists Drupal's generated (aggregated/minified) CSS and JS files in a database table and transparently restores them to disk the moment a request hits a missing aggregate. This solves the classic problem where aggregated asset filenames survive in cached HTML/CDN but the physical files are gone — after a cache-rebuild, a deploy, or on a load-balanced multi-server setup where each node has its own filesystem.

---

The module overrides core's `AssetDumper` (and provides AdVAgg-compatible optimizers) so that every aggregate written to disk is also stored in the `optimized_assets_proxy` table. A high-priority kernel REQUEST subscriber (`MissingAsset::findAndWrite`, priority 240 — after ban middleware, before page cache) matches incoming paths against the public/`assets://` CSS-JS aggregate pattern; on a hit it calls `optimized_assets_proxy_restore_file()` which reads the row for that filename from the database (a parameterized query), writes it back to disk (regenerating the `.gz` variant when gzip is enabled), and 302-redirects the browser to the now-present file. `hook_cron()` prunes rows older than the configured `stale_file_threshold`, and `hook_cache_flush()` truncates the table. It fetches nothing from remote URLs (no SSRF surface) — the restore path is derived from the request path and looked up in the module's own DB table. No admin UI, no permissions, no Drush commands; behaviour is driven by core's `system.performance` settings.

---

- Keep aggregated CSS/JS resolvable after a `drush cr` that wiped the files/ directory.
- Serve missing aggregates on a multi-web-server (load-balanced) setup where nodes don't share a filesystem.
- Avoid broken styling/JS on cached pages/CDN whose HTML references now-deleted aggregate files.
- Survive atomic/blue-green deploys where a fresh release directory lacks previously generated aggregates.
- Regenerate the gzip (`.gz`) companion automatically when core gzip compression is enabled.
- Prune stale asset rows automatically on cron using core's `stale_file_threshold`.
- Reduce 404s and full page re-renders caused by missing optimized assets.
- Restore aggregates lazily (only when actually requested) rather than pre-warming everything.
- Store generated assets centrally in the DB so any app server can rebuild them on demand.
- Clear the asset store on cache flush to stay in sync with a rebuild.
- Work alongside AdVAgg-style optimization via the bundled optimizer classes.
- Keep asset restore fast by using a single indexed DB lookup per missing file.
- Eliminate the need for a shared NFS mount just to hold public aggregates.
- Prevent "flash of unstyled content" after deploys on high-traffic sites.
- Integrate transparently with core aggregation without editing theme or render code.
- Recover assets without a full cache rebuild, minimising origin load during traffic spikes.
