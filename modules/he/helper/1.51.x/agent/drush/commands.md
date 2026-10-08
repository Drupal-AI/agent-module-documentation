<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Helper Drush commands

Defined in `drush.services.yml` / `src/Commands/`. Manage module schema versions, post-update
hooks and the install profile.

## Module schema versions (`ModuleCommands`)

| Command | Alias | Purpose |
|---|---|---|
| `module:schema-version:get <module>` | `msvg` | Print a module's current schema (update) version |
| `module:schema-version:set <module> <version>` | `msvs` | Set a module's schema version |
| `module:schema-version:delete <module>` | `msvd` | Delete a module's stored schema version |
| `module:schema-version:cleanup` | `msvc` | Remove schema versions left by deleted modules |

```bash
drush module:schema-version:get pathauto        # e.g. 9001
drush msvs mymodule 9002                         # mark update 9002 as applied
drush msvc                                       # clean orphaned schema versions
```

Useful when an `hook_update_N` needs to be re-run (set the version lower) or when a removed module
left a stale schema version behind.

## Post-update hooks (`ModuleCommands`)

```bash
drush module:post-update:reset <module> <hook>   # alias: mpur
```

Resets a specific `hook_post_update_NAME` so it runs again on the next `drush updatedb`.

## Install profile (`InstallProfileCommands`)

```bash
drush install-profile:switch <profile> [<schema_version>]
```

Switches the site's active install profile (updates `core.extension` and related state). The
optional second argument sets the new profile's schema version.

## Cache command hook (`CacheCommands`)

`CacheCommands::alterCacheTypes()` is a Drush `@hook on-event cache-clear` that registers extra
cache types for `drush cache:clear` (it does not add a standalone command).
