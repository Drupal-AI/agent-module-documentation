<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Queue unique provides a Drupal queue backend that silently rejects duplicate items: inserting an item that is already queued returns `FALSE` and does not create a second copy.

---

The module ships a `UniqueDatabaseQueue` (extending core `DatabaseQueue`) exposed through the service `queue_unique.database` (a `UniqueQueueDatabaseFactory` whose parent is `queue.database`). Uniqueness is enforced at the database level: the queue uses its own `queue_unique` table which adds a `char(48)` `hash` column with a unique key, and `doCreateItem()` stores `sha2` + a base64 SHA-512 hash of the queue name plus the serialized data. When a duplicate would violate that unique key an `IntegrityConstraintViolationException` is caught and `doCreateItem()` returns `FALSE`, matching `QueueInterface`'s "no item was created" contract. You can consume it three ways: (1) point a specific named queue at the service in `settings.php` with `$settings['queue_service_<name>'] = 'queue_unique.database'`; (2) fetch the factory directly with `\Drupal::service('queue_unique.database')->get('<name>')`; or (3) replace core's `queue` service with the module's `Drupal\queue_unique\QueueFactory`, after which any queue name prefixed `queue_unique/` (e.g. `queue_unique/mymodule_work`) is automatically served by `queue_unique.database` with the prefix stripped — which lets a `@QueueWorker` plugin whose id starts with `queue_unique/` be processed uniquely on cron. The module has no config, no schema, no permissions, no admin UI, and no Drush commands of its own (use core's `drush queue:run`). An `update_8001` hook migrates any old queue data into the current `queue_unique` table schema.

---

- Ensure a background job is only queued once even if the triggering event fires many times.
- Deduplicate "reindex this entity" queue items so an entity is processed once per cron run.
- Avoid piling up identical cache-warm or notification tasks in a queue.
- Route a single named queue to the unique backend via `$settings['queue_service_<name>'] = 'queue_unique.database'`.
- Get a unique queue directly with `\Drupal::service('queue_unique.database')->get('my_queue')`.
- Detect a rejected duplicate by checking `createItem()` for a `FALSE` return value.
- Replace core's `queue` service with `queue_unique\QueueFactory` to enable prefix-based unique queues.
- Use the `queue_unique/` name prefix so a queue is automatically served by the unique backend.
- Name a `@QueueWorker` plugin `queue_unique/mymodule_entity_update` so cron pulls uniquely from a unique queue.
- Keep an "entity changed" queue collapsed to one item per entity between cron runs.
- Prevent duplicate outbound webhook/API-sync tasks when the same content is saved repeatedly.
- Debounce expensive recalculation jobs triggered by rapid successive saves.
- Guarantee at-most-one queued email/digest task per recipient per cycle.
- Combine with core cron queue processing without writing custom dedup logic.
- Process the unique queue on demand with `drush queue:run <queue_name>`.
- Migrate an existing queue's data into the unique-queue schema via the module's update hook.
- Store the dedup hash of queue name + serialized payload so identical payloads collide.
- Allow different queues to hold the same payload independently (the hash includes the queue name).
- Reduce redundant work on high-traffic sites where the same task is enqueued per request.
- Back a search-index or sitemap-regeneration queue that should never hold duplicates.
- Enforce uniqueness at the database layer rather than scanning the queue in PHP.
- Serve multiple distinct unique queues from one shared `queue_unique` table (keyed by name).
