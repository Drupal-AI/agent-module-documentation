<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Yet Another Entity Iterator provides an autowireable factory service that loads and iterates large sets of entities in memory-efficient chunks.

---

Yet Another Entity Iterator (`another_entity_iterator`) is a small developer-only utility for Drupal 10.2+/11 (PHP 8.2+). It exposes one public service, `another_entity_iterator.factory` (`EntityIteratorFactory`, implementing `EntityIteratorFactoryInterface`). Its single method `get($entityType, $entityIds, $chunkSize = NULL)` takes an entity-type *class-string* (e.g. `Node::class`) plus an iterable of entity IDs and returns a lazy `ChunkedIterator` you can `foreach` over. The iterator loads entities `chunkSize` at a time (default 50, overridable per call or globally via the `entity_update_batch_size` setting) using the entity storage's `loadMultiple()`, then calls `MemoryCacheInterface::deleteAll()` after each chunk so already-processed entities — and their referenced entities such as owners — are released from the entity memory cache. This lets custom code walk thousands or millions of entities without exhausting memory. Unlike Drupal core, an empty ID iterable loads nothing (never "all entities"). The module ships no routes, permissions, controllers, forms, config schema, hooks, or Drush commands — it is purely an API surface for your own controllers, services, batch/queue workers, and Drush code. Because it uses raw storage `loadMultiple()`, it performs no per-entity access checks; the caller is responsible for access filtering when results feed user-facing output.

---

- Iterate over thousands of nodes for a bulk field update without running out of memory.
- Re-save every entity of a type to trigger presave/index hooks after a data migration.
- Reindex a large content set into a search backend chunk by chunk.
- Recompute or backfill a computed field across all existing entities.
- Process a big result set from an `entityQuery()` by passing its returned IDs to the iterator.
- Drive a Drush command that streams over all users, taxonomy terms, or commerce orders.
- Feed a queue worker that processes a fixed batch of entities per run.
- Export a large dataset (CSV/JSON) by iterating entities and flushing per chunk.
- Send templated emails to a large audience of user entities in batches.
- Anonymize or scrub PII across an entire entity type during GDPR cleanup.
- Migrate legacy data by iterating source-mapped entity IDs efficiently.
- Apply a one-off `hook_update_N` data fix over every entity of a bundle.
- Tune the load batch size per job by passing an explicit `$chunkSize`.
- Set a site-wide default batch size via `$settings['entity_update_batch_size']` in `settings.php`.
- Inject the factory into your own service via autowiring (typed constructor argument).
- Iterate a lazy `\Generator` of IDs so IDs are never all held in memory at once.
- Count how many IDs were passed via the iterator's `Countable::count()`.
- Load referenced entities' owners repeatedly without leaking them (memory cache cleared per chunk).
- Replace ad-hoc `array_chunk()` + `loadMultiple()` boilerplate with one reusable helper.
- Keep long-running maintenance scripts within PHP memory limits.
- Process entities from any storage-backed entity type (nodes, users, media, terms, custom entities).
