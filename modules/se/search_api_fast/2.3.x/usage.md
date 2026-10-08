<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Search API Fast indexes a Search API index with several Drush workers running simultaneously, so a full reindex that takes hours sequentially can be parallelised across CPU cores.

---

Standard Search API indexing walks items one at a time, on cron or through `drush search-api:index`, and on a site with hundreds of thousands of items a full reindex becomes an overnight job — a real constraint after a schema change, a processor change, or a migration. The bottleneck is usually not the search backend but Drupal bootstrapping and rendering each item, which parallelises well. This module supplies the machinery: `drush search-api-fast:index INDEX` (alias `sapi-fast`) round-robins the index's remaining items into one database queue per worker, then spawns that many detached `nohup` Drush processes, each draining its own queue via the internal `search-api-fast:index-queue` command. Each worker claims items in batches (`worker_batch_size`), indexes them with `indexSpecificItems()`, clears entity caches, and respawns itself after `max_batches_worker_respawn` batches to keep memory bounded. Worker count, batch size, respawn interval and the Drush path live in the `search_api_fast.performance` config object, editable in `settings.php`, via `drush config:set`, or at `/admin/config/search/search-api-fast`. It depends on `search_api ^1.0` and, by design, on Drush and a Unix/Linux host — indexing belongs in a terminal or a job runner, never a browser request. The operational judgement is about resources: workers compete for database connections, PHP processes and backend throughput, so the right worker count is the one the infrastructure supports; set it too high and a slow reindex becomes an outage — the database connection limit is usually the first ceiling to hit. Test on a copy before running it against production.

---

- Reindex a large site faster.
- Parallelise Search API indexing across CPU cores.
- Shorten a reindex after a schema change.
- Reindex following a content migration.
- Reduce an overnight indexing window.
- Run indexing from Drush with several concurrent workers.
- Speed up initial index population on a fresh index.
- Index a large media library quickly.
- Reindex after adding or changing an index processor.
- Clear and rebuild an index from empty (`sapi-fast INDEX clear`).
- Mark everything for reindex, then index in parallel (`sapi-fast INDEX reindex`).
- Use available CPU during a maintenance window.
- Reduce time to search readiness after a deploy.
- Index a multilingual site's content faster.
- Fit a reindex into a release window.
- Tune worker count to the host's core count.
- Reduce cron pressure from search indexing.
- Recover an index after a Solr backend rebuild.
- Bound worker memory with periodic respawns on very large indexes.
- List available indexes when run with no argument.
