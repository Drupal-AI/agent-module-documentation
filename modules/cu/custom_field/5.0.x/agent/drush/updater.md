<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush: add / remove a column

Defined in `src/Commands/UpdaterCommands.php` (service `custom_field.updater_commands`). Both
commands are **interactive** — they prompt for the field and column options, then apply the
change to the field storage and the live DB table via `custom_field.update_manager`.

| Command | Alias | Does |
|---|---|---|
| `custom_field:add-column` | `cf-add-column` | Add a new column to an existing Custom Field that may already have data |
| `custom_field:remove-column` | `cf-remove-column` | Drop a column (and its data) from an existing Custom Field |

```bash
drush custom_field:add-column       # prompts: entity type, field, new column name, data type, options
drush cf-remove-column              # prompts: entity type, field, column to remove
```

They print the equivalent `\Drupal::service('custom_field.update_manager')->addColumn(…)` /
`->removeColumn(…)` call so you can paste it into an `hook_update_N()` for deployment. For a
non-interactive/scripted change call the service directly ([../api/services.md](../api/services.md)).
