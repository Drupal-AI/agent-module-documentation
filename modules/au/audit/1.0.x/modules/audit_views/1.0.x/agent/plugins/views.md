<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Audit: Views — the `views` analyzer

`ViewsAnalyzer` (`src/Plugin/AuditAnalyzer/ViewsAnalyzer.php`), a `Drupal\audit\AuditAnalyzerBase` subclass declared with
`#[AuditAnalyzer(id: 'views', output_directory: 'views', weight: 3)]`.

## Install / enable

- Enable: `drush en audit_views` (pulls in audit, views).
- Requirements (`checkRequirements()`): Requires core Views module
- Appears as a secondary tab and detail page under **Reports → Audit** once the parent `audit` module is enabled.

## What it analyzes

audit_views registers the `views` AuditAnalyzer plugin (ViewsAnalyzer) and depends on core Views. It scans View config entities for missing/weak display caching, excessive relationships (above the configurable `relationships_threshold`), overly-generic cache tags that cause broad invalidation, and displays exposing data to anonymous users; when Search API views are present it also flags rendering and caching pitfalls specific to Search API. An admin can exclude specific views from cache checks (`cache_excluded_views`), skip disabled views, and enable Search-API-on-MySQL detection. Scored issue sections are complemented by display and cache overviews.

### Scored checks (contribute to the score)
- `cache_issues` — Cache Issues
- `relationship_issues` — Relationship Issues
- `cache_tag_issues` — Generic Cache Tags
- `anonymous_access_issues` — Anonymous Access
- `searchapi_issues` — Search API Rendering Issues
- `searchapi_cache_issues` — Search API Cache Issues

### Informational checks (no score)
- `displays_status` — View Displays Overview
- `searchapi_cache_status` — Search API Cache Overview

## Configuration

Config object **`audit_views.settings`** (defaults in `config/install/audit_views.settings.yml`, schema in `config/schema/audit_views.schema.yml`). Values are edited on the parent **`audit.settings`** form (the base module auto-collects `buildConfigurationForm()` output and saves via `processConfigurationValue()`).

| Key | Default |
|---|---|
| `relationships_threshold` | `3` |
| `detect_searchapi_mysql` | `False` |
| `cache_excluded_views` | `"watchdog\nredirect_404"` |
| `exclude_disabled_views` | `True` |


## Operating it

- **UI**: `/admin/reports/audit/views` (permission `view audit results`); settings under
  `/admin/reports/audit/settings` (permission `administer audit configuration`).
- **Cron**: queued into `audit_processor` by the parent `hook_cron()`; the score is recalculated into the Project Score.
- **Drush**: `drush audit:run views --format=json`; filter with `--filter="severity:error"` /
  `--filter="module:<name>"`; discover filter values with `drush audit:filters views`.
- **Output contract**: `analyze()` returns `['_files' => [...], 'score' => ['factors' => [...]]]`. Sections map to
  checks via `getAuditChecks()`; the base class renders scored sections as faceted issue lists and informational
  sections as tables. Only the score is persisted (State API via `audit.score_storage`); result rows are regenerated
  on each view.
