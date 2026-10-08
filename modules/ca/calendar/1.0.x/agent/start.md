# calendar — agent start

Renders date-field Views results as month/week/day/year calendars. It ships Views plugins —
a **style** (`calendar`), a **row** (`calendar_row`), a **pager** (`calendar`), an area handler
(`calendar_header`), an argument validator (`calendar`), and date arguments (incl. an ISO
`year_week` granularity). The `calendar_datetime` submodule adds a "Current date"
argument-default. Requires core `views` + `datetime`, plus `views_templates` (for the
"Add from template" builder) and the bundled `calendar_datetime`. Beta.

The admin form (`/admin/config/date/calendar`, `administer calendar settings`) only toggles
session date-tracking; real setup happens in the Views UI.

- Build a calendar view: style/row/pager, month/week/day/year, arguments, template → [configure/calendar.md](configure/calendar.md)
- Theme hooks & Twig templates for calendar output → [theming/calendar.md](theming/calendar.md)
