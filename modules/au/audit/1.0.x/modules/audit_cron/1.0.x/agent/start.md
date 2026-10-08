<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Audit Cron (audit_cron) — agent index

Analyzes cron tasks, queue workers, and cron execution status.

Submodule of the **audit** framework. Depends on: `audit`. Core `^10.2 || ^11 || ^12`. Version 1.0.11.

## Analyzer plugin

- Plugin id `cron` — `CronAnalyzer` (`src/Plugin/AuditAnalyzer/CronAnalyzer.php`), extends `AuditAnalyzerBase`, `#[AuditAnalyzer]` weight 2 (default Project-Score multiplier).
- Detail-page checks (`getAuditChecks()`): `status` (Cron Execution Status), `queue_workers` (Queue Workers), `hook_cron` (Hook Cron Implementations).

## Configuration

- Config object `audit_cron.settings` (schema `config/schema/audit_cron.schema.yml`, defaults `config/install/audit_cron.settings.yml`). Keys: `cron_stale_hours` (24), `queue_warning_threshold` (100).
- Edited via the module's group on the main audit settings form (`/admin/reports/audit/settings`); the analyzer's `buildConfigurationForm()` supplies the fields.

## Run it

- UI: Reports > Audit > `Audit Cron` detail page (runs live, `view audit results` permission).
- Drush: `drush audit:run cron` (JSON; add `--filter=...`, `--fail-on=error`), discover filters with `drush audit:filters cron`.

Parent framework + plugin API: [../../../../agent/start.md](../../../../agent/start.md), [../../../../agent/plugins/analyzer.md](../../../../agent/plugins/analyzer.md).
