# Drush commands

Provided by `Drupal\migrate_tools\Drush\Commands\MigrateToolsCommands` (registered in
`drush.services.yml`). All accept migration IDs and/or `--group` / `--tag` selectors.

| Command | Aliases | Purpose |
|---|---|---|
| `migrate:status` | `ms`, `migrate-status` | List migrations with total / imported / unprocessed counts + status |
| `migrate:import` | `mim`, `migrate-import` | Run migration(s) — import source rows into destinations |
| `migrate:rollback` | `mr`, `migrate-rollback` | Undo an import, deleting the destination records it created |
| `migrate:stop` | `mst`, `migrate-stop` | Gracefully interrupt a running migration |
| `migrate:reset-status` | `mrs`, `migrate-reset-status` | Reset a migration stuck in "Importing" back to "Idle" |
| `migrate:disable` | `mdis`, `migrate-disable` | Disable a migration |
| `migrate:messages` | `mmsg`, `migrate-messages` | Show logged messages (errors/notices) for a migration |
| `migrate:fields-source` | `mfs`, `migrate-fields-source` | List the fields available from a migration's source |
| `migrate:tree` | — | Print the dependency tree / ordering of migrations |

## Common selectors & options (`migrate:import`)
```bash
drush migrate:import article                 # one migration
drush mim --group=my_group                   # whole group
drush mim --tag='Drupal 7'                   # by tag
drush mim --all                              # every migration
```
Key options:
- `--limit=N` — stop after N items (test runs).
- `--batch-size=N` — process in batches of N (large sources / memory).
- `--idlist=1,2,3` (`--idlist-delimiter=`) — only these source IDs.
- `--update` — re-process already-imported items with current source data.
- `--sync` — delete destination records no longer present in the source.
- `--force` — run even if dependencies are unmet.
- `--execute-dependencies` — run dependent migrations first.
- `--continue-on-failure` — keep going when one migration errors.
- `--feedback=N` — progress message every N items; `--skip-progress-bar`.

`migrate:rollback` shares `--group`/`--tag`/`--idlist`/`--feedback`/`--continue-on-failure`.
A progress bar is rendered by the `migrate_tools.migration_drush_command_progress`
event subscriber during import/rollback.
