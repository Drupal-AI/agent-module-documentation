<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Watchdog exposed-form time filter & live clock

All behaviour lives in `dblog_time_filter.module` (no `src/`). It targets the core `watchdog` View
that backs `/admin/reports/dblog`.

## Install / enable
`drush en dblog_time_filter -y`. No configuration, no permissions, no config to export. Requires core
`dblog` + `views` (the `watchdog` View). Works on Drupal 10/11.

## Exposed-form alter — `dblog_time_filter_form_views_exposed_form_alter()`
Implements `hook_form_FORM_ID_alter()` for `views_exposed_form`. Guards on
`$form_state->getStorage()['view']->id() === 'watchdog'`, so it only touches the dblog report form.
It then:
- Attaches the library: `$form['#attached']['library'][] = 'dblog_time_filter/time_updater'`.
- Adds `$form['current_server_time']` (`#markup`, weight `-100`), wrapped in
  `<div id="dblog-time-reference">`, containing `<span id="dblog-time-value"
  data-timestamp="{ts}">{formatted}</span>`. The timestamp is `\Drupal::time()->getRequestTime()`;
  the formatted value comes from `date.formatter->format($ts, 'custom', 'Y-m-d H:i:s T')`.
- Adds `$form['time_range_filter']` — a `select` (title "Time", weight `-90`) whose `#options` keys are
  durations in **seconds**: `'' => "- No time filter -"`, `600` (10 min), `3600` (hour), `43200`
  (12 h), `86400` (day), `604800` (week). `#default_value` is taken from the current exposed input.
- Prepends a submit handler: `array_unshift($form['#submit'], 'dblog_time_filter_exposed_form_submit')`.

## Submit handler — `dblog_time_filter_exposed_form_submit()`
Reads `time_range_filter` from form state. If non-empty it copies the raw duration into the View's
exposed input under the key `time_range_duration_seconds` and calls `$form_state->setUserInput()`; if
empty it clears that key and unsets the value. (Note: the query-alter hook below actually reads
`time_range_filter`, not `time_range_duration_seconds`; the select value is present in the exposed
input either way, so filtering works via the select's own name.)

## Query alter — `dblog_time_filter_views_query_alter()`
Implements `hook_views_query_alter()`. On `$view->id() === 'watchdog'` it reads
`$view->getExposedInput()['time_range_filter']`; if set it computes
`$start = \Drupal::time()->getRequestTime() - (int) $time_range_seconds` and calls
`$query->addWhere(0, 'watchdog.timestamp', $start_timestamp, '>=')`. The duration is cast to `int` and
passed as a bound parameter through the Views query API (`addWhere`), so the comparison is a plain
`watchdog.timestamp >= {computed_start}`.

## JS/CSS library — `dblog_time_filter/time_updater`
Defined in `dblog_time_filter.libraries.yml`; depends on `core/jquery` + `core/drupal`.
- `js/dblog_time_updater.js` — `Drupal.behaviors.dblogTimeUpdater`. Uses `.once('dblog-time-mover')`
  to run once, moves `#dblog-time-reference` to just before the `form[id^="views-exposed-form-watchdog-"]`
  element, then computes `offset = clientNow - serverLoadTs*1000` from the `data-timestamp` and updates
  `#dblog-time-value` every second (`setInterval(updateTime, 1000)`) with an estimated server time
  formatted client-side (timezone abbreviation best-effort). Timer id is stashed on the element for
  cleanup. (Uses the legacy jQuery `.once()`/`.removeOnce()` API.)
- `css/dblog-time-filter.css` — absolutely positions `#dblog-time-reference` top-right (`z-index:100`,
  `white-space:nowrap`) and reduces margins/padding on the exposed-form filter items, including
  `.form-item--time-range-filter`.

## Operating notes
- The Time select appears alongside core's existing Type/Severity exposed filters on the dblog report.
- Choosing "- No time filter -" removes the timestamp condition (unfiltered log).
- All time math uses request/server time; the JS clock is a client-side estimate for display only and
  does not affect the query.
