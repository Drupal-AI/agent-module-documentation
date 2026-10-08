# Devel Drush commands

Defined in `src/Drush/Commands/` (Drush 13+). Requires `drush/drush`.

| Command | Purpose |
|---|---|
| `devel:token` | List all available tokens (optionally for an entity type). |
| `devel:hook <hook>` | Show which functions/modules implement a hook. |
| `devel:event [event]` | List events and their registered subscribers. |
| `devel:services [filter]` | List service IDs (and classes) in the container. |
| `devel:uuid` | Generate and print a new UUID. |
| `devel:reinstall <modules>` | Uninstall + reinstall modules to re-run install hooks. |

Aliases follow Drush conventions (e.g. `devel:hook` ↔ `fnh`-style short forms per the command
classes). The submodule `devel_generate` adds the `devel-generate:*` content-generation
commands — see the devel_generate docs.
