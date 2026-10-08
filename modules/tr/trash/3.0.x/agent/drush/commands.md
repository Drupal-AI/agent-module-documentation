# Drush commands

Provided by `Drupal\trash\Drush\Commands\TrashCommands` (needs Drush `^12.5.1 || ^13`).

| Command | Alias | Purpose |
|---|---|---|
| `trash:restore [entity_type_id] [entity_ids]` | `tr` | Restore trashed entities. `entity_ids` is a comma-separated list; `--all` restores every enabled type. |
| `trash:purge [entity_type_id] [entity_ids]` | `tp` | Permanently purge trashed entities. `--all` purges every enabled type. |
| `trash:export-views` | `tev` | Export the dynamically generated Trash views as View config entities so they can be customized. |

```
# Restore specific nodes from trash.
drush trash:restore node 12,15,20

# Restore everything in the trash bin.
drush trash:restore --all

# Purge all trashed content permanently.
drush trash:purge --all
```

Both restore and purge prompt for confirmation before acting.
