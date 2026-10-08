<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services & wiring

Two service definitions; no public API you call directly — they react to migrate events and
Drush command options.

## `migrate_devel.services.yml`

```yaml
services:
  migrate_devel.migrate_event_subscriber:
    class: Drupal\migrate_devel\EventSubscriber\MigrationEventSubscriber
    tags:
      - { name: event_subscriber }
```

`MigrationEventSubscriber` subscribes to `MigrateEvents::PRE_ROW_SAVE` (`debugRowPreSave`) and
`MigrateEvents::POST_ROW_SAVE` (`debugRowPostSave`). Each handler:
- returns immediately unless `PHP_SAPI === 'cli'`;
- checks `in_array('migrate-debug'[-pre], Drush::config()->get('runtime.options'))`;
- pretty-prints the row's Source / Destination (and, post-save, `getDestinationIdValues()`)
  with Symfony `VarCloner` + `CliDumper` (colors on), line numbers stripped.

## `drush.services.yml`

```yaml
services:
  migrate_devel.commands:
    class: \Drupal\migrate_devel\Commands\MigrateDevelCommands
    tags:
      - { name: drush.command }
```

`MigrateDevelCommands::additionalOptionsMigrateImport()` uses `@hook command migrate:import`
to declare `--migrate-debug` and `--migrate-debug-pre`; the method body is intentionally empty
— the options are read later by the event subscriber.

## Composer / dependencies

- `composer.json` declares `conflict: { "drush/drush": "<9" }` and the Drush extra
  `services: { drush.services.yml: "^9" }`.
- Module dependency: core `migrate` only. `migrate_plus`, `config_update`, `migrate_tools` /
  `migrate_run` are recommended (see `suggests` in data.json) — the config-revert behavior of
  `--migrate-debug` needs `migrate_plus` + `config_update`, and you need a runner like
  migrate_tools to have a `migrate:import` command at all.

There is **no** config schema, no config entities, and no permissions.
