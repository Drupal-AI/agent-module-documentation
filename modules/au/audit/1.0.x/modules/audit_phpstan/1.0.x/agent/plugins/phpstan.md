<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Audit: PHPStan — the `phpstan` analyzer

`PhpstanAnalyzer` (`src/Plugin/AuditAnalyzer/PhpstanAnalyzer.php`), a `Drupal\audit\AuditAnalyzerBase` subclass declared with
`#[AuditAnalyzer(id: 'phpstan', output_directory: 'phpstan', weight: 2)]`.

> **Experimental / [DEV ONLY].** Requires external tooling on the server and can be resource-intensive; not recommended for production.

## Install / enable

- Enable: `drush en audit_phpstan` (pulls in audit).
- Requirements (`checkRequirements()`): phpstan binary (mglaman/phpstan-drupal recommended for Drupal-aware analysis)
- Appears as a secondary tab and detail page under **Reports → Audit** once the parent `audit` module is enabled.

## What it analyzes

audit_phpstan registers the `phpstan` AuditAnalyzer plugin (PhpstanAnalyzer). It auto-detects the `phpstan` binary and recommended extensions (e.g. mglaman/phpstan-drupal), writes a generated `.neon` config, and runs PHPStan via Symfony `Process` (array-form) over the `audit.settings` scan directories at the configured `level`. Results are bucketed into type errors, deprecation warnings and undefined references, each scored; it also reports the PHPStan environment and any project-level `phpstan.neon`/baseline. Configurable memory limit, ignore patterns, Drupal entity-mapping toggles and an error-type allow-list (`active_types`). Marked experimental / [DEV ONLY].

### Scored checks (contribute to the score)
- `type_errors` — Type Errors
- `deprecation_issues` — Deprecation Warnings
- `undefined_issues` — Undefined References

### Informational checks (no score)
- `environment_status` — PHPStan Environment
- `project_config` — Project Configuration

## Configuration

Config object **`audit_phpstan.settings`** (defaults in `config/install/audit_phpstan.settings.yml`, schema in `config/schema/audit_phpstan.schema.yml`). Values are edited on the parent **`audit.settings`** form (the base module auto-collects `buildConfigurationForm()` output and saves via `processConfigurationValue()`).

| Key | Default |
|---|---|
| `level` | `5` |
| `memory_limit` | `'512M'` |
| `max_errors_display` | `500` |
| `skip_deprecations` | `False` |
| `skip_phpdoc_types` | `False` |
| `skip_entity_mapping` | `False` |
| `custom_entity_mapping` | `''` |
| `report_unmatched_ignored_errors` | `False` |
| `ignore_errors` | `''` |
| `active_types` | `''` |


## Operating it

- **UI**: `/admin/reports/audit/phpstan` (permission `view audit results`); settings under
  `/admin/reports/audit/settings` (permission `administer audit configuration`).
- **Cron**: queued into `audit_processor` by the parent `hook_cron()`; the score is recalculated into the Project Score.
- **Drush**: `drush audit:run phpstan --format=json`; filter with `--filter="severity:error"` /
  `--filter="module:<name>"`; discover filter values with `drush audit:filters phpstan`.
- **Output contract**: `analyze()` returns `['_files' => [...], 'score' => ['factors' => [...]]]`. Sections map to
  checks via `getAuditChecks()`; the base class renders scored sections as faceted issue lists and informational
  sections as tables. Only the score is persisted (State API via `audit.score_storage`); result rows are regenerated
  on each view.
