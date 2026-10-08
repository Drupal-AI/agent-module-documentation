<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DBLog Time Filter (dblog_time_filter) — agent index

Small utility that enhances Drupal Core's "Recent Log Messages" report (`/admin/reports/dblog`, the
core `watchdog` View) with a relative time-range filter and a live server clock. Pure Views/form
alter hooks plus one JS+CSS library — no config, routes, permissions, services, or plugins.

## What it provides
- `hook_form_FORM_ID_alter()` on `views_exposed_form` for the `watchdog` View: adds a **Time** select
  (`time_range_filter`) with relative options and a **Current Server Time** markup element; attaches
  the `dblog_time_filter/time_updater` library.
- `hook_views_query_alter()`: on the `watchdog` View, reads `time_range_filter` (seconds) from the
  exposed input and adds `watchdog.timestamp >= now - duration` to the query.
- `dblog_time_filter_exposed_form_submit()`: custom submit handler that shuttles the raw duration
  through the View's exposed input.
- Library `time_updater` (`dblog_time_filter.libraries.yml`): `js/dblog_time_updater.js` (moves the
  clock outside the form, ticks every second via a client/server offset) + `css/dblog-time-filter.css`
  (repositions clock, tightens form spacing). Depends on `core/jquery`, `core/drupal`.

## Dependencies
None declared (`dblog_time_filter.info.yml`). Effectively relies on core `dblog`/`views` providing the
`watchdog` View. `core_version_requirement: ^10 || ^11`.

## Provides
No permissions, routes, config objects/schema, services, drush commands, or plugin types. Access is
inherited from core's `access site reports` permission on the dblog report page.

## Solution docs
- [Watchdog exposed-form time filter & clock](hooks/watchdog-filter.md) — the two hooks, the submit
  handler, option values, and the JS/CSS library.
