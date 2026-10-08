<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands

Provided by `Drupal\trash\Drush\Commands\TrashCommands` (shared logic in
`Drupal\trash\TrashCliActions`). Requires Drush `^13` (suggested; conflicts with `< 12.5.1`).

| Command | Alias | Purpose |
|---|---|---|
| `trash:restore [entity_type_id] [entity_ids]` | `tr` | Restore trashed entities. `entity_ids` is a comma-separated list; `--all` restores every enabled type. |
| `trash:purge [entity_type_id] [entity_ids]` | `tp` | Permanently purge trashed entities. `--all` purges every enabled type. |
| `trash:export-views [entity_type_id]` | `tev` | Export the dynamically generated Trash overview view(s) as View config entities so they can be customized in the Views UI. `--all`, `--overwrite`. |

```
# Restore specific nodes from trash.
drush trash:restore node 12,15,20

# Restore everything in the trash bin.
drush trash:restore --all

# Purge all trashed content permanently.
drush trash:purge --all

# Export the node Trash overview view for customization.
drush trash:export-views node
```

- `restore` and `purge` prompt for confirmation before acting; when no `entity_type_id` is
  given (and not `--all`) an interact hook prompts for one from the enabled types.
- `export-views` only applies to entity types with Views integration (`views_data` handler);
  types on the fallback table have no view to export and are reported as skipped.
- The same operations run without Drush through core's `dr` CLI, since `TrashCliActions`
  holds the shared implementation.
