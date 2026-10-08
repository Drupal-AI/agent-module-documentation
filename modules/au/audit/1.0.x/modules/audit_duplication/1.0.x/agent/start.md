<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Audit: Code Duplication [DEV ONLY] (audit_duplication) — agent index

Detects duplicated code (copy-paste / clones) in custom modules and themes using jscpd. **[DEV ONLY]** — experimental.

Submodule of the **audit** framework. Depends on: `audit`. Core `^10.2 || ^11 || ^12`. Version 1.0.11.

## Analyzer plugin

- Plugin id `duplication` — `DuplicationAnalyzer` (`src/Plugin/AuditAnalyzer/DuplicationAnalyzer.php`), extends `AuditAnalyzerBase`, `#[AuditAnalyzer]` weight 3 (default Project-Score multiplier).
- Detail-page checks (`getAuditChecks()`): `clones` (Duplicated Code Clones), `language_breakdown` (Duplication by Language), `overview` (Analysis Overview).
- Requires the external **jscpd** binary; `checkRequirements()` returns a warning (and the analyzer reports `requirements_not_met`) when it is missing. Runs via Symfony `Process` with array argv over the config `scan_directories`.

## Configuration

- Config object `audit_duplication.settings` (schema `config/schema/audit_duplication.schema.yml`, defaults `config/install/audit_duplication.settings.yml`). Keys: `min_lines` (5), `min_tokens` (50), `format_php` (true), `format_twig` (true), `format_javascript` (true), `format_css` (true), `max_clones_display` (50).
- Edited via the module's group on the main audit settings form (`/admin/reports/audit/settings`); the analyzer's `buildConfigurationForm()` supplies the fields.

## Run it

- UI: Reports > Audit > `Audit: Code Duplication [DEV ONLY]` detail page (runs live, `view audit results` permission).
- Drush: `drush audit:run duplication` (JSON; add `--filter=...`, `--fail-on=error`), discover filters with `drush audit:filters duplication`.

Parent framework + plugin API: [../../../../agent/start.md](../../../../agent/start.md), [../../../../agent/plugins/analyzer.md](../../../../agent/plugins/analyzer.md).
