<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How it works: cron scheduling + the `migrations_importer` queue

Two pieces: `hook_cron()` (scheduler) in `migrate_queue_importer.module`, and the
`migrations_importer` QueueWorker (importer) in
`src/Plugin/QueueWorker/MigrateImportQueueWorker.php`.

## `migrate_queue_importer_cron()` — the scheduler

1. **Guard:** if cron was triggered from the *system cron settings* form
   (`form_id === 'system_cron_settings'`), it returns immediately — this avoids long imports
   blocking an interactive request. So test scheduling with `drush cron` / real cron, not the
   admin "Run cron" button on the cron settings form.
2. Loads all `cron_migration` entities with `status = TRUE`. If none, returns.
3. Gets the `migrations_importer` queue and its current depth.
4. For each active cron migration with a non-empty `migration` id:
   - builds the migration instance via `plugin.manager.migration`;
   - computes `interval = time * 1000` (ms) and reads `last_imported` from the
     `migrate_last_imported` key/value store;
   - **eligibility:** only if `queue_depth <= count(cron_migrations)` **and**
     `last_imported + interval < now_ms` — i.e. the queue isn't backed up and enough time has
     passed since the last import;
   - if `ignore_dependencies` is FALSE, recursively queues required dependency migrations first
     (`_migrate_queue_importer_check_dependencies()`), queuing a dependency when it hasn't fully
     processed all rows or when `update`/`sync` is set;
   - queues the migration itself as `['migration' => …, 'update' => …, 'sync' => …, 'ignore' => …]`.
5. Logs `"%label has been scheduled for import."` per item, or `"No migrations to import."`.

The interval is thus a **minimum seconds between imports**, tracked via Migrate's own
`migrate_last_imported` store (updated when a migration imports).

## `migrations_importer` QueueWorker — the importer

`@QueueWorker(id = "migrations_importer", cron = {"time" = 30})` — core cron gives it a 30s
budget per run. `processItem($data)`:

- forces the migration to `STATUS_IDLE` if needed;
- if `ignore` → `$migration->set('requirements', [])` (drop dependency requirements);
- if `sync` → `$migration->set('syncSource', TRUE)`;
- if `update` → `$migration->getIdMap()->prepareUpdate()` (mark rows for re-import);
- runs `(new MigrateExecutable($migration, new MigrateMessage()))->import();` (Migrate Tools).

Exceptions leave the item in the queue for a later run (standard Queue API semantics), so a
transient failure is retried on the next cron.

## What an agent should know

- Nothing runs until **cron** runs; to force it during testing use `drush cron` (not the cron
  settings form) and ensure the target migration id actually exists.
- `time` is seconds; internally compared in milliseconds against the `migrate_last_imported`
  key/value store.
- The queue/worker id is `migrations_importer`; you can inspect depth with
  `\Drupal::queue('migrations_importer')->numberOfItems()`.
- The module does not define a new plugin type; it ships one QueueWorker plugin and one config
  entity type.
