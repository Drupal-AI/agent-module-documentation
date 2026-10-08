<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration & tracking modes

## Install / enable
`drush en content_reporting -y`. Depends on core `node` and `views`. `hook_schema()`
(`content_reporting.install`) creates two tables: `content_reporting_reports` (id, nid, uid, views,
interactions, title, gdpr_consent, report_date) and `content_reporting_interactions` (id, nid, uid,
interaction_type, element, duration, timestamp). GDPR features additionally need
`eu_cookie_compliance` installed and configured.

## Settings form
Route `content_reporting.settings` at `/admin/config/content-reporting`, permission
`content reporting admin`. Class `Drupal\content_reporting\Form\ContentReportingSettingsForm`
(a `ConfigFormBase`) edits config object **`content_reporting.settings`** with four boolean
checkboxes:

| Key | Effect |
|-----|--------|
| `track_gdpr` | Read `Drupal.eu_cookie_compliance.hasAgreed()` and store a consent flag; adds the GDPR column/filter to the dashboard. |
| `track_clicks` | JS binds click handlers to `a, button, .track-click`; adds the per-element Clicks column. |
| `track_time_spent` | JS posts a cumulative `time_spent` interaction every 10s; adds the Time Spent column. |
| `track_logged_in_users` | Adds a uid group-by and a "User" (Authenticated/Anonymous) column. |

Note: the module ships **no** `config/install` default and **no** `config/schema` — the config
object is created only on first save, so all four keys read as empty/false until the form is saved.

## How tracking is attached
`content_reporting_preprocess_page()` (`content_reporting.module`) runs on every page; when the route
has a `node` parameter it attaches the `content_reporting/track_node` library and passes
`drupalSettings.content_reporting` = `{ csrfToken, nodeId, settings:{track_gdpr, track_clicks,
track_time_spent} }`. `js/track.js` reads those flags to decide which events to send.

## Cron / retention
`content_reporting_cron()` calls `content_reporting_clean_old_data()`, which deletes
`content_reporting_reports` rows whose `report_date` is older than 30 days
(`\Drupal::time()->getRequestTime() - 30*24*60*60`). The two queue workers also run on cron
(`cron = {"time" = 60}`) to drain the tracking queues into the tables.

## Legacy quirk
`content_reporting.module` still defines a D7-style `hook_permission()` and `hook_menu()`; these are
not invoked by Drupal 9+ (permissions come from `content_reporting.permissions.yml`, the menu from
`content_reporting.routing.yml` / `*.links.*.yml`), so the `hook_permission()` body that grants
`track content views` to every role is dead code on a modern site.
