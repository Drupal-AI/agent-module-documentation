<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Audit: Updates — the `updates` analyzer

`UpdatesAnalyzer` (`src/Plugin/AuditAnalyzer/UpdatesAnalyzer.php`), a `Drupal\audit\AuditAnalyzerBase` subclass declared with
`#[AuditAnalyzer(id: 'updates', output_directory: 'updates', weight: 5)]`.

## Install / enable

- Enable: `drush en audit_updates` (pulls in audit, update).
- Requirements (`checkRequirements()`): Requires core Update Status (update) module
- Appears as a secondary tab and detail page under **Reports → Audit** once the parent `audit` module is enabled.

## What it analyzes

audit_updates registers the `updates` AuditAnalyzer plugin (UpdatesAnalyzer, weight 5) and depends on core's Update Status (update) module. It reads the update-status data to score the health of the update system itself (data availability/freshness), pending security updates (heavily weighted), and pending regular updates; an informational section reports next-major-version compatibility. Regular (non-security) updates can be de-emphasized with the `ignore_regular_updates` setting so the score reflects only security exposure.

### Scored checks (contribute to the score)
- `update_health` — Update System Health
- `security` — Security Updates
- `regular` — Regular Updates

### Informational checks (no score)
- `compatibility` — Next Version Compatibility

## Configuration

Config object **`audit_updates.settings`** (defaults in `config/install/audit_updates.settings.yml`, schema in `config/schema/audit_updates.schema.yml`). Values are edited on the parent **`audit.settings`** form (the base module auto-collects `buildConfigurationForm()` output and saves via `processConfigurationValue()`).

| Key | Default |
|---|---|
| `ignore_regular_updates` | `False` |


## Operating it

- **UI**: `/admin/reports/audit/updates` (permission `view audit results`); settings under
  `/admin/reports/audit/settings` (permission `administer audit configuration`).
- **Cron**: queued into `audit_processor` by the parent `hook_cron()`; the score is recalculated into the Project Score.
- **Drush**: `drush audit:run updates --format=json`; filter with `--filter="severity:error"` /
  `--filter="module:<name>"`; discover filter values with `drush audit:filters updates`.
- **Output contract**: `analyze()` returns `['_files' => [...], 'score' => ['factors' => [...]]]`. Sections map to
  checks via `getAuditChecks()`; the base class renders scored sections as faceted issue lists and informational
  sections as tables. Only the score is persisted (State API via `audit.score_storage`); result rows are regenerated
  on each view.
