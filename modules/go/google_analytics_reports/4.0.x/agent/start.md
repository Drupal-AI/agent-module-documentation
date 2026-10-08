<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Google Analytics Reports — agent index

Displays **Google Analytics 4** data in Drupal via **Views**. Adds a GA Views query backend,
imports GA dimensions/metrics as Views fields, and ships report pages/blocks. Requires `file`
and its submodule **google_analytics_reports_api** (which holds the GA credentials and does the
API calls). External Google service — most features need valid GA4 credentials to return data.

- **Settings form, field import, report pages/blocks, permission, cache** →
  [configure/settings.md](configure/settings.md)
- **Field import, the `google_analytics_reports_fields` table, the Views query plugin** →
  [api/fields-and-views.md](api/fields-and-views.md)
- **Alter imported GA field metadata** →
  [hooks/field-import.md](hooks/field-import.md)

Key facts:
- `configure` route = `google_analytics_reports_api.settings`
  (`/admin/config/services/google-analytics-reports-api`); this module overrides that form to
  add the **Import fields** controls (`GoogleAnalyticsReports::importFields()`).
- Own config: `google_analytics_reports.settings` → `metadata_last_time` (unix timestamp of the
  last GA field import; `''` = never). Cache length lives in the API submodule's config.
- Permission: `access google analytics reports`.
- DB table: `google_analytics_reports_fields` (imported GA dimensions/metrics).
- Optional Views: `google_analytics_summary`, `google_analytics_reports_page`.
- A `google_analytics_reports.drush.inc` exists but is a **non-functional legacy Drush 8 stub**
  (its callback only logs "Drush support is not available now"); do not rely on it.
