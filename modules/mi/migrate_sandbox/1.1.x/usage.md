<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Migrate Sandbox is a developer scratchpad for Drupal's migration process pipeline: you paste a single source row and a `process:` configuration into a form and immediately see what the pipeline produces, without writing a migration, running it, or rolling it back.

---

Building a migration is mostly an argument with the process pipeline — which plugins to chain, in what order, and what `source`/`default_value`/`callback`/`sub_process` actually do to a given value. Normally the feedback loop is edit YAML, `drush migrate:import`, inspect, `drush migrate:rollback`, repeat. Migrate Sandbox collapses that to a single form submit at `/admin/config/development/migrate-sandbox`. `SandboxMigration` builds a throwaway migration from what you type, runs the row through core's `MigrateExecutable`, and a `NullIdMap`-based id_map plus `MigrateSandboxMessage` keep everything off the database — no `migrate_map` rows, and migrate messages surface as on-screen messenger output instead of log entries. The result can target a sandbox config object or a sandbox content entity, both of which are shown and then discarded (the entity is created, validated, and deleted; nothing is saved). It ships ~50 starter examples (one per process plugin from core Migrate and Migrate Plus), can reload your last input from `migrate_sandbox.latest`, and can even populate a row and pipeline straight from a real migration by machine name. The optional `yaml_editor` module makes the three YAML fields much nicer to edit.

---

- Experiment with a migrate process pipeline without running a real migration.
- Learn what a specific process plugin does to a given value.
- Debug a failing transformation quickly, on screen, without tailing a log.
- Test a plugin chain before committing it to a migration's YAML.
- Reproduce a colleague's pipeline problem from a pasted source row.
- Check how `default_value` and `null_coalesce` interact with `source`.
- Grok hard-to-grok plugins like `sub_process`, `migration_lookup`, `entity_generate`, `transpose`.
- Explore the `dom`, `dom_select`, `dom_apply_styles` markup-transform plugins interactively.
- Load a bundled starter example for almost any core or Migrate Plus process plugin.
- Verify a `format_date` conversion between two formats/timezones.
- Confirm a `callback` plugin's argument order and `unpack_source` behaviour.
- Iterate on a `concat`, `explode`, or `str_replace` chain.
- Validate a `skip_on_empty` / `skip_on_value` condition.
- Inspect how `static_map` handles booleans, defaults, and `bypass`.
- Pull one row's source data from a real migration to inspect a source plugin's output.
- Copy a real migration's `process:` into the sandbox to tweak it in isolation.
- Step through rows of a real migration with "Fetch next row" and constraint filters.
- Reload the last-run input from `migrate_sandbox.latest` to continue where you left off.
- Preview a decoded source row as a PHP array before running it.
- Compare two candidate pipelines by running each and reading the YAML/array output.
- Test a custom or contributed process plugin you have just written.
- Teach the migrate process pipeline to a developer new to Drupal migrations.
- Document a pipeline's behaviour with a reproducible worked example.
- Prototype a transform on a development site without touching production data.
