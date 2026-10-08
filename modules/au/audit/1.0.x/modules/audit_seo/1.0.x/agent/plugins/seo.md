<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Audit: SEO — the `seo` analyzer

`SeoAnalyzer` (`src/Plugin/AuditAnalyzer/SeoAnalyzer.php`), a `Drupal\audit\AuditAnalyzerBase` subclass declared with
`#[AuditAnalyzer(id: 'seo', output_directory: 'seo', weight: 3)]`.

## Install / enable

- Enable: `drush en audit_seo` (pulls in audit).
- Requirements (`checkRequirements()`): None — pure Drupal/config inspection.
- Appears as a secondary tab and detail page under **Reports → Audit** once the parent `audit` module is enabled.

## What it analyzes

audit_seo registers the `seo` AuditAnalyzer plugin (SeoAnalyzer). It checks for essential SEO modules (metatag, pathauto, simple_sitemap, redirect), scores URL-pattern coverage from pathauto per entity type, reviews image fields for alt-text configuration, and parses the site's `robots.txt` (read from fixed docroot paths). Per-check ignore flags let an admin suppress modules they deliberately do not use (e.g. `ignore_metatag`, `ignore_pathauto_node`, `ignore_simple_sitemap`). Scored issue sections are complemented by informational status overviews.

### Scored checks (contribute to the score)
- `essential_modules_issues` — Essential SEO Modules
- `url_structure_issues` — URL Pattern Issues
- `media_seo_issues` — Image Field Issues
- `robots_txt_issues` — Robots.txt Issues

### Informational checks (no score)
- `modules_status` — SEO Modules Status
- `url_structure_status` — URL Patterns Overview
- `media_seo_status` — Image Fields Overview
- `robots_txt_status` — Robots.txt Analysis

## Configuration

Config object **`audit_seo.settings`** (defaults in `config/install/audit_seo.settings.yml`, schema in `config/schema/audit_seo.schema.yml`). Values are edited on the parent **`audit.settings`** form (the base module auto-collects `buildConfigurationForm()` output and saves via `processConfigurationValue()`).

| Key | Default |
|---|---|
| `ignore_simple_sitemap` | `False` |
| `ignore_robots_sitemap` | `False` |
| `ignore_metatag` | `False` |
| `ignore_pathauto` | `False` |
| `ignore_pathauto_node` | `False` |
| `ignore_pathauto_taxonomy_term` | `False` |
| `ignore_pathauto_user` | `False` |
| `ignore_pathauto_media` | `False` |


## Operating it

- **UI**: `/admin/reports/audit/seo` (permission `view audit results`); settings under
  `/admin/reports/audit/settings` (permission `administer audit configuration`).
- **Cron**: queued into `audit_processor` by the parent `hook_cron()`; the score is recalculated into the Project Score.
- **Drush**: `drush audit:run seo --format=json`; filter with `--filter="severity:error"` /
  `--filter="module:<name>"`; discover filter values with `drush audit:filters seo`.
- **Output contract**: `analyze()` returns `['_files' => [...], 'score' => ['factors' => [...]]]`. Sections map to
  checks via `getAuditChecks()`; the base class renders scored sections as faceted issue lists and informational
  sections as tables. Only the score is persisted (State API via `audit.score_storage`); result rows are regenerated
  on each view.
