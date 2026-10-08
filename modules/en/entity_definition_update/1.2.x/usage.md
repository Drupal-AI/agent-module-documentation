<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Definition Update provides a developer service that applies pending entity-type and field storage definition (schema) changes to the database from your own update hooks.

---

Entity Definition Update is a small developer/deployment helper. It exposes one service,
`entity_definition_update.entity_definition_update_manager`, whose `applyUpdates()` method
reconciles the entity-type and field storage definitions declared in code with the schema
recorded in the database. You call it from a module's `hook_install()` or `hook_update_N()`
so that "mismatched entity/field definitions" are resolved as part of a controlled update run
(`drush updatedb` or `update.php`) rather than by clicking an ad-hoc button or hand-writing
listener calls. It is positioned as an alternative to Drupal core's Entity Definition Update
Manager, which no longer applies definition updates automatically. Updates that would require an
entity data migration are deliberately rejected with an exception, so you back up and restore
row data yourself around the call. The module ships no routes, forms, permissions, config, or
Drush commands, and depends only on core System and Field.

---

- Add new base fields to a custom entity type and install their storage from `hook_install()`.
- Reconcile mismatched entity/field definitions reported on the *Status report* after code changes.
- Apply entity-type and field storage updates during `drush updatedb` / `update.php`.
- Install a newly declared field storage definition on an existing entity type.
- Update an existing field storage definition (e.g. index or property change) from an update hook.
- Delete a removed field storage definition as part of an update hook.
- Make an entity type revisionable and add revisionable fields in the same update.
- Sync entity definitions from code into the database on first install of a module.
- Replace ad-hoc calls to core's entity type / field storage definition listeners with one call.
- Run schema reconciliation deterministically as part of a deployment pipeline.
- Detect when a change needs a data migration (the call throws) before shipping it.
- Back up, truncate, update definition, and restore data around `applyUpdates()` for data-preserving migrations.
- Keep code-declared entity schema and database schema in step across environments.
- Avoid the removed automatic apply behavior of core's Entity Definition Update Manager.
- Trigger definition updates from a custom deployment/update module.
- Apply many entity types' pending changes in one pass.
- Clear stale cached entity type / field definitions before applying changes.
- Script entity schema changes in a repeatable, reviewable update hook.
- Bring a site's entity storage in line after moving fields from config to code.
- Apply definition changes in a headless/CI update step without a UI.
