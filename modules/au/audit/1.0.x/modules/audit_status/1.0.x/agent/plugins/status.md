<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Audit: Status — the `status` analyzer

`StatusAnalyzer` (`src/Plugin/AuditAnalyzer/StatusAnalyzer.php`), a `Drupal\audit\AuditAnalyzerBase` subclass declared with
`#[AuditAnalyzer(id: 'status', output_directory: 'status', weight: 4)]`.

## Install / enable

- Enable: `drush en audit_status` (pulls in audit).
- Requirements (`checkRequirements()`): None — pure Drupal/config inspection.
- Appears as a secondary tab and detail page under **Reports → Audit** once the parent `audit` module is enabled.

## What it analyzes

audit_status registers the `status` AuditAnalyzer plugin (StatusAnalyzer). It reports system information and scores the PHP version, key PHP ini settings (memory_limit, disabled functions, allow_url_fopen, etc.), the database engine version (queried via `SHOW VARIABLES` with a bound placeholder), database configuration, and Drupal core's own requirements/status report. Where the environment permits, it reads the running web-server version via static `shell_exec` probes (`nginx -v`, `apache2 -v`), gracefully reporting 'unknown' when `shell_exec` is disabled. Ships no config of its own.

### Scored checks (contribute to the score)
- `php_version` — PHP Version
- `php_config` — PHP Configuration
- `database_version` — Database Version
- `database_config` — Database Configuration
- `requirements` — System Requirements

### Informational checks (no score)
- `system_info` — System Information

## Configuration

No configuration object — this analyzer ships no `config/install` and no settings form fields.


## Operating it

- **UI**: `/admin/reports/audit/status` (permission `view audit results`); settings under
  `/admin/reports/audit/settings` (permission `administer audit configuration`).
- **Cron**: queued into `audit_processor` by the parent `hook_cron()`; the score is recalculated into the Project Score.
- **Drush**: `drush audit:run status --format=json`; filter with `--filter="severity:error"` /
  `--filter="module:<name>"`; discover filter values with `drush audit:filters status`.
- **Output contract**: `analyze()` returns `['_files' => [...], 'score' => ['factors' => [...]]]`. Sections map to
  checks via `getAuditChecks()`; the base class renders scored sections as faceted issue lists and informational
  sections as tables. Only the score is persisted (State API via `audit.score_storage`); result rows are regenerated
  on each view.
