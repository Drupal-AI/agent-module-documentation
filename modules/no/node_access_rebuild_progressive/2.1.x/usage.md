<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Node Access Rebuild Progressive rebuilds Drupal's node access grants table in configurable chunks instead of all at once, so large sites can rebuild permissions without timeouts or memory exhaustion. Rebuilds can run via a resumable Drush command or incrementally on cron.

---

Drupal's stock "rebuild permissions" processes every node in one request, which fails on sites with many nodes or complex node-access modules (Group, Domain Access, Workbench Access, etc.). This module replaces that with a progressive rebuild: it walks nodes in descending ID order in chunks of `chunk` nodes (default 500), re-acquiring grants with the node access control handler and writing them via `node.grant_storage`, tracking its position in Drupal `state` so it is interruptible and resumable. It exposes a Drush command `node-access-rebuild-progressive` (with `--force`, `--resume`, and `--bundle` options) and an optional cron mode (config `cron: true`) that processes one chunk per cron run. A Lock API semaphore (`node_access_rebuild_progressive_process`) prevents cron and Drush from running concurrently. The module also **disables Drupal's core rebuild form** (`node_configure_rebuild_confirm`) to steer admins toward the Drush command, and can rebuild only selected content types. Settings live in `node_access_rebuild_progressive.settings` (`cron`, `chunk`) with a form at `/admin/config/development/node-access-rebuild-progressive`. Its working state is kept in three `state` keys: `.current` (next node id / position), `.processed` (count), and `.bundles` (active content-type filter).

---

- Rebuild node access grants on a site with hundreds of thousands or millions of nodes without hitting PHP timeouts.
- Rebuild permissions safely after installing or reconfiguring a node access module (Group, Domain Access, Workbench Access).
- Run the rebuild from the command line with `drush node-access-rebuild-progressive`.
- Resume an interrupted rebuild from where it stopped with `--resume`.
- Force a rebuild even when Drupal doesn't think one is needed with `--force`.
- Rebuild grants for only specific content types with `--bundle=article,page`.
- Process node-access rebuilds automatically and incrementally during cron runs (enable `cron`).
- Tune memory usage vs speed by adjusting the `chunk` size (nodes processed per pass).
- Avoid the core "Rebuild permissions" button's all-at-once processing that times out on big sites.
- Keep a production site responsive by spreading a long rebuild across many cron runs.
- Prevent duplicate/concurrent rebuilds via the built-in Lock API semaphore.
- Monitor rebuild progress through the `node_access_rebuild_progressive` logger channel / dblog.
- Recover from a stuck rebuild by releasing the semaphore lock and resuming.
- Clear leftover progressive-rebuild state (`.current`, `.bundles`) so a fresh rebuild starts clean.
- Automate permission rebuilds as part of a deployment or content-migration pipeline.
- Lower the chunk size (e.g. 100) on memory-constrained hosting to keep each pass small.
- Raise the chunk size on powerful hosts to finish a rebuild in fewer passes.
- Rebuild access for a newly added bundle without reprocessing the whole site.
- Trigger a rebuild programmatically with `node_access_rebuild_progressive_trigger()`.
- Ensure caches are invalidated per chunk so rendered output reflects new grants during a rebuild.
- Provide site builders a safe alternative to `drush php-eval 'node_access_rebuild()'` on large sites.
- Coordinate rebuilds across a multi-server setup where only one server runs cron.
