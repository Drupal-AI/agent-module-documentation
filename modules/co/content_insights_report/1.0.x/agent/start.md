<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Content Insights Report (content_insights_report) — agent index

Two admin report pages that aggregate **node** content: a per-type/status summary with
percentages, monthly created/updated/revision activity, an optional moderation-state summary, and a
paged filterable node listing. No new entities, fields or plugin types — it queries the node tables
and renders through its own themes.

- **Version dir:** 1.0.x (installed 1.0.11). `core_version_requirement: ^10.1 || ^11 || ^12`.
- **Dependencies:** `drupal:node` only. `content_moderation` is optional (enables the
  moderation-state sections when present). `configure` route: `content_insights_report.report_settings`.
- **Submodule:** `content_insights_report_group` (Group-scoped version) — documented in
  `../../modules/content_insights_report_group/1.0.x/agent/start.md`.

## Provides

- **Routes** (`content_insights_report.routing.yml`):
  - `content_insights_report.report_settings` — settings form, `/admin/config/content/content_insights_report/report-settings`, perm `administer content_insights_report settings`.
  - `content_insights_report.report` — summary report, `/admin/reports/content-insights-report`, perm `view content_insights_report report`.
  - `content_insights_report.content_display` — node listing, `/admin/reports/content-insights-report/content`, perms `access content overview, access content, view content_insights_report report`.
  - `content_insights_report.update_filters` — writes filters to the caller's own tempstore then redirects, perm `access content`.
- **Permissions** (`.permissions.yml`): `administer content_insights_report settings`, `view content_insights_report report` (both `restrict access: true`). Note: the two `access content*` core permissions used by the listing route are not defined here — they are core.
- **Config:** `content_insights_report.settings` (config_object; schema + install defaults present).
- **Controllers:** `ContentInsightsReportController` (summary + `updateFilters`), `ContentController` (node listing). **Forms:** `ContentInsightsReportConfigForm`, `ContentReportFilterForm`. **Hooks:** `Hook\ContentInsightsReportHooks` (help, theme — OOP `#[Hook]` + `#[LegacyHook]` shims).
- **Themes:** `content_insights_report`, `content_display` (templates in `templates/`). **Libraries:** `content_insights_report/content_insights_report`, `content_insights_report/content_display`.

## Solution docs

- Configuration + settings keys: `config/settings.md`
- Report pages, routes, queries & access model: `api/queries.md`
