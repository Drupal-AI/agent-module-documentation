<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Audit - Menu Architecture (audit_menu) — agent index

Analyzes menu structure, depth, and identifies navigation issues.

Submodule of the **audit** framework. Depends on: `audit`. Core `^10.2 || ^11 || ^12`. Version 1.0.11.

## Analyzer plugin

- Plugin id `menu` — `MenuAnalyzer` (`src/Plugin/AuditAnalyzer/MenuAnalyzer.php`), extends `AuditAnalyzerBase`, `#[AuditAnalyzer]` weight 3 (default Project-Score multiplier).
- Detail-page checks (`getAuditChecks()`): `menu_analysis` (Menu Analysis).

## Configuration

- Config object `audit_menu.settings` (schema `config/schema/audit_menu.schema.yml`, defaults `config/install/audit_menu.settings.yml`). Keys: `max_menu_depth` (4).
- Edited via the module's group on the main audit settings form (`/admin/reports/audit/settings`); the analyzer's `buildConfigurationForm()` supplies the fields.

## Run it

- UI: Reports > Audit > `Audit - Menu Architecture` detail page (runs live, `view audit results` permission).
- Drush: `drush audit:run menu` (JSON; add `--filter=...`, `--fail-on=error`), discover filters with `drush audit:filters menu`.

Parent framework + plugin API: [../../../../agent/start.md](../../../../agent/start.md), [../../../../agent/plugins/analyzer.md](../../../../agent/plugins/analyzer.md).
