<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Audit - Entity Content Analysis (audit_entity) — agent index

Analyzes content volume by entity type, bundle, and language; detects empty bundles, revision bloat, and translation gaps.

Submodule of the **audit** framework. Depends on: `audit`. Core `^10.2 || ^11 || ^12`. Version 1.0.11.

## Analyzer plugin

- Plugin id `entity` — `EntityAnalyzer` (`src/Plugin/AuditAnalyzer/EntityAnalyzer.php`), extends `AuditAnalyzerBase`, `#[AuditAnalyzer]` weight 1 (default Project-Score multiplier).
- Detail-page checks (`getAuditChecks()`): `content_inventory` (Content Inventory), `revision_analysis` (Revision Analysis), `translation_coverage` (Translation Coverage), `entity_summary` (Entity Summary), `revision_table_sizes` (Revision Table Sizes).

## Configuration

- Config object `audit_entity.settings` (schema `config/schema/audit_entity.schema.yml`, defaults `config/install/audit_entity.settings.yml`). Keys: `empty_bundle_threshold` (1), `revision_threshold_node` (100), `revision_threshold_paragraph` (50), `revision_table_size_threshold_mb` (100).
- Edited via the module's group on the main audit settings form (`/admin/reports/audit/settings`); the analyzer's `buildConfigurationForm()` supplies the fields.

## Run it

- UI: Reports > Audit > `Audit - Entity Content Analysis` detail page (runs live, `view audit results` permission).
- Drush: `drush audit:run entity` (JSON; add `--filter=...`, `--fail-on=error`), discover filters with `drush audit:filters entity`.

Parent framework + plugin API: [../../../../agent/start.md](../../../../agent/start.md), [../../../../agent/plugins/analyzer.md](../../../../agent/plugins/analyzer.md).
