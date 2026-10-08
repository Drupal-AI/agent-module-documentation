<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Audit: Code Complexity [DEV ONLY] (audit_complexity) — agent index

Analyzes code complexity metrics (LOC, cyclomatic complexity, maintainability index) and Drupal anti-patterns for custom modules and themes using phploc. **[DEV ONLY]** — experimental.

Submodule of the **audit** framework. Depends on: `audit`. Core `^10.2 || ^11 || ^12`. Version 1.0.11.

## Analyzer plugin

- Plugin id `complexity` — `ComplexityAnalyzer` (`src/Plugin/AuditAnalyzer/ComplexityAnalyzer.php`), extends `AuditAnalyzerBase`, `#[AuditAnalyzer]` weight 2 (default Project-Score multiplier).
- Detail-page checks (`getAuditChecks()`): `complexity_hotspots` (Complexity Hotspots), `maintainability_index` (Maintainability Index), `anti_patterns` (Drupal Anti-Patterns), `overview` (Metrics Overview), `code_metrics` (Detailed Code Metrics), `api_usage` (Drupal API Usage).
- Requires the external **phploc** binary; `checkRequirements()` returns a warning (and the analyzer reports `requirements_not_met`) when it is missing. Runs via Symfony `Process` with array argv over the config `scan_directories`.

## Configuration

- Config object `audit_complexity.settings` (schema `config/schema/audit_complexity.schema.yml`, defaults `config/install/audit_complexity.settings.yml`). Keys: `include_tests` (false), `ccn_warning_threshold` (10), `ccn_error_threshold` (20), `max_hotspots_display` (20), `detect_service_locators` (true), `detect_deep_arrays` (true), `detect_hardcoded_ids` (true), `detect_direct_queries` (true), `deep_array_threshold` (5), `allow_service_locators_in_procedural` (true).
- Edited via the module's group on the main audit settings form (`/admin/reports/audit/settings`); the analyzer's `buildConfigurationForm()` supplies the fields.

## Run it

- UI: Reports > Audit > `Audit: Code Complexity [DEV ONLY]` detail page (runs live, `view audit results` permission).
- Drush: `drush audit:run complexity` (JSON; add `--filter=...`, `--fail-on=error`), discover filters with `drush audit:filters complexity`.

Parent framework + plugin API: [../../../../agent/start.md](../../../../agent/start.md), [../../../../agent/plugins/analyzer.md](../../../../agent/plugins/analyzer.md).
