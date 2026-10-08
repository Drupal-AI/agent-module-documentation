<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DRD Migrate (drd_migrate) — agent index

Submodule of **Drupal Remote Dashboard**: a one-shot importer that recreates managed sites in this
dashboard from a **DRD 7 JSON inventory**. Package `DRD`. Core `^10 || ^11`, GPL-2.0-or-later.
Depends on `drd`. (The `.info.yml` description is a placeholder "TODO"; behaviour below is from
source.)

- **The import service, JSON format and Drush command** → [api/import.md](api/import.md)

## What it actually is

- **Import service** `Import` (`src/Import.php`, service `drd_migrate.import`, args `@current_user`,
  `@entity_type.manager`). `execute($filename)` reads a JSON inventory and rebuilds `drd_core` +
  `drd_domain` entities, pushing each domain's one-time token to its remote agent via
  `Domain::pushOTT()`.
- **Drush command** `DrushMigrateCommands` (`src/Drush/Commands/`) — `#[Command(name:
  'drd:migratefromd7', aliases: ['drd-migrate-from-d7'])]`, argument `inventory` (path to the JSON
  file); delegates to the import service.
- Ships `config/translations/drd_migrate.en.yml`. No routes, permissions, config schema, blocks or
  plugins.

## Notes

- The importer switches the current user to **uid 1** (`load(1)` + `setAccount()`) before creating
  entities, so run it as a trusted operator on the CLI only.
- New domains are seeded with `initValues()` (shared_secret + OpenSsl, generated secrets); existing
  ones are matched by URL via `Domain::instanceFromUrl()`.
