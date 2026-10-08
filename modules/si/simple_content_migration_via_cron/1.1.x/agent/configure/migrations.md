<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring scheduled migrations

Cron reads its work list from the config object `simple_content_migration_via_cron`, key `migrations`:

```yaml
migrations:
  content_migration:
    time: 3600      # minimum seconds between runs
    update: true    # optional: re-import existing rows (idMap prepareUpdate)
    sync: true      # optional: delete destination rows missing from source
```

- Each map key is a migration machine name (e.g. `content_migration`).
- `time` is the throttle interval; the next run is gated by state key `<key>_next_execution`.
- On each due run the migration is forced to `STATUS_IDLE`, then imported with `MigrateExecutable`.
- A non-existent migration key is skipped safely (guarded `createInstance`), so a stale entry will not fatally break cron.

The bundled example migration `migrate_plus.migration.content_migration` uses the `content_migration` SQL source (table `products`, id `sku`). Define your own migrations (typically as `migrate_plus` config entities) and list their machine names here.
