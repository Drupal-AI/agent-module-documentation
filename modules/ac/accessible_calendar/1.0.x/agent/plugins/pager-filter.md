<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Pager plugins & "Jump to" filter

## Pagers (navigation by month / week)

Files: `src/Plugin/views/pager/AccessibleCalendarPagerBase.php` (abstract, extends core `None`),
`AccessibleCalendarMonthPager.php` (`id = accessible_calendar_month`),
`AccessibleCalendarWeekPager.php` (`id = accessible_calendar_week`),
`AccessibleCalendarPagerInterface.php`. Both `display_types = {"calendar"}`,
`theme = "accessible_calendar_pager"`.

Choose the pager under the View display's **Pager** section (only offered on calendar-style
displays). Options (`defineOptions()` / `buildOptionsForm()`):

- `use_previous_next` (default TRUE) — "Previous"/"Next" labels vs. formatted date labels.
- `display_reset` (default TRUE) — show a "Reset" link back to the current period.
- `label_format` (default `F`) — PHP date format for prev/next labels when `use_previous_next` is
  off (disabled in the form while it is on). The core `offset` option is hidden.

`render()` computes previous/current/next timestamps from `getCalendarTimestamp()` (delegated to
the style plugin via `$this->view->getStyle()->getCalendarTimestamp()`), formats their labels, and
returns a `#theme = accessible_calendar_pager` render array with a `#parameters` array and
`#route_name` = `<none>` (or `<current>` in live preview). Month step =
`first day of previous/next month`; week step = `first day last/next week`
(`getDatetimePrevious()`/`getDatetimeNext()` overridden in the week pager). `usePager()` returns
TRUE. If the style set `$this->view->calendar_error`, the pager renders nothing.

### Navigation markup (accessibility)

`template_preprocess_accessible_calendar_pager()` (`accessible_calendar.theme.inc`) +
`templates/accessible-calendar-pager.html.twig` build a `<nav aria-label="Calendar navigation">`
with prev/current/next (and optional reset) links. Each link is a `Url::fromRoute($route_name, [],
['query' => ['calendar_timestamp' => <ts>] + $parameters])`, with descriptive `aria-label`s
("Previous month, @date"). The current period uses `aria-current="date"`. The
`js-pager__items` class enables core Views AJAX; the nav carries
`data-accessible-calendar-current-period` which `js/accessible-calendar.a11y.js` reads to
`Drupal.announce()` the update and move focus to the table `<caption>` after AJAX navigation.
Cache context `url.query_args:calendar_timestamp` is added.

## "Jump to" filter

File: `src/Plugin/views/filter/AccessibleCalendarTimestamp.php` (`AccessibleCalendarTimestamp`,
extends core `Date`); registered as `accessible_calendar_timestamp` via
`accessible_calendar_views_data()` in `accessible_calendar.views.inc` under the group
*Accessible Calendar*, title *Jump to*, `allow empty` = TRUE.

- `query()` is a **no-op** — the filter does not modify the SQL query; it only ensures the exposed
  `calendar_timestamp` query arg exists so the style/pager pick it up.
- `validateExposed()` accepts any value the `accessible_calendar.timestamp` service
  (`TimestampHelper::ensureTimestampValue()`, i.e. `strtotime`) can parse — human strings like
  "next month" or "2025-12-31"; otherwise it sets a "Invalid date format." form error.
- `getCacheContexts()` adds `url.query_args:calendar_timestamp`.

Expose this filter (it has no real value handler beyond validation) to give users a free-text
"jump to a date" control that repositions the calendar.
