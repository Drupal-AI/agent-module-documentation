<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush: `config-distro-update`

Class: `Drupal\config_distro\Drush\ConfigDistroCommands` (Drush `>=11` — a `suggest`/dev dep).

## Command

```
drush config-distro-update            # alias: cd-update
drush cd-update --preview=diff        # show a unified diff instead of the change list
```

| | |
|---|---|
| **Command** | `config-distro-update` |
| **Alias** | `cd-update` |
| **Option** | `--preview` — `list` (default, a change table) or `diff` (unified diff) |

## What it does

1. Builds a `StorageComparer($distroStorage, $activeStorage)` where `$distroStorage` is
   `config_distro.storage.distro` (i.e. active config after the `config_distro.transform`
   subscribers have run).
2. If there are **no changes**, logs "There are no changes to import." and stops.
3. Prints the pending changes (`list` table or `diff`).
4. Prompts to confirm; on **yes** it runs a core `ConfigImporter` to apply the changes (logging
   each sync step) and then dispatches `ConfigDistroEvents::IMPORT` (`config_distro.import`).
   On **no** it throws `UserAbortException`.

So `cd-update` is the CLI equivalent of the `/admin/config/development/distro` form: preview the
diff between the distribution's desired config and active config, then import it.

## Notes

- On its own (no transform subscriber / no companion like `config_sync`) the distro storage
  equals active config, so the command reports no changes.
- Import errors are collected and rethrown as an exception; a failed lock is treated like a
  concurrent-sync error.
- Requires Drush; the command is only registered when Drush is present.
