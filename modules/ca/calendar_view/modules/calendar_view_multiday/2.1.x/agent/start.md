<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Calendar View - Multiday (calendar_view_multiday) — agent index

Submodule of **calendar_view** (`part_of: calendar_view`). Improves rendering of events that
span multiple days on a Calendar View.

- **Zero configuration** — no settings form, config entity, permissions, or Drush commands.
  Enable it (`drush en calendar_view_multiday -y`) and it works.
- On enable, preprocess hooks (`views_view_calendar`, `calendar_view_day`) attach the
  `calendar_view_multiday/multiday` library and add `data-calendar-view-instance(s)` attributes
  plus `is-multi` / `is-multi--first` / `is-multi--middle` / `is-multi--last` classes to each
  result in a day cell, so a spanning event renders as one continuous bar.
- Depends on `calendar_view` — build the calendar there: [../../../../2.1.x/agent/start.md](../../../../2.1.x/agent/start.md)
