<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush command: file:properties

Source: `src/Drush/Commands/AutomatedTestingKitDrushCommands.php`
(class `AutomatedTestingKitDrushCommands extends DrushCommands`, namespace
`Drupal\automated_testing_kit\Drush\Commands`). Discovered by Drush via its `#[CLI\Command]`
attribute.

## Command
- **Name:** `file:properties` · **Alias:** `fprop`
- **Argument:** `filepath` — path to a file or directory.
- **Option:** `format` (default `json`).
- **Returns:** a `RowsOfFields` with one row: `directory`, `filename` (or `<directory>` when the
  path is a directory), `filesize`, `filectime`, `filemtime`, `fileatime`.
  If the path does not exist it logs an error and returns an empty result.

Method: `fileProperties(string $filepath, array $options): RowsOfFields`. Pure filesystem stat
helper (`file_exists`, `filesize`, `filectime`, …) for use from CI/test scripts. CLI-only; takes
no request input.

## Service registration note
`automated_testing_kit.services.yml` declares a `drush.command` service pointing at
`\Drupal\automated_testing_kit\Commands\AutomatedTestingKitCommands` — a class that does not exist
in this release (the real class is under `src/Drush/Commands/`). The command still works because
modern Drush auto-discovers attribute-based command classes; the stale service entry is inert.
