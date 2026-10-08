<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Migrate Devel — agent index

Developer debugging tools for Drupal migrations. No config, no schema, no permissions, no
admin UI (`configure: null`). Depends on core `migrate`. Two independent features:

- **The `debug` migrate process plugin** (drop a breakpoint into a `process:` pipeline;
  `dump:` selects value/destination/source/source_ids/source_keys; `label:`, `multiple:`) →
  [plugins/debug-process.md](plugins/debug-process.md)
- **The `--migrate-debug` / `--migrate-debug-pre` Drush options** (dump each row's Source /
  Destination / DestinationIdValues via the event subscriber; config revert on migrate_plus) →
  [drush/migrate-debug.md](drush/migrate-debug.md)

Key facts: process plugin id `debug` (`Debug`, `handle_multiples = TRUE`); the CLI options are
added to `migrate:import` by `MigrateDevelCommands` and consumed by `MigrationEventSubscriber`
on `MigrateEvents::PRE_ROW_SAVE` / `POST_ROW_SAVE` (CLI only). See
[api/services.md](api/services.md) for the subscriber/service wiring.
