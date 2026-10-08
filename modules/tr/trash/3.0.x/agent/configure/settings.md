# Settings

Config object `trash.settings` (schema `config/schema/trash.schema.yml`). UI at
`/admin/config/content/trash` (route `trash.settings.form`, permission `administer trash`).
Read/write with `drush config:get trash.settings` / `drush config:set`.

| Key | Type | Default | Meaning |
|---|---|---|---|
| `enabled_entity_types` | sequence of sequences | `{}` | Map of `entity_type_id` → list of enabled bundle IDs. Which entity types/bundles use the trash bin. |
| `auto_purge.enabled` | bool | `false` | Automatically purge trashed entities after a period. |
| `auto_purge.after` | string | `30 days` | Retention period before auto-purge (e.g. `15 days`, `2 hours`); validated by `ValidAutoPurgePeriod`. |
| `compact_overview` | bool | `false` | Simplify the `/admin/content/trash` overview when many types are enabled. |

Notes:
- Enabling a type is usually done through the settings form (it also triggers schema/route
  rebuilds via `TrashConfigSubscriber`). In code use `TrashManager::enableEntityType()` /
  `disableEntityType()` rather than writing config directly.
- Auto-purge runs on cron through the `trash_entity_purge` queue worker
  (`TrashEntityPurger`); the batch behavior can be tuned with the `trash.*` container
  settings in `settings.php`.
- Supported types out of the box include node, taxonomy_term, menu_link_content, file,
  path_alias, and redirect (each has a dedicated trash handler).
