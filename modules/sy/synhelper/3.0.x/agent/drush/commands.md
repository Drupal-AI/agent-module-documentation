<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# synhelper — Drush & Console commands

## Drush commands — `src/Drush/Commands/SynhelperCommands.php`
Registered via `drush.services.yml` service `synhelper.commands` (tag `drush.command`). All are CLI-only
(trusted shell context).

- `synhelper:phpstorm` — `generateMetadata()`: builds a PhpStorm metadata file from the container's service
  map and entity storage map and writes `DRUPAL_ROOT/.phpstorm.meta.php` (template
  `src/Drush/Commands/.phpstorm.meta.TEMPLATE.php`). Adapted from the `phpstorm_metadata` project.
- `synhelper:sqlite-vacuum` — `vacuum($target = 'default', $key = NULL)`: runs `VACUUM;` on the named database
  connection when its driver is `sqlite`, else logs an error.
- `synhelper:cim` (alias `syncim`) — `configImport($directory)`: reads every `*.yml` in the given directory via
  `FileStorage`, runs `config.installer::installOptionalConfig()`, and for each file writes the config through
  `config.factory` editable, generating a UUID when the source data lacks one.

## Console command — `src/Command/ExportCommand.php`
Registered via `console.services.yml`. Symfony Console command `synhelper:export`.
- Arguments: `entity_type` (required), `bundle` (required); option `--directory` (destination).
- `execute()`: calls `synhelper.content_exporter`'s `exportAll($entity_type, $bundle)` and writes
  `<directory><entity_type>[.<bundle>].yml` via `Yaml::encode()`.
- `interact()`: interactive pickers for entity type (content entities only) and bundle when omitted.

The importer counterpart (`synhelper.content_importer`) is invoked programmatically / on install rather than
by a shipped command. See [../services/services.md](../services/services.md).
