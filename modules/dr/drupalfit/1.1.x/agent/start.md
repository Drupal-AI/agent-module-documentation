<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DrupalFit (drupalfit) — agent index

Site fitness/health **audit** module. Runs pluggable `fit_check` plugins (~58 in 1.1.3), groups them
into `fit_check_group` categories, computes severity-weighted 0–100 scores, saves each run as a
`fit_report_history` entity, and serves the latest as JSON. Optional cloud API pulls SEO/accessibility
scores. Package `DrupalFit`. Core `^10.2 || ^11`, PHP `>=8.1`. Deps: core `system`, `update`;
composer `league/commonmark:^2.0` (renders README on the Help tab). License GPL-2.0-or-later. Version 1.1.3.

## Solution docs

- **FitCheck / FitCheckGroup plugin types — write a check or a group** → [plugins/fit-check.md](plugins/fit-check.md)
- **Scoring model (FitWeight, FitScoreCalculator, Score/GroupScore, FitReportCollector, external scores)** → [api/scoring.md](api/scoring.md)
- **Routes, permissions, report pages, JSON API, FitReportHistory entity, batch, DrupalFitApiClient** → [api/routes.md](api/routes.md)
- **Submodule (CSV/JSON/HTML export)** → [../modules/drupalfit_report_export/1.1.x/agent/start.md](../modules/drupalfit_report_export/1.1.x/agent/start.md)

## What it provides

- **Plugin types** (attribute-based, `src/Attribute/`): `fit_check` (`FitCheckPluginManager`, dir
  `Plugin/FitCheck`, interface `FitCheckInterface`, base `FitCheckPluginBase`) and `fit_check_group`
  (`FitCheckGroupPluginManager`, dir `Plugin/FitCheckGroup`). Alter hooks `fit_check_info`,
  `fit_check_group_info`.
- **6 groups** (`src/Plugin/FitCheckGroup/`): `security` (scoreWeight 30), `performance` (20),
  `best_practices` (15), `seo` (15, externalProvider), `accessibility` (10, externalProvider),
  `content_and_config` (10).
- **Services** (`drupalfit.services.yml`): `drupalfit.report_collector`
  (`Service\FitReportCollector`, implements `FitReportCollectorInterface`), `drupalfit.api_client`
  (`Service\DrupalFitApiClient`), plus the two plugin managers.
- **Entity**: `fit_report_history` (content entity, `src/Entity/FitReportHistory.php`) — stores each
  run's `report_result` + `report_score` JSON; list builder `FitReportHistoryListBuilder`;
  `admin_permission = "administer fit_report_history"`.
- **Routes** (`drupalfit.routing.yml`): report, run, help, DrupalFit iframe tab, settings form,
  JSON API. **Permissions** (`drupalfit.permissions.yml`): `view drupalfit reports`,
  `administer drupalfit`, `administer fit_report_history`.
- **Config**: `drupalfit.settings` (`api_key`, `domain`); schema in `config/schema/`. Two
  `system.action` configs for the history list (save/delete). No Drush commands.
- **Value objects**: `FitResult`(+`Collection`), `Score`, `GroupScore`(+`Collection`),
  `FitScoreResult`, `AuditScores`, enum `Enum\FitWeight`, `FitResultGrouper`, `FitScoreCalculator`,
  batch `Batch\FitReportBatch`.

## Key facts

- Running a report is a **batch** (`Controller\DrupalFitReport::runReport` → one operation per check →
  `FitReportBatch::finish` creates a `fit_report_history` entity). The report **page** shows the
  latest stored run; it does not re-run checks on view.
- The cloud API client only **sends the configured API key** to `https://be.drupalfit.com/api-key/scores`
  and **pulls** accessibility/SEO/performance scores — it does not upload the site report. TLS default
  (verify on). External URLs are hard-coded constants in `DrupalFitConstants` (no SSRF surface).
- The `https_enforcement` check makes outbound HTTP requests to the site's own host to test HTTP→HTTPS
  redirect and HSTS; the plain-HTTP probe sets `verify => FALSE` (irrelevant for `http://`, self-target).
