<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Migrate Magician Process Plugins (`migmag_process`) adds seven extra migrate **process plugins** and an improved migrate-stub service for use in Drupal migration pipelines.

---

This submodule of Migrate Magician provides process plugins you reference from a migration's `process:` block exactly like core process plugins. The headline plugin is **`migmag_lookup`**, a smarter drop-in replacement for core's `migration_lookup` that only ever creates *valid* stubs, identifies which migration actually contains a source row, can stub from partial (not fully specified) source IDs, and accepts `stub_default_values`. The others are **`migmag_try`** (wrap a sub-pipeline in try/catch with per-exception fallbacks), **`migmag_compare`** (compare two values with a chosen operator), **`migmag_target_bundle`** (resolve a destination bundle from source/destination entity type via bundle migrations), **`migmag_get_entity_property`** (read a property/field off an existing entity), **`migmag_uuid_generate`** (extract or generate a UUID), and **`migmag_logger_log`** (log the live value flowing through a pipeline for debugging). It also registers the public `migmag_process.lookup.stub` service (`MigMagMigrateStub`, an alternative stub service that can stub partial entity IDs), wired up by a service provider only when the core migration plugin manager is available. The module has no configuration, routes, permissions, or Drush commands — it is pure plugin surface. It depends on the base `migmag` module.

---

- Replace core's `migration_lookup` with `migmag_lookup` to avoid invalid, never-updatable stubs.
- Stub an entity reference from a partial source ID (e.g. resolve node 17 → its default revision/translation).
- Pass `stub_default_values` to a lookup so created stubs carry required destination values.
- Look up a destination ID across several candidate migrations and stub in the right one.
- Wrap a fragile `link_uri` (or any) sub-pipeline in `migmag_try` and fall back to a default on exception.
- Suppress or record migrate messages selectively via `migmag_try`'s `saveMessage` option.
- Compare two row properties with `===`, `>=`, `<=>`, etc. using `migmag_compare` to drive conditional logic.
- Return custom values from a comparison with `migmag_compare`'s `return_if` map.
- Combine `migmag_compare` with `skip_on_empty` to conditionally skip a process pipeline.
- Resolve the destination bundle for a node/comment/paragraph from its source entity type (`migmag_target_bundle`).
- Map several source entity types to their bundle-type migrations in one `migmag_target_bundle` step.
- Read the UUID (or any allowed getter / field) of an existing entity mid-migration (`migmag_get_entity_property`).
- Fetch a specific revision or translation's property with `migmag_get_entity_property`'s `load_revision` / `load_translation`.
- Extract an existing UUID from a string, or generate a fresh one, with `migmag_uuid_generate`.
- Log the exact value at a point in a process pipeline with `migmag_logger_log` while debugging a migration.
- Use the `migmag_process.lookup.stub` service directly from custom migration code to create partial-ID stubs.
- Build a Drupal 7 → 11 upgrade where entity references and translations resolve correctly.
- Avoid duplicate/wrong stubs that core's lookup would create in the current migration.
- Provide reusable, tested process plugins across many migrations in a project.
- Chain `migmag_try` around `migration_lookup`/`migmag_lookup` to tolerate missing lookup targets.
- Handle multi-value fields in comparisons/logging via the plugins' `multiple` / `handle_multiples` support.
- Debug why a destination property ends up empty by logging intermediate values.
- Enable only the process plugins you need without pulling in rollback or menu-link features.
