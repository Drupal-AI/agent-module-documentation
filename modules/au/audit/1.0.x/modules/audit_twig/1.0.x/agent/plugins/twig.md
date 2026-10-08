<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Audit: Twig — the `twig` analyzer

`TwigAnalyzer` (`src/Plugin/AuditAnalyzer/TwigAnalyzer.php`), a `Drupal\audit\AuditAnalyzerBase` subclass declared with
`#[AuditAnalyzer(id: 'twig', output_directory: 'twig', weight: 2)]`.

## Install / enable

- Enable: `drush en audit_twig` (pulls in audit).
- Requirements (`checkRequirements()`): None — pure Drupal/config inspection.
- Appears as a secondary tab and detail page under **Reports → Audit** once the parent `audit` module is enabled.

## What it analyzes

audit_twig registers the `twig` AuditAnalyzer plugin (TwigAnalyzer). It reads Twig templates from the scan directories and flags cache-metadata bubbling problems (raw entity/field access that breaks cache tags), Twig anti-patterns (DB queries in templates, business logic in markup), field-rendering optimization opportunities, and unmanaged external-library references in `*.libraries.yml`; informational sections cover theme suggestions and preprocess anti-patterns discovered in `.theme`/`.php`. Each check can be suppressed with an `ignore_*` flag. Detected code appears via the escaped `audit_code` component, and remediation guidance is rendered inline.

### Scored checks (contribute to the score)
- `cache_bubbling` — Cache Bubbling
- `anti_patterns` — Twig Anti-Patterns
- `field_sync` — Field Rendering Optimization
- `external_libraries` — External Libraries

### Informational checks (no score)
- `theme_suggestions` — Theme Suggestions
- `preprocess_antipatterns` — Preprocess Anti-Patterns

## Configuration

Config object **`audit_twig.settings`** (defaults in `config/install/audit_twig.settings.yml`, schema in `config/schema/audit_twig.schema.yml`). Values are edited on the parent **`audit.settings`** form (the base module auto-collects `buildConfigurationForm()` output and saves via `processConfigurationValue()`).

| Key | Default |
|---|---|
| `ignore_cache_analysis` | `False` |
| `ignore_anti_patterns` | `False` |
| `ignore_field_sync` | `False` |
| `ignore_theme_suggestions` | `False` |
| `ignore_preprocess_analysis` | `False` |
| `ignore_external_libraries` | `False` |


## Operating it

- **UI**: `/admin/reports/audit/twig` (permission `view audit results`); settings under
  `/admin/reports/audit/settings` (permission `administer audit configuration`).
- **Cron**: queued into `audit_processor` by the parent `hook_cron()`; the score is recalculated into the Project Score.
- **Drush**: `drush audit:run twig --format=json`; filter with `--filter="severity:error"` /
  `--filter="module:<name>"`; discover filter values with `drush audit:filters twig`.
- **Output contract**: `analyze()` returns `['_files' => [...], 'score' => ['factors' => [...]]]`. Sections map to
  checks via `getAuditChecks()`; the base class renders scored sections as faceted issue lists and informational
  sections as tables. Only the score is persisted (State API via `audit.score_storage`); result rows are regenerated
  on each view.
