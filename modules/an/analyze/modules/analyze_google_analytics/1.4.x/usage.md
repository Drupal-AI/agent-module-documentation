<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Analyze Google Analytics adds one Analyze plugin that shows Google Analytics data (page views, views per user, bounce rate) for the viewed entity on its Analyze tab.

---

This submodule of Analyze provides a single `Plugin/Analyze` plugin, `GoogleAnalytics` (id `analytics`, label "Google Analytics Entity Reports"). It does not call the GA API directly: it loads a bundled View, `analyze_google_analytics` (base table `google_analytics`, supplied by the Google Analytics Reports API module), sets the entity's URL alias as the View argument, and executes the `summary` or `full_report` display. The summary renders an `analyze_table` with page views, page views per user (2 dp) and bounce rate; the full report renders a core table of all returned metrics with humanized labels and formatted durations/percentages. The analyzer is only `isApplicable()` / `isEnabled()` once Google Analytics Reports is authenticated and its metadata import has run (`isGoogleAnalyticsReportsSetup()` checks `GoogleAnalyticsReportsApiFeed::service()->isAuthenticated()` and `google_analytics_reports.settings:metadata_last_time`), and `hook_install` warns if not. Display access is gated by the `access google analytics reports` permission (overridden `access()`). It also exposes an extra summary link to the sitewide GA report and, on uninstall, deletes its View. Depends on `analyze`, `views`, `google_analytics_reports`, `google_analytics_reports_api`.

---

- Show editors Google Analytics page views for the exact page they are editing.
- Show page-views-per-user and bounce rate for a node/entity on its Analyze tab.
- Give a full GA metrics report per entity (sessions per user, engagement rate, durations, etc.).
- Keep GA insights in the same "Analyze" tab as word counts and other analyzers.
- Link editors from the entity summary to the sitewide Google Analytics report.
- Restrict GA visibility to roles holding `access google analytics reports`.
- Automatically hide the analyzer until Google Analytics Reports is configured and imported.
- Argue GA data by URL alias so per-page metrics line up with the entity's canonical path.
- Enable per content type/bundle from the bundle edit form's "Analyze settings" section.
- Toggle centrally at Configuration > Content > Content Analysis.
- Reuse the shipped `analyze_google_analytics` View (summary + full_report displays) as a starting point.
- Suppress the full-report link automatically when there is no GA data for a page.
- Show a "No data" row when GA has nothing recorded for the entity.
- Format bounce/engagement rates as percentages and durations in seconds in the full report.
- Combine GA metrics with SEO/readability analyzers for a single content-performance view.
- Uninstall cleanly (the module removes its View on uninstall).
- Run GA analysis in bulk across a content type via `drush analyze:batch`.
