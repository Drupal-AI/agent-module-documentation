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
  through the `printDebugOutput()` helper.

`printDebugOutput(array $items)` builds a `VarCloner` + `CliDumper` (`setColors(TRUE)`), writes
to `Drush::output()`, emits a leading blank line (so the dump starts on a fresh line, clearing
any drush progress line), then for each item: strings are written verbatim (the `----`/`Source`
banner rows) and arrays are dumped with a custom line callback that strips VarDumper's line
numbers (indenting by depth, ignoring the negative "end of dump" depth).

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

- `composer.json` requires `drupal/core: ^11.3 || ^12`, declares
  `conflict: { "drush/drush": "<9" }` and the Drush extra
  `services: { drush.services.yml: "^9" }`.
- Module dependency: core `migrate` only. `migrate_plus`, `config_update`, `migrate_tools` /
  `migrate_run` are recommended (see `suggests` in data.json) — the config-revert behavior of
  `--migrate-debug` needs `migrate_plus` + `config_update`, and you need a runner like
  migrate_tools to have a `migrate:import` command at all.

There is **no** config schema, no config entities, and no permissions.

## Diff 3.0.x → 3.1.x

Real changes only:

- **Core requirement raised.** `.info.yml` / `composer.json` now declare
  `core_version_requirement: ^11.3 || ^12` (was `^9.5 || ^10 || ^11` on 3.0.x). This branch
  requires **Drupal 11.3+** (or 12) and drops Drupal 9.5 / 10 support.
- **Release:** version `3.1.0`, branch `3.1.x`.

No functional change to the debug features: the `debug` process plugin (`id = "debug"`,
`handle_multiples = TRUE`, `dump` keys value/destination/source/source_ids/source_keys, plus
`label` / `multiple`), the `--migrate-debug` / `--migrate-debug-pre` options, the dual
(modern `drush.services.yml` + legacy `migrate_devel.drush.inc`) registration, the CLI-only
guard, and the migrate_plus config-revert side effect all behave as on 3.0.x. Still no config,
schema, permissions, routes, or admin UI.
