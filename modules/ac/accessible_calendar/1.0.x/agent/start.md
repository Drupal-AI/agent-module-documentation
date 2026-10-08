<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Accessible Calendar (accessible_calendar) — agent index

Renders **Views results** as accessible **month** or **week** calendar tables. It adds no entity,
route, permission, or service beyond a small timestamp helper — everything is **Views plugins** +
theme hooks. Package: none (top-level). Depends only on core **`views`**. Core
`^10 || ^11`. License GPL-2.0-or-later. Version 1.0.0. Optional submodule
**`accessible_calendar_multiday`** (documented separately).

- **The style plugins (month/week), all calendar settings, date-field handling, tokens** →
  [plugins/style.md](plugins/style.md)
- **The month/week pager plugins and the "Jump to" filter (navigation & AJAX)** →
  [plugins/pager-filter.md](plugins/pager-filter.md)
- **Config schema, theme hooks, templates, libraries, how to build a calendar View** →
  [config/settings.md](config/settings.md)

## What it actually provides (from source)

- **2 Views style plugins** (`src/Plugin/views/style/`), both extending `AccessibleCalendarBase`
  (which extends core `DefaultStyle`): `calendar_month` (`AccessibleCalendarMonth`) and
  `calendar_week` (`AccessibleCalendarWeek`). `theme = "views_view_calendar"`.
- **2 Views pager plugins** (`src/Plugin/views/pager/`), both extending
  `AccessibleCalendarPagerBase` (which extends core `None`): `accessible_calendar_month`
  (`AccessibleCalendarMonthPager`) and `accessible_calendar_week` (`AccessibleCalendarWeekPager`).
  `display_types = {"calendar"}`, `theme = "accessible_calendar_pager"`.
- **1 Views filter plugin**: `accessible_calendar_timestamp` (`AccessibleCalendarTimestamp`,
  extends core `Date`) — the exposed **"Jump to"** filter. Declared via
  `accessible_calendar_views_data()` in `accessible_calendar.views.inc`.
- **1 service** `accessible_calendar.timestamp` → `TimestampHelper` (parse/validate/normalize a
  timestamp from int/float/numeric/date-string via `strtotime`), plus a logger channel
  `logger.channel.accessible_calendar`. See `accessible_calendar.services.yml`.
- **3 theme hooks** in `accessible_calendar_theme()` (`accessible_calendar.module`):
  `views_view__style__accessible_calendar`, `accessible_calendar_pager`,
  `accessible_calendar_day`. Preprocessors + theme-suggestion alters live in
  `accessible_calendar.theme.inc`. Templates in `templates/`.
- **1 config-schema file** `config/schema/accessible_calendar.views.schema.yml` (style options).
  No config/install, no settings form, no permissions, no `.install`, no Drush.
- **hook_views_pre_view** (`accessible_calendar.views_execution.inc`) calls
  `makeFilterValuesRelative()` so offset date filters rebase to the viewed period.
- Library `accessible_calendar/calendar` (`accessible_calendar.libraries.yml`): JS
  `js/accessible-calendar.a11y.js` + two CSS files; deps `core/drupal`, `core/once`,
  `core/drupal.announce`.

## Key facts

- **No new access surface.** Calendar cells are populated from `$this->view->result` and rendered
  through the View's own row plugin (`$this->view->rowPlugin->render($result)`), so Views/entity
  access is honored exactly as in any View — the plugin does not load extra entities.
- **Selected period** comes from `getCalendarTimestamp()`: exposed `calendar_timestamp` query arg,
  else the style's `calendar_timestamp` option, else the first result's date, else `now`. All run
  through `TimestampHelper` (`strtotime`). Cache context
  `url.query_args:calendar_timestamp` is added to calendars, the pager, and the filter.
- **Supported date field types** (`AccessibleCalendarBase::DATE_FIELD_TYPES`): date, created,
  changed, datetime, daterange, smartdate, timestamp.
