<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Queue unique — agent index

A queue backend that rejects duplicates: `createItem()` returns `FALSE` (and stores nothing)
when the same item is already queued. No config, no schema, no permissions, no admin UI, no
Drush command of its own.

- **Get a unique queue, route a queue to it, prefix-based queues, the hash/table, workers** →
  [api/unique-queue.md](api/unique-queue.md)

Key facts:
- Service **`queue_unique.database`** = `UniqueQueueDatabaseFactory` (parent `queue.database`),
  returns `UniqueDatabaseQueue extends DatabaseQueue`.
- Own DB table **`queue_unique`** with a `char(48)` `hash` column + unique key; the hash is
  `sha2` + base64 SHA-512 of `name . serialized_data`.
- Enable per queue: `$settings['queue_service_<name>'] = 'queue_unique.database';` in
  `settings.php`, or call the service directly, or replace core `queue` with
  `Drupal\queue_unique\QueueFactory` and use the `queue_unique/<name>` prefix.
- Process with core `drush queue:run <name>` (no module-specific Drush command).
