<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Migration queue importer — agent index

Runs Migrate API migrations on **cron** via the **Queue API**. You create `cron_migration`
config entities (one per scheduled migration); `hook_cron()` queues the due ones onto the
`migrations_importer` queue, whose worker runs `MigrateExecutable::import()`. Requires
`migrate_tools` + `migrate_plus`. One permission: `administer cron migrations`.

- **The `cron_migration` config entity (fields, interval, flags), the admin UI, enable/disable, drush** →
  [configure/cron-migration.md](configure/cron-migration.md)
- **How scheduling works: hook_cron, the `migrations_importer` queue worker, dependencies, timing** →
  [api/how-it-works.md](api/how-it-works.md)

Key facts:
- Config entity id `cron_migration`; config name `migrate_queue_importer.cron_migration.<id>`.
  Exported keys: `id`, `label`, `migration` (migration plugin id string), `time` (interval,
  **seconds**), `update`, `sync`, `ignore_dependencies` (booleans). `status` is the entity key
  (enabled/disabled).
- Only **active** (`status: true`) cron migrations are considered each cron run.
- Queue id / QueueWorker plugin id: `migrations_importer` (cron time budget 30s).
- UI collection: `/admin/config/migrate_queue_importer/cron_migration` (under
  *Configuration → Development*). `info.yml` has no `configure` key → `configure: null`.
- No Drush commands of its own; it runs on `drush cron` / real cron. It does **not** define a
  new plugin *type* (the worker is a core Queue plugin).
