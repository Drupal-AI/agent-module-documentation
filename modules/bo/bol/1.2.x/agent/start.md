<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bill of Lading (bol) — agent index

Developer/site-audit tool. Adds ONE Drush command that prints a consolidated inventory
("bill of lading") of the site's entity types, bundles, and configurable fields. Despite the
name, it is **not** a shipping/logistics module — "bill of lading" is a metaphor for a site manifest.

- **Version:** 1.2.1 (dir `1.2.x`). Core `^10 || ^11`. Package `Custom`.
- **Dependencies:** none (empty composer `require`). Requires **Drush 12+** to invoke the command.
- **Provides:** one Drush command, no routes, no permissions, no config, no entities, no plugins, no hooks.

## Command
- `bol:report` — alias `bol`. Default output format `table`; columns Entity, Name, ID, Status, Description.
  Works with any Drush format via `--format` (table/json/yaml/csv/…). See [agent/drush/command.md](drush/command.md).

## Key source
- `src/Drush/Commands/BolCommands.php` — the command class `Drupal\bol\Drush\Commands\BolCommands`.
  Injects `@entity_type.manager` and `@entity_field.manager` (wired in `bol.services.yml`).
- `bol.services.yml` — registers the command service with the `drush.command` tag.
- `data/items*.yml` — **legacy/unused** mapping files (config-path and D7-db definitions) from an earlier
  implementation; the current `report()` does not read them (see [agent/drush/command.md](drush/command.md)).

## Docs
- [agent/drush/command.md](drush/command.md) — command behavior, columns, output formats, operation.
