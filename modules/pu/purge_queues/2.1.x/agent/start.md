# Purge Queues — agent index

Adds three **`@PurgeQueue` plugins** to the Purge module's queue layer; the headline feature is
**deduplicating** queued cache-invalidation items. No admin UI of its own, no configure route, no
permissions, no config schema, no Drush. You activate a queue through Purge's existing queue
selection (config `purge.plugins:queue`).

- **Select the queue and where the choice is stored (Purge's config)** →
  [configure/select-queue.md](configure/select-queue.md)
- **The three queue plugins, their tables, and dedup mechanism** →
  [plugins/queues.md](plugins/queues.md)

Key facts:
- Plugin ids: `database_alt` (table `purge_queue_alt`), `database_unique` (extends alt),
  `database_unique_upsert` (table `purge_queue_upsert`, hash PK + UPSERT).
- These implement Purge's plugin type (`@PurgeQueue`); the module defines no plugin type itself.
- Active queue lives in Purge config: `purge.plugins:queue`. Read via
  `\Drupal::service('purge.queue')->getPluginsEnabled()` (default `database`).
