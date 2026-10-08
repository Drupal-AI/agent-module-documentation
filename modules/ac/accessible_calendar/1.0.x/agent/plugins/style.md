<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Style plugins: calendar_month & calendar_week

Files: `src/Plugin/views/style/AccessibleCalendarBase.php` (abstract, extends core
`DefaultStyle`), `AccessibleCalendarMonth.php` (`id = calendar_month`), `AccessibleCalendarWeek.php`
(`id = calendar_week`), `AccessibleCalendarInterface.php`. Both `theme = "views_view_calendar"`,
`display_types = {"normal"}`.

## Enable / use

Enable the module (`drush en accessible_calendar`). On a View: add ≥1 date field to *Fields*,
set *Format* to **Calendar by month** or **Calendar by week**, open the style settings, tick the
date field(s) under **Date fields**, then choose the matching pager (see
[pager-filter.md](pager-filter.md)). No admin route — all configuration is per-View-display.

## Options (`getDefaultOptions()` / `defineOptions()` / `buildOptionsForm()`)

- `calendar_fields` (checkboxes) — which date field IDs drive placement. Built from
  `getDateFields()` (fields whose type is in `DATE_FIELD_TYPES` = date, created, changed, datetime,
  daterange, smartdate, timestamp). Empty ⇒ render shows "Missing calendar field."
- `calendar_display_rows` (bool, default 0) — also render the plain Views rows below the calendar.
- `calendar_weekday_start` (default 1 = Monday) — first day of week; empty falls back to
  `system.date` `first_day`.
- `calendar_sort_order` (default `ASC`).
- `calendar_timestamp` (default `this month`) — default period; empty ⇒ use first result's date.
- `calendar_title` — caption; month default `[date:custom:F Y]`, week default
  `[date:custom:\W\e\e\k W - F Y]`. Token-replaced (`site`, `date`, `view` global tokens).
- `calendar_row_title` — per-event hidden title; tokenized then **`strip_tags()`** (see
  `getRowValues()`), exposed as `accessible_title` and rendered escaped in Twig.
- Week only: `calendar_work_week` (bool, default 0) — "Hide weekend" drops days 0 & 6.

Schema for all of the above: `config/schema/accessible_calendar.views.schema.yml`
(`accessible_calendar.view_style` → `views.style.calendar_month` / `views.style.calendar_week`).

## How rendering works

- `preRender()` builds the calendar skeleton once via `buildCalendars(getCalendarTimestamp())`.
  Month builds a `#type=table` for the month (`AccessibleCalendarMonth::buildTable($year,$month)`,
  keyed `YYYYMM`); week builds one row for the ISO week (`AccessibleCalendarWeek::buildTable`,
  keyed `YYYY'W'WW`). Cells come from `getCell($timestamp)` which stamps
  `data-accessible-calendar-*` attributes and `is-today`/`is-past`/`is-future` + weekday classes.
- `render()` filters `calendar_fields` to real date fields, then for each result+field calls
  `getRowValues()` → `populateCalendar()`. `getRowValues()` normalizes start/`end_value` to
  timestamps (`_accessible_calendar_ensure_timestamp_value`), applies a timezone offset
  (`getTimezone()`/`getTimezoneOffset()`), computes a per-event `hash`
  (`md5(entityType:id:field . rowIndex)`), and the `strip_tags`'d title.
- `populateCalendar()` renders the row with **the View's own row plugin**
  (`$this->view->rowPlugin->render($result)`) and drops it into every day cell the event spans
  (start→`end_value`, one entry per day) — this is why entity/field access is inherited from Views,
  not re-implemented.
- Each calendar gets `#cache['contexts'] = ['url.query_args:calendar_timestamp']` and the View's
  cache tags; empty cells get class `empty` and a `data-accessible-calendar-results` count.
- `getCalendarTimestamp($use_cache=TRUE)`: exposed `calendar_timestamp` input → `calendar_timestamp`
  option → first result's value → `now`; always run through `TimestampHelper`.
- `getCalendarCaption()` token-replaces the title using the display's rendering language
  (`getCurrentLangcode()`).

## Timezone & relative filters

- `getTimezone()` uses `system.date` default, optionally the user timezone if configurable, then a
  field `timezone_override`. `makeFilterValuesRelative()` (called from `hook_views_pre_view`)
  rewrites *offset*-type date filters on the selected date field(s) to concrete dates around the
  viewed period, so a "-1 week / +1 week" filter tracks navigation.
