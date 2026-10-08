<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Google Analytics Reports

## Settings form

Route `google_analytics_reports_api.settings` → `/admin/config/services/google-analytics-reports-api`
(the API submodule's form, which this module **overrides** to add field-import controls).
Requires permission `administer google analytics reports api`. Fields:

- **Property ID** — the GA4 property id → `google_analytics_reports_api.settings:property`.
- **Credential JSON** — a managed-file upload of the service-account key; stored as a file id
  → `google_analytics_reports_api.settings:json`. Needs private-file support.
- **Query cache** — select of cache duration → `google_analytics_reports_api.settings:cache_length`
  (seconds; default `259200` = 3 days).
- **Import fields** (added by this module) — Batch that calls
  `GoogleAnalyticsReports::importFields()` to (re)populate the GA dimensions/metrics used in
  Views. Only shown once the account authenticates. Last run time is stored in this module's
  own config `google_analytics_reports.settings:metadata_last_time`.

Credentials come from a Google Cloud service account with the *Google Analytics Data API*
enabled, added as a Viewer on the GA property. See README for the click-path in Google Cloud.

## Reports, pages and blocks

- Summary report page: `/admin/reports/google-analytics-reports/summary`.
- Blocks (place at `/admin/structure/block`): *Google Analytics Reports Summary Block* and
  *Google Analytics Reports Page Block*.
- Graphical charts require the contrib **Charts** module (Google Charts / Highcharts sub-module).

## Permission

- `access google analytics reports` — view the GA report pages (defined by this module).
- `administer google analytics reports api` — access the settings form (defined by the API submodule).

## Config objects

| Config | Key | Owner | Meaning |
|---|---|---|---|
| `google_analytics_reports.settings` | `metadata_last_time` | this module | unix ts of last field import (`''` = never) |
| `google_analytics_reports_api.settings` | `property`, `json`, `cache_length` | API submodule | GA4 property, credential file id, cache seconds |

Read/set from drush:

```bash
drush cget google_analytics_reports.settings metadata_last_time
drush cget google_analytics_reports_api.settings cache_length
```

## Drush note

The shipped `google_analytics_reports.drush.inc` (command `google-analytics-reports-fields`,
alias `garf`) is a **legacy Drush 8 stub** that modern Drush does not load and whose callback
only logs "Drush support is not available now". Import fields via the settings form, not Drush.
