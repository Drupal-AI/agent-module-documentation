<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DevUtils (devutils) — agent index

Developer-tools module (package `DP`, core `^11`). "Develop utils." No admin UI, routes, permissions, config schema, or plugin types. Two Drush commands plus one autowired service.

## Composer / deps
- `drupal/devutils`; `composer_requirements`: none. `info.yml` declares no module dependencies.
- Soft runtime deps (used by code, not declared): `file` module (`file.usage` backend, file entities); the `config` module's `StorageReplaceDataWrapper` for the import service; `paragraphs`/`taxonomy`/`block_content`/`media`/`menu_link_content` only when you query those entity types.

## What it provides
- Drush command `devutils:uuid <entity-type> [<filter>] [--label]` — prints UUIDs of entities. Registered command class: `Drupal\devutils\Commands\DevutilsCommands` (service `devutils.commands`, tag `drush.command`, in `drush.services.yml`).
- Drush command `devutils:clear-files` — deletes managed files with zero usage records (same class).
- Service `devutils.update_import` → `Drupal\devutils\ConfigImport` (autowired, in `devutils.services.yml`). Method `import(string $module, array $configs = [])` imports named config from a module's `config/install` / `config/optional` into active storage.

## Notes
- `src/Commands/DrushDevutilsCommands.php` is a second, functionally-identical command class using Drush attribute autowiring; it is NOT registered in `drush.services.yml`, so `DevutilsCommands` is the active one.
- Commands act on live data and are for operators with shell access; `devutils:clear-files` is destructive.

## Solution docs
- Drush commands: [agent/commands/drush.md](commands/drush.md)
- Config import service: [agent/api/config-import.md](api/config-import.md)
