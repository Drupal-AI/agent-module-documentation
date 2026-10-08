<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Migrate Devel is a developer tool for debugging Drupal migrations: it adds `--migrate-debug` / `--migrate-debug-pre` options to the migrate Drush commands and a `debug` migrate process plugin, both of which dump each row's Source, Destination, and ID values to the CLI so you can see exactly what data flows through a migration.

---

The module has two independent pieces. First, an **event subscriber** (`MigrationEventSubscriber`) listens on `MigrateEvents::PRE_ROW_SAVE` and `POST_ROW_SAVE`; when a migrate command is run with the `--migrate-debug` option it pretty-prints each row's Source array, Destination array, and DestinationIdValues after the row is saved (and Source/Destination before the row is saved with `--migrate-debug-pre`), using Symfony's VarDumper `CliDumper` with colors. It only fires under `PHP_SAPI === 'cli'`. The Drush integration is registered two ways for compatibility: a modern `drush.services.yml` command class (`MigrateDevelCommands`) that adds the `--migrate-debug` and `--migrate-debug-pre` options to `migrate:import`, plus a legacy `migrate_devel.drush.inc` that also hooks `migrate-import`/`migrate-status` and, on `--migrate-debug`, clears cached migration definitions and (when `migrate_plus` + `config_update` are present) reverts migration config so edited YAML is re-read. Second, it provides a **`debug` process plugin** (`Debug`, `@MigrateProcessPlugin(id = "debug", handle_multiples = TRUE)`) you drop into a process pipeline; it `dump()`s the incoming value (or, via its `dump:` key, the whole destination/source/source_ids/source_keys) and passes the value through unchanged, so it works like a breakpoint inside `process:` mappings. The module itself has no config, no schema, no permissions, and no admin UI; it depends only on core `migrate` (the Drush pieces additionally need Drush and, for actual migration running, a runner like migrate_tools or migrate_run).

---

- Print every row's source and destination while running `drush migrate:import <id> --migrate-debug`.
- Inspect a row **before** processing with `drush migrate:import <id> --migrate-debug-pre`.
- See the generated destination IDs (e.g. new node ids) after each row via DestinationIdValues.
- Drop a `plugin: debug` step into a `process:` pipeline to inspect the value at that point.
- Debug a "tricky" field's transformation by placing `debug` between two process plugins.
- Dump the entire destination built so far with `debug` + `dump: destination`.
- Dump all source values collected so far with `debug` + `dump: source`.
- Dump the source ID keys/values with `debug` + `dump: source_ids` or `dump: source_keys`.
- Label a debug step's output with the `label:` key (e.g. `label: 'Step 1: '`).
- Force per-item processing downstream with `debug` + `multiple: true` (like multiple_values).
- Diagnose why a migration produces empty or wrong field values by watching the row live.
- Verify a custom source plugin emits the fields you expect before writing process logic.
- Confirm a process plugin chain outputs the right shape before saving to the destination.
- Trace how `migrate_plus` YAML edits take effect (`--migrate-debug` reverts config so edits re-read).
- Clear stale cached migration definitions during iterative development via `--migrate-debug`.
- Debug migrations from the command line during local development without adding logging code.
- Teach/learn how Drupal's migrate Row source vs destination model works by watching real data.
- Spot type mismatches (string vs array) flowing into a destination field.
- Check that lookups/migration_lookup produce the ids you expect mid-pipeline.
- Validate multi-value field handling by dumping arrays at each pipeline step.
- Keep debug output readable with colored, indented VarDumper CLI formatting.
- Add temporary `debug` steps to a migration, run it, then remove them — no config to clean up.
- Combine with migrate_tools' `migrate:import` and `migrate:status` for a full debug workflow.
- Confirm which rows are being saved (and their new ids) during a large import.
