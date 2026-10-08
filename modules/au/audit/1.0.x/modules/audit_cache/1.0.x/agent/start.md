<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Audit: Cache (audit_cache) — agent index

Analyzes cache bins, configuration, efficiency, and cache-related best practices.

Submodule of the **audit** framework. Depends on: `audit`. Core `^10.2 || ^11 || ^12`. Version 1.0.11.

## Analyzer plugin

- Plugin id `cache` — `CacheAnalyzer` (`src/Plugin/AuditAnalyzer/CacheAnalyzer.php`), extends `AuditAnalyzerBase`, `#[AuditAnalyzer]` weight 3 (default Project-Score multiplier).
- Detail-page checks (`getAuditChecks()`): `backend_issues` (Cache Backend Issues), `bin_issues` (Cache Bin Issues), `tag_issues` (Cache Tag Usage Issues), `bin_inventory` (Cache Bin Inventory), `backend_status` (Cache Configuration Status), `tag_invalidations` (Cache Tag Invalidations).

## Configuration

- Config object `audit_cache.settings` (schema `config/schema/audit_cache.schema.yml`, defaults `config/install/audit_cache.settings.yml`). Keys: `ignore_bin_analysis` (false), `ignore_backend_analysis` (false), `ignore_tag_analysis` (false), `ignore_tag_invalidation_analysis` (false).
- Edited via the module's group on the main audit settings form (`/admin/reports/audit/settings`); the analyzer's `buildConfigurationForm()` supplies the fields.

## Run it

- UI: Reports > Audit > `Audit: Cache` detail page (runs live, `view audit results` permission).
- Drush: `drush audit:run cache` (JSON; add `--filter=...`, `--fail-on=error`), discover filters with `drush audit:filters cache`.

Parent framework + plugin API: [../../../../agent/start.md](../../../../agent/start.md), [../../../../agent/plugins/analyzer.md](../../../../agent/plugins/analyzer.md).
