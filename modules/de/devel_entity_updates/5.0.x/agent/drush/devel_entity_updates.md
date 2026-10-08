# devel_entity_updates — Drush command

Registered via `drush.services.yml` (service `devel_entity_updates.command`, tagged
`drush.command`). Requires `drush/drush ^12 || ^13`. **Development only.**

## Command

| Command | Aliases | Purpose |
|---|---|---|
| `devel-entity-updates` | `dentup`, `entup`, `entity-updates` | Apply all pending entity type / field storage definition schema updates. |

Defined in `src/Commands/DevelEntityUpdatesCommands.php` (`@command devel-entity-updates`,
`@bootstrap full`). It is a drop-in replacement for the legacy core `drush entup` /
`drush entity-updates` command. The class also declares `@hook replace-command entity:updates`,
so any call to core's `entity:updates` is routed here.

## Behavior

1. Reads pending changes from core's `entity.definition_update_manager` via `getChangeSummary()`.
2. If none: logs "No entity schema updates required" and exits.
3. If changes exist: prints "The following updates are pending:" then lists each entity type id and
   its changes (tags stripped).
4. Prompts `Do you wish to run all pending updates?` — declining throws `UserAbortException`.
5. On confirm: resolves `DevelEntityDefinitionUpdateManager` (via the class resolver) and calls
   `applyUpdates()`.
6. Unless suppressed, runs a `cache-rebuild` on the current site alias, then logs
   "Finished performing updates."

## Options

| Option | Default | Effect |
|---|---|---|
| `--cache-clear` | `TRUE` | Set to `0` to suppress the automatic cache rebuild; caller clears if needed. |

`--simulate` is not supported (throws an exception). Note: `drush updb --entity-updates` is **no
longer supported** — use this command instead.

## Example

```
drush entup
# or
drush entity-updates --cache-clear=0
```

Do NOT use this to fix a "Mismatched entity and/or field definitions" error on a production site —
identify the module defining the problematic entity/field and file an issue in its queue instead.
