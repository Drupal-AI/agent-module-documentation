# Drush command

`Drupal\views_data_export\Drush\Commands\ViewsDataExportCommands` (Drush 11+ attribute style).

```
drush views_data_export:views-data-export <view_name> <display_id> [arguments]
drush vde my_view data_export_1
```

Arguments:
- `view_name` — the View machine name.
- `display_id` — the id of the `data_export` display to run.
- `arguments` — contextual-filter argument values, multiple separated by `/`.

Options:
| Option | Purpose |
|---|---|
| `--output-file=<path>` | Also copy the generated file here (relative to the Drupal webroot). |
| `--force` | Overwrite the output file if it already exists. |
| `--uid=<uid>` | Run the export as the given user (to satisfy access restrictions). |

Without `--output-file` the results are printed to stdout. Useful for cron-driven or scripted
exports of large datasets.
