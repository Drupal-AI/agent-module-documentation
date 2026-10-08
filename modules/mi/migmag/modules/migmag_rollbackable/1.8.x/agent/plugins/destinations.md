<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# migmag_rollbackable — destination plugins & rollback tables

Classes: `Drupal\migmag_rollbackable\Plugin\migrate\destination\*`. Use an id as a migration's
`destination: plugin:`, or enable `migmag_rollbackable_replace` to swap the core ids
automatically.

| Rollbackable id | Replaces core destination | Class |
|---|---|---|
| `migmag_rollbackable_config` | `config` | `RollbackableConfig` |
| `migmag_rollbackable_color` | `color` (needs `color` module) | `RollbackableColor` |
| `migmag_rollbackable_theme_settings` | `d7_theme_settings` | `RollbackableThemeSettings` |
| `migmag_rollbackable_default_langcode` | `default_langcode` | `RollbackableDefaultLangcode` |
| `migmag_rollbackable_component_entity_display` | `component_entity_display` | `RollbackablePerComponentEntityDisplay` |
| `migmag_rollbackable_component_entity_form_display` | `component_entity_form_display` | `RollbackablePerComponentEntityFormDisplay` |
| `migmag_rollbackable_shortcut_set_users` | `shortcut_set_users` (needs `shortcut`) | `RollbackableShortcutSetUsers` |

Discover which are live:
`\Drupal::service('plugin.manager.migrate.destination')->getDefinitions()` and filter ids
starting `migmag_rollbackable_`. (Ids whose provider module isn't installed won't appear.)

## Rollback data tables (created by `migmag_rollbackable.install`)

Table names/columns come from `Drupal\migmag_rollbackable\RollbackableInterface` constants:

- **`migmag_rollbackable_data`** (`ROLLBACK_DATA_TABLE`) — previous config values so a rollback
  can restore them. Columns: `migration_plugin_id`, `target_id`, `langcode`, `component`,
  `rollback_data`.
- **`migmag_rollbackable_new_targets`** (`ROLLBACK_STATE_TABLE`) — records targets a migration
  newly created, so rollback knows what to delete.

Check they exist: `\Drupal::database()->schema()->tableExists('migmag_rollbackable_data')`.

## Behaviour

Each plugin extends its core counterpart and, before writing, stores the pre-existing value
(via the `Rollbackable*` traits in `src/Traits/`). On rollback it restores stored values and
removes newly-created targets. Per the project README, fully reliable rollback of core
migrations may also need Smart SQL ID Map or core patches (#2845340, #3227549, #3227660).

No configuration, routes, permissions, or Drush commands.
