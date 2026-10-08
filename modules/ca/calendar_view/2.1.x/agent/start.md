<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Calendar View (calendar_view) — agent index

Views style plugins that render a View's results as an HTML-table calendar.
Depends on `views`. No global settings page — configured per-View in the Views UI.
Two styles: `calendar_month` (Calendar by month) and `calendar_week` (Calendar by week).

Key rule: the View must have **at least one supported Date field** in its *fields*, and that
field must be ticked in the style's `calendar_fields` option, or the calendar shows
"Missing calendar field."

- Build a calendar View, choose the style, and bind a date field → [configure/calendar-view.md](configure/calendar-view.md)
- Style / pager / filter plugin ids, options, and supported date field types → [plugins/plugins.md](plugins/plugins.md)
- Submodule for multi-day event rendering → [../../modules/calendar_view_multiday/2.1.x/agent/start.md](../../modules/calendar_view_multiday/2.1.x/agent/start.md)
