<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Migrate Sandbox (migrate_sandbox) — agent index

A developer tool that runs Drupal's migrate **process pipeline** interactively. You paste a
single source row, `constants`, and a `process:` config into a form; it builds a throwaway
migration, runs the row through it, and shows the transformed output — no migration is
created, imported, rolled back, or written to the migrate map tables. Meant for local/dev use.

- Depends on core `migrate`. Core requirement `^9.2 | ^10 || ^11`.
- Recommended (optional): `yaml_editor` (better editing), `migrate_plus`/`migrate_example`
  (many starter examples reference their plugins). Neither is required.
- Configure/use route: **`migrate_sandbox.settings_form`** at
  `/admin/config/development/migrate-sandbox`.
- Defines 1 permission, no drush commands, config schema yes, no new plugin *type* (it does
  register internal migrate destination + id_map plugins — see below).

## What you'd do

- **Run a source row through a process pipeline and read the output** →
  [configure/sandbox.md](configure/sandbox.md)
- **Prepopulate from a bundled plugin example, from `migrate_sandbox.latest`, or from a real
  migration** → [configure/sandbox.md](configure/sandbox.md)
- **Grant access to the tool** → [permissions/permissions.md](permissions/permissions.md)

## Key facts

- Form class: `Drupal\migrate_sandbox\Form\MigrateSandboxForm` (extends `ConfigFormBase`),
  form id `migrate_sandbox_settings`.
- Permission: `access migrate_sandbox` (`restrict access: true`).
- Config objects: `migrate_sandbox.settings` (bundled starter sources; schema
  `migrate_sandbox.settings`) and `migrate_sandbox.latest` (last-run input, schema
  `migrate_sandbox.latest`). Config schema in `config/schema/migrate_sandbox.schema.yml`.
- Runtime classes: `SandboxMigration` (subclasses core `Migration`, swaps in the sandbox
  id_map), `MigrateSandboxMessage` (routes migrate messages to `messenger` instead of the log).
- Internal migrate plugins registered: destination `migrate_sandbox_config`, derived
  destination `migrate_sandbox_entity:<entity_type>`, id_map `migrate_sandbox` (a `NullIdMap`
  subclass — nothing is saved to the DB).
- Result is stashed in `tempstore.private` collection `migrate_sandbox`, key
  `migrate_sandbox.latest`; entities are validated then deleted (never saved).
- Library `migrate_sandbox/migrate_sandbox` (`js/migrate-sandbox.js`) shows a live "Sandbox
  Escape Warning" when the pipeline text contains a side-effecting plugin.
