<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Cache Utility turns cache clearing into HTTP endpoints, Drush commands, and toolbar buttons — for Drupal's own caches, cache tags, PHP OPcache and APCu — so a deployment pipeline or a load-balanced host can flush them with a curl call rather than shelling in to run Drush.

---

The problem it addresses is specific: on a multi-server or containerised site, `drush cr` clears Drupal's database caches, but PHP's OPcache and APCu are per-process, so each web node has to be told separately — and a deploy script that cannot SSH into every node has no clean way to reach them, because Drush itself runs under PHP-CLI with a different OPcache than the webserver. Cache Utility gives each operation a URL served by the webserver's PHP: eleven GET routes under `/admin/cache_utility/` cover clear and status for Drupal caches, cache tables and cache tags, plus clear/config/status for OPcache and APCu. Every route authenticates with a shared secret sent in a `CU-ACCESS-KEY` header, matched against `security.accessKey` in the module's configuration (seeded with a random value at install). The same operations are available three other ways: ten Drush commands (`cu:opcache-clear`, `cu:apcu-clear`, `cu:cachetables-truncate`, …) that call those endpoints for you, AJAX buttons and live OPcache/APCu readouts on the settings form at `/admin/config/development/cache_utility`, and — via the `cache_utility_admin_toolbar` submodule — flush links under the toolbar's "Flush all caches" menu. The module can also be configured so that a normal Drupal cache flush automatically resets OPcache, clears APCu, or truncates the `cachetags`/`cache_*` tables, via the `flushCaches.*` toggles.

---

- Flush OPcache on every web node after a deploy, over HTTP.
- Clear Drupal caches from a CI/CD pipeline with a curl call.
- Clear APCu on a host without shell access.
- Truncate the `cachetags` table when it has grown unbounded.
- Truncate all `cache_*` tables to shrink a bloated database.
- Check OPcache hit rate and memory use from a monitoring system.
- Read OPcache or APCu configuration remotely as JSON.
- Flush caches while the site is in maintenance mode during a release.
- Add one-click cache-flush links to the admin toolbar.
- Run any cache operation from Drush (`cu:opcache-clear`, `cu:apcu-clear`, …).
- Make `drush cr` also reset OPcache on that node (via `flushCaches.opcache`).
- Diagnose an OPcache sizing problem from the settings page readout.
- Confirm a clear actually happened, with returned row counts.
- Clear caches on a container that has no exec access.
- Wire cache invalidation into a CDN purge step.
- Report total `cache_*` table row counts before/after a flush.
- Automate post-release cache invalidation across a server fleet.
- Reset OPcache immediately after pushing new PHP code.
- Manage cache flushing on many sites with a single shared secret.
- Clear cache tags without a full Drupal cache rebuild.
