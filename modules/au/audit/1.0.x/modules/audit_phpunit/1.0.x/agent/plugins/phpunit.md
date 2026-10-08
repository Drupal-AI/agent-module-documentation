<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Audit: PHPUnit — the `phpunit` analyzer

`PhpunitAnalyzer` (`src/Plugin/AuditAnalyzer/PhpunitAnalyzer.php`), a `Drupal\audit\AuditAnalyzerBase` subclass declared with
`#[AuditAnalyzer(id: 'phpunit', output_directory: 'phpunit', weight: 2)]`.

> **Experimental / [DEV ONLY].** Requires external tooling on the server and can be resource-intensive; not recommended for production.

## Install / enable

- Enable: `drush en audit_phpunit` (pulls in audit).
- Requirements (`checkRequirements()`): phpunit binary; PCOV or Xdebug for coverage (optional)
- Appears as a secondary tab and detail page under **Reports → Audit** once the parent `audit` module is enabled.

## What it analyzes

audit_phpunit registers the `phpunit` AuditAnalyzer plugin (PhpunitAnalyzer). It scans custom modules for `tests/src/Unit`, `Kernel` and `Functional` test classes, scoring test health/coverage; when a phpunit binary (and PCOV/Xdebug) are available it can execute the Unit suite via Symfony `Process` (array-form, run in the config directory) and parse the JUnit/Clover output for pass/fail counts and coverage percentages. Kernel and Functional tests are listed but not executed. Configurable coverage thresholds, execution timeout, a phpunit config path and a module exclusion list. Marked experimental / [DEV ONLY].

### Scored checks (contribute to the score)
- `test_health` — Test Coverage

### Informational checks (no score)
- `test_structure` — Test Structure

## Configuration

Config object **`audit_phpunit.settings`** (defaults in `config/install/audit_phpunit.settings.yml`, schema in `config/schema/audit_phpunit.schema.yml`). Values are edited on the parent **`audit.settings`** form (the base module auto-collects `buildConfigurationForm()` output and saves via `processConfigurationValue()`).

| Key | Default |
|---|---|
| `phpunit_config` | `''` |
| `enable_coverage` | `True` |
| `timeout` | `120` |
| `coverage_warning_threshold` | `50` |
| `coverage_error_threshold` | `30` |
| `max_failures_display` | `50` |
| `exclude_modules` | `''` |


## Operating it

- **UI**: `/admin/reports/audit/phpunit` (permission `view audit results`); settings under
  `/admin/reports/audit/settings` (permission `administer audit configuration`).
- **Cron**: queued into `audit_processor` by the parent `hook_cron()`; the score is recalculated into the Project Score.
- **Drush**: `drush audit:run phpunit --format=json`; filter with `--filter="severity:error"` /
  `--filter="module:<name>"`; discover filter values with `drush audit:filters phpunit`.
- **Output contract**: `analyze()` returns `['_files' => [...], 'score' => ['factors' => [...]]]`. Sections map to
  checks via `getAuditChecks()`; the base class renders scored sections as faceted issue lists and informational
  sections as tables. Only the score is persisted (State API via `audit.score_storage`); result rows are regenerated
  on each view.
