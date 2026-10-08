<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Smart Migrate CLI overrides Drush's core migrate commands with faster, multi-threaded, dependency-aware equivalents.
---
The module is a Drush-only tool (no routes, permissions, or config UI). Enabling it registers two Drush command services (`smart_migrate_cli.commands` and `migrate_runner.commands`) that replace/augment the standard `migrate:*` commands. It adds multi-threaded import and rollback (spawning worker threads via the `src/Thread` helpers), a migration dependency graph (`src/Component/MigrationDependencyGraph`), a `SmartMigrateExecutable` that wraps core's MigrateExecutable, progress reporting (`TotalProgress`), and diagnostic/configure/reset commands. A `config.factory.override` service (`MigrationMailConfigOverrider`) and a null cache backend (`cache.backend.smc_null`) suppress mail and caching noise during long CLI runs.

Because it is CLI-only, its attack surface is limited to operators who already have shell/Drush access. It uses `account_switcher` to run migrations as a chosen account. The optional `smart_migrate_fixes` submodule provides `MigrationDefinitionUtility` helpers that patch/normalise migration definitions. There is no HTTP-exposed code; all commands run under Drush ^11.

Typical setup: enable the module, then run the enhanced `drush migrate:*` commands (import, rollback, status, diagnose, reset) with the added multi-thread options.
---
- Install to speed up large migrations with multi-threaded import.
- Run an enhanced `drush migrate:import` across multiple worker threads.
- Roll back removed source rows with the multi-thread rollback command.
- Import a single migration with `singleImport` semantics.
- Roll back a single migration's removed rows.
- View migration status in table/JSON format.
- Diagnose migration problems with the `migrate:diagnose` command.
- Reset a stuck migration's status via `migrate:reset`.
- Configure a migration's runtime options from the CLI.
- Build and inspect a migration dependency graph before running.
- Suppress migration emails during CLI runs via the mail config overrider.
- Disable caching noise during long imports with the null cache backend.
- Run migrations under a specific account using the account switcher.
- Track total progress across a batch of migrations.
- Enable `smart_migrate_fixes` to normalise migration definitions.
- Use as a drop-in replacement for core Drush migrate commands.
- Integrate multi-thread imports into a deployment/CI migration pipeline.
- Measure per-migration timing from the finish handlers.
