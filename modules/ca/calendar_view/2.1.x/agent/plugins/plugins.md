<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views plugins provided by Calendar View

The module extends Views only — it defines no plugin *type* of its own. It ships concrete
Views **style**, **pager**, and **filter** plugins you select in the Views UI.

## Style plugins

| Plugin id | Title | Class |
|---|---|---|
| `calendar_month` | Calendar by month | `Plugin\views\style\CalendarViewMonth` |
| `calendar_week` | Calendar by week | `Plugin\views\style\CalendarViewWeek` |

Both extend `CalendarViewBase extends \Drupal\views\Plugin\views\style\DefaultStyle` and render
via the `views_view_calendar` theme hook into a `#type => table` render array (one cell per day,
`data-calendar-view-*` attributes; cell classes `is-today`/`is-past`/`is-future`, `previous-month`/
`current-month`/`next-month`, weekday name, and `empty`). The **month** style is the default
choice for a monthly calendar. The **week** style adds a `calendar_work_week` (hide weekend) option.
Options are documented in [../configure/calendar-view.md](../configure/calendar-view.md).

### Supported date field types

The style will only accept a View field as a calendar date if it is a Views `Date` field, or an
EntityField whose storage type is one of (`CalendarViewBase::DATE_FIELD_TYPES`):

```
date, created, changed, datetime, daterange, smartdate, timestamp
```

`getDateFields()` filters the display's field handlers to these; the style's `calendar_fields`
option must reference one of them by field id.

## Pager plugins

| Plugin id | Class | Use |
|---|---|---|
| `calendar_month` | `Plugin\views\pager\CalendarViewMonthPager` | previous/next **month** navigation |
| `calendar_week` | `Plugin\views\pager\CalendarViewWeekPager` | previous/next **week** navigation |

(Both extend `CalendarViewPagerBase`.) Pager options include `offset`, `label_format`,
`use_previous_next`, `display_reset`.

## Filter plugin

| Plugin id | Class | Use |
|---|---|---|
| `calendar_view_timestamp` | `Plugin\views\filter\CalendarViewTimestamp` (extends core `Date`) | a "Jump to" date filter |

Exposed via `hook_views_data()` as **Calendar View → Jump to** on the `views` table. It lets a
visitor move the calendar to any date; the value is also read from the `?calendar_timestamp=<date>`
query string (any strtotime-readable string, e.g. `tomorrow` or `2025-12-31`).

## Theming

`hook_theme()` registers `views_view__style__calendar` (base hook `views_view`) and
`calendar_view_day` (render element) — override the latter to customize a day cell. See the
`templates/` directory in the module.
