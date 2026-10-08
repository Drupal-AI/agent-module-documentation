<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Reporting dashboard, routes & permissions

Class `Drupal\content_reporting\Controller\ContentReportingController` (extends `ControllerBase`;
DI: `current_user`, `database`, `logger.factory:content_reporting`, `form_builder`,
`config.factory`).

## Routes & permissions
| Route | Path | Method | Requirement |
|-------|------|--------|-------------|
| `content_reporting.dashboard` | `/admin/content-reporting/dashboard` | GET | `_permission: 'content reporting view'` |
| `content_reporting.export_to_csv` | `/admin/content-reporting/export-to-csv` | GET | `_permission: 'content reporting view'` |
| `content_reporting.settings` | `/admin/config/content-reporting` | GET/POST | `_permission: 'content reporting admin'` |

Both `content reporting view` and `content reporting admin` are declared `restrict access: true`
in `content_reporting.permissions.yml`. The dashboard link is placed under `system.admin_reports`
(`content_reporting.links.menu.yml`); Dashboard/Settings tabs come from
`content_reporting.links.task.yml`.

## getReport()
Builds a render array (not the JSON its docblock claims). Steps:
1. Re-checks `content reporting view` (returns a 403 `JsonResponse` if missing — redundant with the
   route requirement).
2. Selects from `content_reporting_reports` with `PagerSelectExtender` (`->limit(10)`), distinct,
   fields `nid,title` (+ `gdpr_consent`, `uid` when those modes are on).
3. Columns are conditional on `content_reporting.settings`: Clicks, Time Spent, GDPR count, User.
4. Filters from query params: `title` (LIKE `%value%`), `start_date`/`end_date`
   (`strtotime()` vs `report_date`), and a `gdpr_consent` band that adds a
   `(r.gdpr_consent / r.views) * 100` expression and `HAVING` bounds (`:min`/`:max` placeholders).
5. Sort: `order` param is lowercased and **whitelisted** via
   `in_array($sort, ['nid','title','views','clicks','time_spent','gdpr_consent'])`; direction from
   `sort` param uppercased (`orderBy` validates ASC/DESC).
6. `SUM(r.views) AS total_views`, `GROUP BY r.nid, r.title` (+ `r.uid` when logged-in tracking on).
7. Per row, when `track_clicks`: a second query on `content_reporting_interactions`
   (`interaction_type='click'`, matching nid/uid) counts clicks per `element`; when
   `track_time_spent`: sums `duration` for `time_spent` interactions and formats via
   `formatTimeSpentWithDateTime()` (ms → `H:i:s`).
8. Renders a `#type => table` with a filter form (`ContentReportingFiltersForm`), an "Export to CSV"
   link that forwards the current query, and a `#type => pager`. Attaches
   `content_reporting/content_reporting.styles`.

All aggregation uses the DB query builder with bound placeholders; there is no string-concatenated
SQL.

## exportToCsv()
Re-runs the same title/date filters against `content_reporting_reports` (fields
`nid,title,views,gdpr_consent`) and streams a CSV (`StreamedResponse`, `fputcsv`, headers
`Content-Type: text/csv`, `Content-Disposition: attachment; filename="content_report.csv"`).

## Filter form
`Drupal\content_reporting\Form\ContentReportingFiltersForm` (`FormBase`): textfield `title`, date
`start_date`/`end_date`, and (only when `track_gdpr`) a `gdpr_consent` select with bands
`0_cons,0_25,25_50,50_70,70_100`. Submit redirects to `content_reporting.dashboard` with the values
as query params; Reset redirects with none.
