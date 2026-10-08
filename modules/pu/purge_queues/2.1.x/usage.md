Purge Queues adds three extra Purge queue backend plugins, the key ones deduplicating queued cache-invalidation items so the same URL/tag is not queued twice.

---

The module extends the [Purge](https://www.drupal.org/project/purge) module's queue layer with three `@PurgeQueue` plugins. `database_alt` ("Database (extended)") behaves like Purge's core `database` queue but stores each item's invalidation **type** and **expression** in dedicated columns (table `purge_queue_alt`) rather than only in the serialized blob. `database_unique` ("Database unique") builds on that: before inserting, `findItem()` looks for an existing row with the same type and expression (or NULL expression) and, if found, returns that id instead of enqueuing a duplicate — solving the well-known "duplicated queued items" problem where the same invalidation gets added many times. `database_unique_upsert` ("Database unique (upsert)") achieves the same deduplication more efficiently by using a SHA-256 hash of `type:expression` as the primary key and an SQL `UPSERT` (table `purge_queue_upsert`), overriding `claimItem`/`selectPage` etc. to handle the string primary key. You switch the active queue at *Configuration → Development → Performance → Purge* (or by setting `purge.plugins:queue`); no per-item behavior change is needed elsewhere. There is no admin UI, permission, config schema, or Drush command of its own — it plugs into Purge's existing queue selection.

---

- Stop the Purge queue from filling with duplicate invalidations for the same URL or tag.
- Reduce queue size and cache-server load on a high-traffic site with a reverse proxy/CDN.
- Switch a Varnish/CDN purge setup to a deduplicating queue without other config changes.
- Use `database_unique` to guarantee each invalidation expression is queued at most once.
- Use `database_unique_upsert` for the same deduplication with better insert performance.
- Store invalidation type/expression in queryable columns via `database_alt` for debugging.
- Prevent a bursty content-save storm from queuing thousands of identical tag purges.
- Keep cron/queue processing fast by shrinking the number of items to process.
- Avoid redundant origin/CDN purge requests that waste bandwidth and rate limits.
- Deduplicate `everything` or wildcard invalidations queued repeatedly by editors.
- Pair with Purge processors so fewer, unique items flow to the purger.
- Migrate an existing Purge site from the core `database` queue to a unique queue.
- Handle NULL-expression invalidations (e.g. "purge everything") without duplicating them.
- Lower database growth on sites that queue invalidations very frequently.
- Choose the queue engine at admin/config/development/performance/purge in one dropdown.
- Set the queue in code/config (`purge.plugins:queue`) for repeatable deployments.
- Keep tag-based invalidation from a save-heavy workflow from bloating the queue.
- Provide a drop-in scalable queue for multi-editor newsrooms with aggressive caching.
- Reduce lock contention and processing time during large content imports that trigger purges.
- Combine with Purge's diagnostic checks to confirm a supported queue is active.
