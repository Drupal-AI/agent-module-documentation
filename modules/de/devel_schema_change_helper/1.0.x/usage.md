<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Provides Drush tooling to carry out entity field schema changes such as renaming an existing field and copying its storage, configuration, displays and stored data to the new field.

---

Renaming a Drupal field is not natively supported: the machine name is fixed at creation, so a rename normally means creating a new field, moving data and updating every form/view display by hand. This module packages that work into a Drush command. `devel_schema_change_helper:rename-existing-field` (alias `dsch-rename-field`) takes an entity type id, the old field name and the new field name; it copies the `FieldStorageConfig`, copies each bundle's `FieldConfig`, replicates the field in all entity view and form displays, and moves the underlying data table contents to the new field's schema. An optional `deleteOldFieldData` flag controls whether the source field is removed afterward.

The module ships no routes, permissions, blocks or UI — it is a developer/CLI utility (package `Development`) intended to run in a trusted shell during migrations or refactors. It uses core's `EntityDefinitionUpdateManager`, the entity type manager and a direct database connection to move data. Treat it like any destructive schema operation: back up the database first, run in a maintenance window, and verify displays after the change.

---

- Rename an existing field without recreating it manually.
- Migrate field data from an old field name to a new one.
- Copy field storage config to the renamed field.
- Copy per-bundle field config to the new field.
- Replicate the field across all view displays.
- Replicate the field across all form displays.
- Optionally delete the old field and its data after copy.
- Standardize inconsistent field machine names across a project.
- Fix a poorly named field created early in a build.
- Script a field rename as part of a deployment/update path.
- Run `drush dsch-rename-field <entity_type> <old> <new>`.
- Preserve stored values during a field refactor.
- Reduce manual display reconfiguration after a rename.
- Use during a content model cleanup.
- Back up the DB before running the destructive operation.
- Run inside a maintenance window on production.
- Verify form and view displays after the rename.
- Keep the old field temporarily by omitting the delete flag.
- Chain with config export to capture the resulting definitions.
- Assist a migration between similar field structures.