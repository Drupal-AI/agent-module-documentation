<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Smart SQL ID Map provides a drop-in `smart_sql` migrate ID-map plugin that replaces core's `sql` map so migrations with long (or derived) plugin IDs get correctly-named, non-colliding map and message tables.

---

The module ships a single migrate plugin, `SmartSql`, of plugin type `id_map` (`@PluginID("smart_sql")`), that extends core's `Drupal\migrate\Plugin\migrate\id_map\Sql`. You opt a migration into it by setting `idMap: { plugin: smart_sql }` in the migration definition. It exists as a work-around for three core migrate bugs: [#2845340] (map/message table names are truncated past MySQL's 63-character identifier limit, which can silently point two migrations at the same table and corrupt lookups), [#3227549] (`getRowByDestination()` should not return `FALSE`), and [#3227660] (`MigrateExecutable::rollback()` wrongly assumes a `rollback_action` key). To fix the table names it recomputes `mapTableName`/`messageTableName` from the migration id (replacing the derivative separator with `__`): if the natural `m_map_<id>` / `m_message_<id>` name fits in 63 chars minus the DB prefix it is used verbatim, otherwise it is truncated to 45 chars and suffixed with the first 17 chars of an md5 hash of the id, keeping names unique and stable. It also adds a `row_status` index on `source_row_status` and a `destination` index over the destination id columns (shrinking the index column group to stay under MySQL's 3072-byte key length when needed), and overrides `getRowByDestination()` to return `[]` instead of `FALSE`. It has no config, no schema, no permissions, no services, and no admin UI — its entire surface is the plugin id you reference from a migration.

---

- Give a migration whose plugin id exceeds MySQL's 63-character table-name limit its own correctly-named map/message tables.
- Prevent two long-named migrations from silently sharing one map table and corrupting id lookups.
- Opt a `migrate_plus` YAML migration into the fixed id map with `idMap: { plugin: smart_sql }`.
- Migrate from Drupal 7 with derived/deep plugin ids (e.g. `d7_field_instance:node:article`) without table-name collisions.
- Add a stable md5-suffixed short table name for a migration whose id is far longer than 63 chars.
- Work around core issue [#2845340] on a site still on an unpatched core version.
- Avoid `MigrateExecutable::rollback()` failures caused by `getRowByDestination()` returning `FALSE` ([#3227660]).
- Get an empty-array return from `getRowByDestination()` for a not-yet-migrated destination instead of `FALSE` ([#3227549]).
- Ensure a `source_row_status` (`row_status`) index exists on the map table for faster status queries.
- Add a `destination` index across destination id columns to speed up destination-based lookups.
- Keep the destination index within MySQL's 3072-byte key length by automatically shrinking the indexed column group.
- Apply the fix to only the migrations that need it, leaving the rest on core's `sql` map.
- Standardise the id map across a large multi-migration upgrade so every migration uses `smart_sql`.
- Reference the plugin from a migration template so generated derivatives inherit the smart map.
- Use it as a compatibility shim until every supported core release includes the upstream fixes.
- Debug a "duplicate map table" upgrade problem by switching the affected migration to `smart_sql`.
- Keep map/message table names deterministic across environments (the hash is derived from the migration id).
- Combine with `migrate_tools` / `migrate_plus` to run and roll back long-id migrations reliably.
- Preserve rollback support on custom migrations with composite destination ids.
- Swap in the plugin without changing source, process, or destination configuration.
- Provide a safe id map for content migrations that create very long derived migration ids.
