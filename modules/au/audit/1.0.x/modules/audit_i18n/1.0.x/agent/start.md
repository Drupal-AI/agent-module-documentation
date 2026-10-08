<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Audit: Internationalization (audit_i18n) — agent index

Analyzes multilingual configuration and translation status.

Submodule of the **audit** framework. Depends on: `audit`. Core `^10.2 || ^11 || ^12`. Version 1.0.11.

## Analyzer plugin

- Plugin id `i18n` — `I18nAnalyzer` (`src/Plugin/AuditAnalyzer/I18nAnalyzer.php`), extends `AuditAnalyzerBase`, `#[AuditAnalyzer]` weight 2 (default Project-Score multiplier).
- Detail-page checks (`getAuditChecks()`): `languages` (Configured Languages), `modules` (Multilingual Modules), `translations` (Translation Coverage), `hreflang` (Hreflang SEO).

## Configuration

- Config object `audit_i18n.settings` (schema `config/schema/audit_i18n.schema.yml`, defaults `config/install/audit_i18n.settings.yml`). Keys: `min_translation_percentage` (80), `check_multilingual_seo` (true).
- Edited via the module's group on the main audit settings form (`/admin/reports/audit/settings`); the analyzer's `buildConfigurationForm()` supplies the fields.

## Run it

- UI: Reports > Audit > `Audit: Internationalization` detail page (runs live, `view audit results` permission).
- Drush: `drush audit:run i18n` (JSON; add `--filter=...`, `--fail-on=error`), discover filters with `drush audit:filters i18n`.

Parent framework + plugin API: [../../../../agent/start.md](../../../../agent/start.md), [../../../../agent/plugins/analyzer.md](../../../../agent/plugins/analyzer.md).
