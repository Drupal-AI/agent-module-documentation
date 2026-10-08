<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings

Config object `trash.settings` (schema `config/schema/trash.schema.yml`, `FullyValidatable`,
`strict: true`). Form `Drupal\trash\Form\TrashSettingsForm` at `/admin/config/content/trash`
(route `trash.settings.form`, permission `administer trash`). Read/write with
`drush config:get trash.settings` / `drush config:set`.

![Trash settings form](../../../../../../../screenshots/trash/3.1.x/settings-form.png)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `enabled_entity_types` | sequence of sequences | `{}` | Map of `entity_type_id` → list of enabled bundle IDs (empty list = all bundles). Which entity types/bundles use the trash bin. |
| `auto_purge.enabled` | bool | `false` | Automatically purge trashed entities after a period. |
| `auto_purge.after` | string (nullable) | `30 days` | Retention period before auto-purge (e.g. `15 days`, `2 hours`); validated by the `ValidAutoPurgePeriod` constraint (`Plugin/Validation/Constraint/`). |
| `compact_overview` | bool | `false` | Simplify the `/admin/content/trash` overview (shows the entity-type `<select>`) when many types are enabled. |

## Form behaviour (`TrashSettingsForm`)

- Lists every `SqlContentEntityStorage`-based entity type as a checkbox, with a per-bundle
  checkboxes group when the type has more than one bundle. A `deleted` field owned by another
  provider disables the checkbox.
- `getUnsupportedEntityTypes()` excludes `comment`, `user`, `workspace`, `paragraph` (and,
  with Workspaces + a shared menu tree, `menu_link_content`); these are only shown when already
  enabled, so the integration can be disabled and the form saved.
- On save, enabling/disabling a type triggers `TrashManager::enableEntityType()` /
  `disableEntityType()` through `TrashConfigSubscriber` (installs/uninstalls the `deleted`
  field storage definition) and rebuilds routes/permissions. Prefer the form or the manager
  API over writing config directly.
- When `node` is enabled, the form suggests also enabling `path_alias` and `menu_link_content`.

## Auto-purge

- Runs on cron: `TrashEntityPurger` queues entities older than the cutoff into the
  `trash_entity_purge` queue worker (`Plugin/QueueWorker/TrashEntityPurgeWorker.php`), which
  hard-deletes them in the `inactive` trash context.
- Batch behaviour can be tuned with `trash.*` container parameters in `settings.php`.

## Supported types out of the box

node, taxonomy_term, menu_link_content, file, path_alias, redirect — each has a dedicated
handler in `src/Hook/TrashHandler/`. Any other SQL-backed content entity type can be enabled
too (it uses `DefaultTrashHandler` unless it registers its own — see
[extend/trash-handler.md](../extend/trash-handler.md)).
