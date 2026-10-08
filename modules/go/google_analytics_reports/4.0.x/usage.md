<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Google Analytics Reports displays Google Analytics 4 statistics inside a Drupal site using Views. It adds a Views query backend (plus GA field/filter/argument plugins) that runs against the Google Analytics Data API, ships summary/report Views, blocks and report pages, and imports the list of available GA dimensions and metrics as Views fields.

---

The module builds on its required submodule **Google Analytics Reports API**, which holds the credentials (a service-account JSON key + GA4 Property ID) and does the actual API calls; this module adds the reporting layer on top. Its Views query plugin lets you create Views whose rows are GA data, using imported GA **dimensions and metrics** as fields, filters and arguments — the field list is imported into a `google_analytics_reports_fields` database table via the settings form's *Import fields* button (which runs a Batch calling `GoogleAnalyticsReports::importFields()`). It ships two optional Views (`google_analytics_summary`, `google_analytics_reports_page`), a Summary report at `admin/reports/google-analytics-reports/summary`, and Summary/Page blocks you can place. Graphical charts require the contrib *Charts* module (Google Charts or Highcharts sub-module). Because Google enforces API quotas, query results are cached for a configurable duration (`cache_length`, default 3 days). The module's configure route is the API submodule's settings form (`google_analytics_reports_api.settings`, at `admin/config/services/google-analytics-reports-api`), which this module overrides to add the field-import controls. A single permission, `access google analytics reports`, gates the report pages. Note: a legacy `google_analytics_reports.drush.inc` exists but is a non-functional Drush 8 stub. Requires `file` and the API submodule; the underlying data comes from an external Google service, so most configuration only becomes useful once valid GA credentials are supplied.

---

- Show a Google Analytics 4 summary report inside the Drupal admin (`admin/reports/google-analytics-reports/summary`).
- Build a custom View of GA metrics (sessions, users, page views) using the GA Views query backend.
- Add GA dimensions (page path, country, device) as Views fields, filters and arguments.
- Place a "Google Analytics Reports Summary" block on a dashboard.
- Place a path-based "Google Analytics Reports Page" block showing stats for the current page.
- Import the catalogue of available GA fields into the `google_analytics_reports_fields` table for use in Views.
- Filter a GA report View by a date range (start_date / end_date filters).
- Combine with the Charts module to render GA data as graphs.
- Gate access to GA report pages with the `access google analytics reports` permission.
- Cache GA query results for a set period to stay within Google's API quota.
- Create a "top pages this week" View from Analytics data.
- Show per-country or per-device breakdowns of traffic via GA dimensions.
- Expose a GA report View as a page with a contextual path argument.
- Refresh the available GA field list after Google adds new dimensions/metrics (re-import fields).
- Alter imported GA field metadata with `hook_google_analytics_reports_field_import_alter`.
- Present analytics to editors without giving them access to the Google Analytics console.
- Embed a GA report View block in a custom admin dashboard.
- Reuse the summary/report Views as starting points for bespoke analytics displays.
- Track when GA fields were last imported via `google_analytics_reports.settings:metadata_last_time`.
- Provide site-owner-facing traffic reporting sourced from GA4.
- Configure the GA4 Property ID and service-account credentials through the module's settings form.
- Scope report visibility to trusted roles by assigning the access permission.
- Build a landing-page performance View filtered by page path.
