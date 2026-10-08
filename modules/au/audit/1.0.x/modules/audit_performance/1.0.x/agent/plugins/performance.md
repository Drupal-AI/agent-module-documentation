<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Audit: Performance — the `performance` analyzer

`PerformanceAnalyzer` (`src/Plugin/AuditAnalyzer/PerformanceAnalyzer.php`), a `Drupal\audit\AuditAnalyzerBase` subclass declared with
`#[AuditAnalyzer(id: 'performance', output_directory: 'performance', weight: 4)]`.

## Install / enable

- Enable: `drush en audit_performance` (pulls in audit, audit_modules).
- Requirements (`checkRequirements()`): None — pure Drupal/config inspection.
- Appears as a secondary tab and detail page under **Reports → Audit** once the parent `audit` module is enabled.

## What it analyzes

audit_performance registers the `performance` AuditAnalyzer plugin (PerformanceAnalyzer). It scores production readiness (error-display level, Twig debug/auto-reload, CSS/JS aggregation, page/dynamic-page cache, BigPipe), inspects the state of cache-related contrib modules (delegating discovery to audit_modules), and statically scans the custom-code scan directories for cache-bubbling and performance anti-patterns (e.g. `file_get_contents()`/`fopen()` on variable URIs, direct DB queries where entity API is preferred, leftover debug code). Findings surface as scored issue sections plus informational status tables on the Performance detail page.

### Scored checks (contribute to the score)
- `production_issues` — Production Settings Issues
- `configuration_issues` — System Configuration Issues
- `cache_modules_issues` — Cache Modules Issues
- `code_issues` — Code Analysis Issues
- `performance_patterns` — Performance Anti-Patterns

### Informational checks (no score)
- `production_status` — Production Settings Status
- `configuration_status` — System Configuration Status
- `cache_modules_status` — Cache Modules Status

## Configuration

Config object **`audit_performance.settings`** (defaults in `config/install/audit_performance.settings.yml`, schema in `config/schema/audit_performance.schema.yml`). Values are edited on the parent **`audit.settings`** form (the base module auto-collects `buildConfigurationForm()` output and saves via `processConfigurationValue()`).

| Key | Default |
|---|---|
| `recommended_cache_max_age` | `21600` |
| `ignore_bigpipe_sessionless` | `False` |


## Operating it

- **UI**: `/admin/reports/audit/performance` (permission `view audit results`); settings under
  `/admin/reports/audit/settings` (permission `administer audit configuration`).
- **Cron**: queued into `audit_processor` by the parent `hook_cron()`; the score is recalculated into the Project Score.
- **Drush**: `drush audit:run performance --format=json`; filter with `--filter="severity:error"` /
  `--filter="module:<name>"`; discover filter values with `drush audit:filters performance`.
- **Output contract**: `analyze()` returns `['_files' => [...], 'score' => ['factors' => [...]]]`. Sections map to
  checks via `getAuditChecks()`; the base class renders scored sections as faceted issue lists and informational
  sections as tables. Only the score is persisted (State API via `audit.score_storage`); result rows are regenerated
  on each view.
