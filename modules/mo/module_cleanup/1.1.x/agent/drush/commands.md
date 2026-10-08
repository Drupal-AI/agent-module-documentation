<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# module_cleanup — Drush commands

Registered in `drush.services.yml`: service `module_cleanup_drush_commands.commands`
(`Drupal\module_cleanup\Commands\ModuleCleanupDrushCommands`), constructor arg `@database`,
extends `Drush\Commands\DrushCommands`. Exit constant `EXIT_ERROR = 1`.

| Command | Alias | Args | What it does |
|---|---|---|---|
| `modcup:field-purge-batch` | `modcup-fpb` | — | Calls `field_purge_batch(1000)`. Catches `PluginNotFoundException` / `FieldException` and logs the message as an error. |
| `modcup:create-storage` | `modcup-cs` | `field_name entity_type` | Creates a `FieldStorageConfig` of type `string` for the given name/entity and saves it. Errors if either arg is empty or the save returns falsy. |
| `modcup:delete-field` | `modcup-df` | `field_name entity_type` | If no storage exists, creates a temporary `string` storage; runs `field_purge_batch(1000)`; then deletes the storage via `FieldStorageConfig::loadByName(...)->delete()`. The owning module/entity must be installed. |
| `modcup:clear-updates` | `modcup-cu` | — | `DELETE FROM key_value WHERE collection = 'update_fetch_task'`. Clears "No available releases found". |
| `modcup:delete-config` | `modcup-dc` | `module` | `DELETE FROM key_value WHERE name = <module>`. Removes leftover data (e.g. `system.schema`) for an uninstalled module. Errors if `module` is empty. |

## Notes / behaviour

- These mirror the four admin forms (`agent/forms/`) for CLI/automation use; `create-storage` /
  `delete-field` expose the field-storage recreate-then-delete trick that
  `TransientEntityTypeDeleteForm` performs interactively.
- `modcup:delete-config` matches on `key_value.name` only, with **no `collection` filter** — it deletes
  every `key_value` row whose `name` equals the argument, across all collections. The argument is not
  validated against the set of actually-uninstalled modules (unlike the admin form, where core
  validates checkbox values against the offered options), so an operator can pass any string.
- CLI commands run with full site privileges; there is no additional permission check beyond being
  able to run Drush on the site.
- `createName()` (private) only prettifies the machine name for the success message (`ucfirst` of the
  underscore-split name); it does not affect what is deleted.
- All destructive commands are irreversible — back up first.
