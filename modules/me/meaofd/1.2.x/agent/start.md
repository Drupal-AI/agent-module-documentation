<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# meaofd (Mismatched entity and/or field definitions) — agent index

Fixes the Status-report warning "Mismatched entity and/or field definitions" by installing/updating an
entity type's stored definitions to match code. No config, no config schema, no plugins. Wraps core's
`entity.definition_update_manager`.

- **Report page, routes, and how to fix from the UI** → [configure/ui-report.md](configure/ui-report.md)
- **`meaofd.fixer` service: `fix()`, `entityTypeHasChanges()`, `getChangeSummary()`** → [api/fixer.md](api/fixer.md)
- **Drush `meaofd:fix <entity_type_id>` (+ `--no-cache-rebuild`)** → [drush/commands.md](drush/commands.md)
- **The two permissions and what they gate** → [permissions/permissions.md](permissions/permissions.md)

Key facts: report at `/admin/reports/mismatched-entity-and-or-field-definitions` (route `meaofd.report`);
fix route `meaofd.fix` (`.../{entity_type}/fix`). Service id `meaofd.fixer`. `configure` = null.
