<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# GA fields import + Views query backend

## Field import

`Drupal\google_analytics_reports\GoogleAnalyticsReports` (static helpers):

| Method | Purpose |
|---|---|
| `importFields()` | Batch entry point (also the settings form's *Import fields* submit). Fetches the GA metadata (dimensions/metrics) via the API submodule and queues them. |
| `saveFields(array $field, &$context)` | Batch op: upsert one field row into `google_analytics_reports_fields`. |
| `importFieldsFinished($success, $results)` | Batch finish; stamps `google_analytics_reports.settings:metadata_last_time`. |

Imported rows live in the DB table **`google_analytics_reports_fields`** (columns: `gaid`,
`type`, `data_type`, `column_group`, `ui_name`, `description`, `calculation`; primary key
`gaid`). The helper `google_analytics_reports_get_fields()` (in the `.module`) reads them back.
The import needs working GA credentials in the API submodule.

## Views query backend

The module registers a Views **query** plugin (class `GoogleAnalyticsQuery`, a
`QueryPluginBase`) plus GA-specific Views handlers:

- fields: `GoogleAnalyticsStandard`
- filters: `GoogleAnalyticsString`, `GoogleAnalyticsNumeric`, `GoogleAnalyticsDate`
- argument: `GoogleAnalyticsArgument`, argument default `GoogleAnalyticsPath`
- wizard: `GoogleAnalyticsWizard`

A View using this query base pulls rows from the Google Analytics Data API instead of SQL; the
imported fields become the available Views fields/filters/arguments. The shipped optional Views
`google_analytics_summary` and `google_analytics_reports_page` are examples (each exposes
`start_date` / `end_date` filters). This module defines **no plugin *type* of its own** — these
are all core Views plugin types.

## Alter hook

Field metadata can be adjusted at import time — see
[../hooks/field-import.md](../hooks/field-import.md).
