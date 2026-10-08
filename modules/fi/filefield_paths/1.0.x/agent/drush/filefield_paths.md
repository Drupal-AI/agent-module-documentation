# Drush — retroactive updates

Command class `Drupal\filefield_paths\Drush\Commands\Commands` (requires Drush ≥ 12.5).

## `filefield_paths:update` (aliases `ffpu`, `ffp-update`)

Retroactively moves/renames existing files for one or more file-field instances by running the
batch updater (`filefield_paths.batch.updater`). Arguments are optional; omitted ones are asked
for interactively (with an "All" choice at each level).

```
drush filefield_paths:update [entity_type] [bundle_name] [field_name] [--all]
```

| Argument / option | Meaning |
|---|---|
| `entity_type` | Entity type id, e.g. `node`, `user`. |
| `bundle_name` | Bundle, e.g. `article`, `page`. |
| `field_name` | File field, e.g. `field_image`, `field_file`. |
| `--all` | Retroactively update **every** file-field instance on the site. |

Examples:

```
drush ffpu                              # interactive: pick entity type → bundle → field
drush ffpu node article field_image     # update one specific field instance
drush ffpu --all                        # update all file-field instances everywhere
```

Only fields whose storage targets the `file` entity type are offered. This is the CLI
equivalent of ticking **Retroactive update** on a field's settings form.
