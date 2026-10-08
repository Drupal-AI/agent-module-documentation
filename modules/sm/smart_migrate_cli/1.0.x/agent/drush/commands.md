<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Smart Migrate CLI — Drush commands

Enabling the module replaces core migrate commands. Commands are defined in
`src/Commands/SmartMigrateCliCommands.php` and `src/Commands/MigrateRunnerCommands.php`.

Notable command methods (names, not exact CLI aliases):
- `mtImport` — multi-threaded import.
- `mtRollbackRemoved` — multi-threaded rollback of removed source rows.
- `singleImport` / `singleRollbackRemoved` — single-migration variants.
- `migrationConfigure` — configure a migration's runtime options.
- `migrateReset` — reset a stuck migration status.
- `status` — status list (`--format=table|json`).
- `migrateDiagnose` — diagnostics.

Multi-thread lifecycle is handled by `initializeMultiThreadCommand()` /
`finishMultiThreadCommand()`; worker threads live under `src/Thread`, and
`src/Component/MigrationDependencyGraph` orders dependent migrations.

All commands run under Drush (^11) as an operator; there is no web-facing entry point.
