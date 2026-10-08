<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Audit: URL — the `url` analyzer

`UrlAnalyzer` (`src/Plugin/AuditAnalyzer/UrlAnalyzer.php`), a `Drupal\audit\AuditAnalyzerBase` subclass declared with
`#[AuditAnalyzer(id: 'url', output_directory: 'url', weight: 3)]`.

## Install / enable

- Enable: `drush en audit_url` (pulls in audit).
- Requirements (`checkRequirements()`): Uses path_alias and/or redirect when present (at least one recommended)
- Appears as a secondary tab and detail page under **Reports → Audit** once the parent `audit` module is enabled.

## What it analyzes

audit_url registers the `url` AuditAnalyzer plugin (UrlAnalyzer). It detects the core Path Alias and contrib Redirect modules at runtime and only runs the applicable check groups. It analyzes redirect chains/loops, broken or non-resolving redirect targets, alias collisions (two aliases resolving to conflicting system paths), and aliases that shadow real routes. Findings are grouped into scored sections plus an informational overview. Ships no config of its own; warns if neither Redirect nor Path Alias is enabled.

### Scored checks (contribute to the score)
- (none)

### Informational checks (no score)
- `overview` — Overview

## Configuration

No configuration object — this analyzer ships no `config/install` and no settings form fields.


## Operating it

- **UI**: `/admin/reports/audit/url` (permission `view audit results`); settings under
  `/admin/reports/audit/settings` (permission `administer audit configuration`).
- **Cron**: queued into `audit_processor` by the parent `hook_cron()`; the score is recalculated into the Project Score.
- **Drush**: `drush audit:run url --format=json`; filter with `--filter="severity:error"` /
  `--filter="module:<name>"`; discover filter values with `drush audit:filters url`.
- **Output contract**: `analyze()` returns `['_files' => [...], 'score' => ['factors' => [...]]]`. Sections map to
  checks via `getAuditChecks()`; the base class renders scored sections as faceted issue lists and informational
  sections as tables. Only the score is persisted (State API via `audit.score_storage`); result rows are regenerated
  on each view.
