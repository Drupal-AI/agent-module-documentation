<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Audit: Watchdog — the `watchdog` analyzer

`WatchdogAnalyzer` (`src/Plugin/AuditAnalyzer/WatchdogAnalyzer.php`), a `Drupal\audit\AuditAnalyzerBase` subclass declared with
`#[AuditAnalyzer(id: 'watchdog', output_directory: 'watchdog', weight: 2)]`.

## Install / enable

- Enable: `drush en audit_watchdog` (pulls in audit, dblog).
- Requirements (`checkRequirements()`): Requires core Database Logging (dblog) module
- Appears as a secondary tab and detail page under **Reports → Audit** once the parent `audit` module is enabled.

## What it analyzes

audit_watchdog registers the `watchdog` AuditAnalyzer plugin (WatchdogAnalyzer) and depends on core dblog. It queries the {watchdog} table (parameterised UNION ALL across three time buckets — last 24 hours, last week, older) to aggregate the most frequent messages by type/severity, scoring each bucket, and surfaces recurring PHP errors and warnings. Watchdog message variables are unserialized with a strict class allow-list and messages are strip_tags-truncated before display. An informational overview summarizes log volume. Ships no config of its own.

### Scored checks (contribute to the score)
- `bucket_24h` — Last 24 hours
- `bucket_7d` — Last week
- `bucket_older` — Older entries

### Informational checks (no score)
- `overview` — Overview

## Configuration

No configuration object — this analyzer ships no `config/install` and no settings form fields.


## Operating it

- **UI**: `/admin/reports/audit/watchdog` (permission `view audit results`); settings under
  `/admin/reports/audit/settings` (permission `administer audit configuration`).
- **Cron**: queued into `audit_processor` by the parent `hook_cron()`; the score is recalculated into the Project Score.
- **Drush**: `drush audit:run watchdog --format=json`; filter with `--filter="severity:error"` /
  `--filter="module:<name>"`; discover filter values with `drush audit:filters watchdog`.
- **Output contract**: `analyze()` returns `['_files' => [...], 'score' => ['factors' => [...]]]`. Sections map to
  checks via `getAuditChecks()`; the base class renders scored sections as faceted issue lists and informational
  sections as tables. Only the score is persisted (State API via `audit.score_storage`); result rows are regenerated
  on each view.
