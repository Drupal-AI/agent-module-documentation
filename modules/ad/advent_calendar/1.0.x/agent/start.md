<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advent Calendar (advent_calendar) — agent index

A **Views style** that renders View rows as an advent calendar of clickable "door" tiles, each rendered with the
`advent_calendar:door` Single Directory Component. Package `Views`. Depends on core **`views`** (and core SDC, so
Drupal 10.1+). `php: 8.0`. Core `^10.1 || ^11`. License GPL-2.0-or-later. Version 1.0.0-beta6.

## What it provides

- **Views style plugin** `Plugin/views/style/AdventCalendar` (id `advent_calendar_advent_calendar`, label
  *Advent Calendar*, theme `views_style_advent_calendar_advent_calendar`). `usesRowPlugin` + `usesRowClass`.
  Options: `wrapper_class`, `door_closed_image`, `door_open_image`.
- **SDC component** `advent_calendar:door` (`components/door/`) — `door.twig`, `door.css`, `door.js`
  (behavior `door`), closed/open SVG assets, `door.component.yml` (props: calendar, day, title required; unlocked,
  path, door_image, door_closed_image, door_open_image optional).
- **Templates** `templates/views-style-advent-calendar-advent-calendar.html.twig` (wrapper + rows) and
  `templates/views-view-fields--advent-calendar.html.twig` (maps View fields to the door component).
- **Preprocess + theme** in `advent_calendar.module`:
  `template_preprocess_views_style_advent_calendar_advent_calendar()`,
  `template_preprocess_views_view_fields__advent_calendar()`, and `advent_calendar_theme()`.
- **Library** `advent_calendar/advent_calendar` (`css/advent_calendar.css`), attached by the style template.
- **Config schema** `views.style.advent_calendar_advent_calendar` (`config/schema/`) for the three style options.
- **Submodule** `advent_calendar_quickstart` — scaffolds content type, vocabulary, nodes and a View. Documented
  under `modules/advent_calendar_quickstart/`.

No routes, permissions, services or Drush of its own. Door open/closed state is presentation only (published
status gates clickability; the door link targets the content's own page, which uses standard entity access).

## Solution docs

- The Views style, its options, preprocessing and the two templates →
  [views/style.md](views/style.md)
- The `advent_calendar:door` component — props, Twig, JS behavior, CSS/assets →
  [components/door.md](components/door.md)
