<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Audit Modules & Themes (audit_modules) — agent index

Analyzes installed modules and themes, detects unused extensions, and provides recommendations based on project type.

Submodule of the **audit** framework. Depends on: `audit`. Core `^10.2 || ^11 || ^12`. Version 1.0.11.

## Analyzer plugin

- Plugin id `modules` — `ModulesAnalyzer` (`src/Plugin/AuditAnalyzer/ModulesAnalyzer.php`), extends `AuditAnalyzerBase`, `#[AuditAnalyzer]` weight 3 (default Project-Score multiplier).
- Detail-page checks (`getAuditChecks()`): `not_recommended` (Production Readiness Issues), `duplicate_modules` (Duplicate Module Issues), `ui_modules` (UI Module Issues), `recommendations_issues` (Missing Required Modules), `removable_modules` (Removable Module Issues), `removable_themes` (Removable Theme Issues), `redundant_themes` (Redundant Theme Issues).

## Configuration

- Config object `audit_modules.settings` (schema `config/schema/audit_modules.schema.yml`, defaults `config/install/audit_modules.settings.yml`). Keys: `shared_hosting` (false), `ignore_ui_modules` (false).
- Edited via the module's group on the main audit settings form (`/admin/reports/audit/settings`); the analyzer's `buildConfigurationForm()` supplies the fields.

## Run it

- UI: Reports > Audit > `Audit Modules & Themes` detail page (runs live, `view audit results` permission).
- Drush: `drush audit:run modules` (JSON; add `--filter=...`, `--fail-on=error`), discover filters with `drush audit:filters modules`.

Parent framework + plugin API: [../../../../agent/start.md](../../../../agent/start.md), [../../../../agent/plugins/analyzer.md](../../../../agent/plugins/analyzer.md).
