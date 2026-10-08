<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands

Defined in `ContentSynchronizerCommands` (`drush.services.yml`, service
`content_synchronizer.commands`). All wrap the `content_synchronizer.manager` service. Missing
arguments are prompted interactively.

| Command | Aliases | Args / options | Does |
|---|---|---|---|
| `content:synchronizer-export-entity` | `cseex` | `<entityTypeId> <id> [destination]` | Export a single entity (e.g. `node 123`) to a `tar.gz`. |
| `content:synchronizer-launch-export` | `cslex` | `<exportId> [destination]` | Build the archive for a saved Export entity by its id. |
| `content:synchronizer-create-import` | `csci` | `<absolutePath>` | Create an Import entity from a `tar.gz` file path (prints the new import id). |
| `content:synchronizer-launch-import` | `cslim`, `content-synchronizer-launch-import` | `<importId>` `--publish=` `--update=` | Run an existing Import entity. |
| `content:synchronizer-launch-import` (create+launch) | `cscli` | `<absolutePath>` `--publish=` `--update=` | Create an import from an archive **and** launch it. |
| `content:synchronizer-clean-temporary-files` | `csctf` | — | Delete leftover temporary export/import files. |

Options for the import commands:

- `--publish` = `publication_publish` | `publication_unpublish` | `publication_revision`
  (default `publication_publish`; prompted if omitted).
- `--update` = `update_systematic` | `update_if_recent` | `update_no_update`
  (default `update_if_recent`; prompted if omitted).

## Examples

```bash
# Export node 12 to an explicit path
drush content:synchronizer-export-entity node 12 /tmp/node12.tar.gz

# Run saved Export entity #3
drush cslex 3 /tmp/export3.tar.gz

# Create an import from an archive and launch it, unattended
drush cscli /tmp/export3.tar.gz --publish=publication_unpublish --update=update_if_recent

# Two-step: create then launch
drush csci /tmp/export3.tar.gz          # -> prints Import id (e.g. 5)
drush cslim 5 --publish=publication_publish --update=update_systematic

# Housekeeping
drush csctf
```

## Destination path behaviour

The `destination` argument is treated as a **directory to write into**, not the exact filename.
`ContentSynchronizerManager::setDestination()` takes an absolute `destination`, creates it as a
directory if needed, and copies the generated `tar.gz` to `<destination>/<basename(destination)>`.
So `drush cseex node 12 /tmp/out` yields the archive at `/tmp/out/out`. If you can't write there
it falls back to the app root, then to the temp generator dir. The command logs the final
`… has been created` path — read that to find the archive.

Note the command file is registered via `drush.services.yml` (the module also declares the
legacy `extra.drush.services` mapping in `composer.json`).
