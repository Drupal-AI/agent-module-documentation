<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Analyze Google Analytics (analyze_google_analytics) — agent index

A submodule of **Analyze** that ships **one** `Plugin/Analyze` plugin: `GoogleAnalytics`
(id **`analytics`**, label "Google Analytics Entity Reports"). It surfaces GA data for the viewed
entity on its Analyze tab by executing a bundled View argued by the entity's URL alias. Depends on
`analyze`, `views`, `google_analytics_reports`, `google_analytics_reports_api`. Package `Analyze`.
Core `^10.3 || ^11`. GPL-2.0-or-later. Version 1.4.x.

- **The plugin, the View, setup gating and access** → [plugins/google-analytics.md](plugins/google-analytics.md)

## What it actually is

- `src/Plugin/Analyze/GoogleAnalytics.php` — `final class GoogleAnalytics extends
  AnalyzePluginBase`. Injects `path_alias.manager` and `entity_type.manager` beyond the base.
- Does **not** call the GA API itself — `getSummaryResults()` loads the `analyze_google_analytics`
  View (base table `google_analytics`, from google_analytics_reports_api), sets the entity's URL
  alias as the argument, and executes the `summary` / `full_report` display.
- `renderSummary()` → `analyze_table` (page views, views/user, bounce rate). `renderFullReport()`
  → core `table` of all GA metrics with humanized labels + formatted durations/percentages.
- `isApplicable()` / `isEnabled()` require `isGoogleAnalyticsReportsSetup()` (GA Reports API
  authenticated + `google_analytics_reports.settings:metadata_last_time` set). `hook_install`
  warns if not configured.
- `access()` is **overridden** to require permission `access google analytics reports` (from
  google_analytics_reports) — an extra gate on top of the parent's `view analyze reports`.
- `extraSummaryLinks()` adds a link to `view.google_analytics_summary.page_1`.
- Config: `config/install/views.view.analyze_google_analytics.yml`. `hook_uninstall` deletes it.
  `analyze_google_analytics_update_8001` standardizes the View's submit button text.
