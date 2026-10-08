<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Mismatched entity and/or field definitions (meaofd) resolves the "Mismatched entity and/or field definitions" warning shown on Drupal's Status report by installing/updating the affected entity type's stored definitions to match code.

---

The module wraps core's `entity.definition_update_manager`. It reads `getChangeSummary()` (the same data that drives the Status report warning) and, for a given entity type that has pending changes, calls `installEntityType()` to reconcile the stored schema/field definitions with the current code definitions, rebuilding cached entity-type definitions before and after. It exposes three ways to trigger this: a report page at `/admin/reports/mismatched-entity-and-or-field-definitions` (Reports menu) with a per-entity-type "Fix"/"Fix all" button that runs via the Batch API; a Drush command `meaofd:fix <entity_type_id>` (with a `--no-cache-rebuild` option); and a public service `meaofd.fixer` whose `fix($entity_type_id)` method can be called from `hook_update_N()` for automated cross-environment deployment. It defines two permissions — `view mismatched entity and or field definitions` (both `restrict access`) and `fix mismatched entity and or field definitions` — the latter also gating the confirm/fix route. It ships no configuration, no config schema, and no plugins; the fixer is stateless and only acts when a change summary exists for the requested entity type.

---

- Clear the "Mismatched entity and/or field definitions" warning from `/admin/reports/status` after a module update changed an entity or field definition.
- Fix a specific entity type from the UI report page with a single "Fix" button.
- Run `drush meaofd:fix paragraph` to reconcile the Paragraph entity type on the command line.
- Run `drush meaofd:fix node` in a deploy pipeline to sync node schema between environments.
- Call `\Drupal::service('meaofd.fixer')->fix('taxonomy_term')` from a `hook_update_N()` for automated updates.
- Batch-fix an entity type with many pending field changes without hitting a PHP timeout (uses Batch API).
- Reconcile a stored base-field definition after a contrib module added a field to an existing entity type.
- Update the stored schema of a custom entity type whose annotation/attribute changed.
- Skip the cache rebuild around a fix with `drush meaofd:fix node --no-cache-rebuild` when you manage caches yourself.
- Inspect which entity types currently have pending definition changes via the report table before fixing.
- Grant only `view mismatched entity and or field definitions` to auditors who should see but not apply fixes.
- Grant `fix mismatched entity and or field definitions` to a deploy/admin role that may apply the reconciliation.
- Programmatically detect changes with `$fixer->entityTypeHasChanges('node')` before deciding to fix.
- Get a human-readable change summary in code via `$fixer->getChangeSummary()`.
- Resolve entity mismatches introduced by importing configuration between differently-structured environments.
- Fix a media or comment entity type that reports mismatched definitions after a core minor upgrade.
- Automate "install entity type" reconciliation as an alternative to a hand-written `installEntityType()` update hook.
- Confirm the fix succeeded by re-checking that the report page shows "No mismatched entity and/or field definitions found."
- Provide site builders a safe, confirm-gated UI to fix definitions instead of running raw update code.
- Recover a site whose entity edit/save forms broke because stored field definitions drifted from code.
