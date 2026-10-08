<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush: module_usage

Defined in `src/Commands/ModuleUsageCommands.php`.

`drush moduse:export` (alias `moduse-export`)
- Options: `--path` (default `private://moduse`), `--file` (default `moduse.json`), `--modules="mod1,mod2"` (optional filter).
- Writes the four module_usage tables to `<path>/<file>` as JSON. Creates the directory if needed.

`drush moduse:import` (alias `moduse-import`)
- Options: `--path` (default `private://moduse`), `--file` (default `moduse.json`).
- Reads the JSON file and calls `QueryService::doImport()`, which `merge()`s rows into `module_usage`, `module_usage_activity`, `module_usage_urls`, `module_usage_notes` inside a transaction (rolls back on error).

Use these to move documentation between environments. The import is idempotent per primary key (merge on `machine_name`/`id`).