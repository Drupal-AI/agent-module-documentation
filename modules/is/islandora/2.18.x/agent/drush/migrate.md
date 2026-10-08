# Islandora Drush integration

Islandora registers a Drush command **hook class** (`src/Commands/IslandoraCommands.php`, service
`islandora.commands` in `drush.services.yml`) rather than new top-level commands. It augments core
**Migrate** commands so ingests run as a chosen user.

## Added option: `--userid` on `migrate:import` / `migrate:rollback`

- `@hook option migrate:import` and `migrate:rollback` add a `--userid` option.
- `@hook validate` — validates the given user id exists.
- `@hook pre-command` — switches to that user (`AccountSwitcherInterface`) for the run.
- `@hook post-command` — switches back.

### Usage

```bash
# Run a CSV / migrate_plus ingest as user 1 (so created nodes/media are owned correctly).
drush migrate:import my_islandora_migration --userid=1
drush migrate:rollback my_islandora_migration --userid=1
```

This matters because Islandora content is typically created via `migrate_plus` + `migrate_source_csv`
pipelines, and derivative/index reactions and ownership depend on the acting user. There are no other
Islandora-specific Drush commands in the core module.
