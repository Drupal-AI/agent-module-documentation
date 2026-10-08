<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Audit: Fields (audit_fields) — agent index

Analyzes entity types, bundles, fields, and display configurations; flags unused fields and excess view/form modes.

Submodule of the **audit** framework. Depends on: `audit`. Core `^10.2 || ^11 || ^12`. Version 1.0.11.

## Analyzer plugin

- Plugin id `fields` — `FieldsAnalyzer` (`src/Plugin/AuditAnalyzer/FieldsAnalyzer.php`), extends `AuditAnalyzerBase`, `#[AuditAnalyzer]` weight 2 (default Project-Score multiplier).
- Detail-page checks (`getAuditChecks()`): `unused_fields` (Unused Fields), `orphaned_storage` (Orphaned Field Storages), `missing_descriptions` (Missing Field Descriptions), `field_visibility` (Field Visibility), `field_count` (Field Count), `view_modes` (View Modes), `form_modes` (Form Modes), `display_architecture` (Display Architecture), `inventory` (Inventory).

## Configuration

- Config object `audit_fields.settings` (schema `config/schema/audit_fields.schema.yml`, defaults `config/install/audit_fields.settings.yml`). Keys: `max_fields_per_bundle` (30), `max_view_modes` (5), `max_form_modes` (2), `analyze_field_usage` (false).
- Edited via the module's group on the main audit settings form (`/admin/reports/audit/settings`); the analyzer's `buildConfigurationForm()` supplies the fields.

## Run it

- UI: Reports > Audit > `Audit: Fields` detail page (runs live, `view audit results` permission).
- Drush: `drush audit:run fields` (JSON; add `--filter=...`, `--fail-on=error`), discover filters with `drush audit:filters fields`.

Parent framework + plugin API: [../../../../agent/start.md](../../../../agent/start.md), [../../../../agent/plugins/analyzer.md](../../../../agent/plugins/analyzer.md).
