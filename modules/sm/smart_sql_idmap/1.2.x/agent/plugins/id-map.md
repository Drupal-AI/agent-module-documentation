<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `smart_sql` id_map plugin

Migrate ID-map plugins live under plugin type **`id_map`** (manager service
`plugin.manager.migrate.id_map`). This module registers one, id **`smart_sql`**, class
`Drupal\smart_sql_idmap\Plugin\migrate\id_map\SmartSql`, declared with the annotation
`@PluginID("smart_sql")`. It extends core's default `sql` map, so it is a drop-in swap.

## Use it in a migration

Add an `idMap` key to the migration definition:

```yaml
id: d7_tracker_settings
label: Tracker settings
migration_tags:
  - Drupal 7
idMap:
  plugin: smart_sql
source:
  plugin: variable
  variables_required:
    - tracker_batch_size
process:
  cron_index_limit: tracker_batch_size
destination:
  plugin: config
  config_name: tracker.settings
```

- Works the same in a code-based migration plugin (`migrations/*.yml` in a module) and in a
  `migrate_plus.migration.<id>` config entity (the `idMap` key is identical in both).
- No other change is needed — `source`, `process`, and `destination` are untouched.
- Migrations that do **not** set `idMap` continue to use core's `sql` map.

## Why use it (the core bugs it works around)

- **[#2845340]** — core derives the map/message table names as `migrate_map_<id>` /
  `migrate_message_<id>` and truncates them to 63 chars. Two migrations with long ids can
  collapse to the *same* table name, so one migration's id lookups read another's rows.
  `smart_sql` computes shorter, hash-suffixed, collision-free names (see
  [../api/internals.md](../api/internals.md)).
- **[#3227549]** — `getRowByDestination()` returning `FALSE` instead of an empty array.
- **[#3227660]** — `MigrateExecutable::rollback()` assuming a `rollback_action` key.

The maintainer will mark the module obsolete once every supported core version ships all
three fixes.

## Verify a migration is using it

```bash
# For a migrate_plus config-entity migration:
drush config:get migrate_plus.migration.<id> idMap
# expect: plugin: smart_sql
```

In PHP: the id_map manager lists it —
`array_keys(\Drupal::service('plugin.manager.migrate.id_map')->getDefinitions())` includes
`smart_sql` (alongside `null` and `sql`).

[#2845340]: https://drupal.org/i/2845340
[#3227549]: https://drupal.org/i/3227549
[#3227660]: https://drupal.org/i/3227660
