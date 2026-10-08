<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Audit: Search API — the `search_api` analyzer

`SearchApiAnalyzer` (`src/Plugin/AuditAnalyzer/SearchApiAnalyzer.php`), a `Drupal\audit\AuditAnalyzerBase` subclass declared with
`#[AuditAnalyzer(id: 'search_api', output_directory: 'search_api', weight: 3)]`.

## Install / enable

- Enable: `drush en audit_search_api` (pulls in audit, search_api).
- Requirements (`checkRequirements()`): Requires the contrib search_api module (hard dependency)
- Appears as a secondary tab and detail page under **Reports → Audit** once the parent `audit` module is enabled.

## What it analyzes

audit_search_api registers the `search_api` AuditAnalyzer plugin (SearchApiAnalyzer) and hard-depends on the contrib Search API module. It inspects each configured Search API server (backend availability/reachability) and index (enabled/read-only state, tracked vs indexed item counts, pending items) and produces two scored sections — Servers and Indexes — surfacing unreachable servers, disabled or stale indexes, and indexing backlogs. Ships no config of its own.

### Scored checks (contribute to the score)
- `servers` — Search API Servers
- `indexes` — Search API Indexes

### Informational checks (no score)
- (none)

## Configuration

No configuration object — this analyzer ships no `config/install` and no settings form fields.


## Operating it

- **UI**: `/admin/reports/audit/search_api` (permission `view audit results`); settings under
  `/admin/reports/audit/settings` (permission `administer audit configuration`).
- **Cron**: queued into `audit_processor` by the parent `hook_cron()`; the score is recalculated into the Project Score.
- **Drush**: `drush audit:run search_api --format=json`; filter with `--filter="severity:error"` /
  `--filter="module:<name>"`; discover filter values with `drush audit:filters search_api`.
- **Output contract**: `analyze()` returns `['_files' => [...], 'score' => ['factors' => [...]]]`. Sections map to
  checks via `getAuditChecks()`; the base class renders scored sections as faceted issue lists and informational
  sections as tables. Only the score is persisted (State API via `audit.score_storage`); result rows are regenerated
  on each view.
