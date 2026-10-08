<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands

Registered through `drush.services.yml` →
`Drupal\entity_update\Commands\EntityUpdatesCommands` (Drush 10/11 service-file style;
`composer.json` `extra.drush.services` declares it for `^10 || ^11`).

## `entity:update` — alias `upe`

```
drush upe [ENTITY_TYPE_ID] [options]
```

| Option | Effect |
|---|---|
| `--show` | Print the pending change summary and exit (`EntityCheck::showEntityStatusCli()`). |
| `--basic` | `EntityUpdate::basicUpdate()` — apply definition/field-storage updates directly. Throws if an affected entity type has data. |
| `--force` | Combined with `--basic`, try the basic path even when data exists. |
| `--all` | `EntityUpdate::safeUpdateMain()` — backup → delete → update schema → recreate, for every changed entity type. Cannot be combined with an `ENTITY_TYPE_ID`. |
| `--bkpdel` | Copy the entities that need updating into the `entity_update` backup table and delete them (no schema change). |
| `--rescue` | Recreate entities from the backup table (`EntityUpdate::entityUpdateDataRestore()`). |
| `--clean` | Truncate the backup table (`EntityUpdate::cleanupEntityBackup()`). |
| `--nobackup` | Skip the automatic `drush sql-dump --gzip` before the run. **Declared default is `TRUE`**, so unless you pass `--nobackup=0` no dump is taken and the update proceeds. |
| `--cache-clear` | Set to `0` to suppress the automatic cache rebuild after `--all`. |

Positional `ENTITY_TYPE_ID` (without `--all`) updates just that entity type via
`EntityUpdate::safeUpdateMain(entity_update_get_entity_type($type))`.

Typical sequences (from the project README):

```bash
drush upe --show                 # what is pending?
drush upe --basic                # empty entity types: fast path
drush upe --all                  # entity types with data: safe path
drush upe node --nobackup        # one entity type, no sql-dump
drush upe --rescue               # recreation failed -> retry from backup
drush upe --clean                # done -> empty the backup table
```

Multi-step structural change (e.g. making an entity type translatable):

```bash
drush upe --clean
drush upe MY_TYPE --bkpdel       # park the data
# ... change the entity type annotation/attribute in code ...
drush upe MY_TYPE --nobackup     # install the new schema
drush upe --rescue               # put the data back
drush upe --clean
```

Behaviour notes:

- Every destructive path asks an interactive `confirm()`; pass `-y` for unattended runs.
- Without `--nobackup` the command shells out to `drush cr` and
  `drush sql-dump --gzip > backup_<ymd-his>.sql.gz` in the current working directory and
  **returns without performing the update** — run it again with `--nobackup` afterwards.
- With no options and no entity type it prints a note and exits (no-op).
- `--all` finishes with a `cache-rebuild` unless `--cache-clear=0`.

## `entity:check` — alias `upec`

```
drush upec [ENTITY_TYPE_ID] [options]
```

| Option | Effect |
|---|---|
| `--types` | List entity types; the positional argument filters by substring. |
| `--list` | List entity records of the given type. |
| `--start=N` | Offset for `--list`. |
| `--length=N` | Number of records for `--list` (default 10). |
| `--show` | Same pending-changes summary as `upe --show`. |

```bash
drush upec node                       # summary of one entity type
drush upec block --types              # all entity types whose id contains "block"
drush upec node --list --start=2 --length=3
```

Read-only — `entity:check` never mutates the site.
