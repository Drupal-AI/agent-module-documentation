<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# FullCalendar — agent index

Integrates the FullCalendar.io v6 JS library as a **Views style plugin** (`fullcalendar`) that
renders a View of date-bearing entities as an interactive calendar. Requires core `views` +
`datetime` and the `drupal/fullcalendar_io` library. No configure route — everything is
configured **inside the View's Format settings**. Ships a plugin type, one permission, four
hooks, and two AJAX routes.

- **Set the style on a View, the main options, field mappings, colors, AJAX/interactivity,
  and where the config is stored** → [configure/views-style.md](configure/views-style.md)
- **The FullCalendar "option" plugin type (`FullcalendarOption`) and how to add one** →
  [plugins/fullcalendar-option.md](plugins/fullcalendar-option.md)
- **The four hooks (classes, droppable, process-dates) the module invites** →
  [hooks/hooks.md](hooks/hooks.md)
- **The `update any fullcalendar event` permission and the AJAX route access** →
  [permissions/permissions.md](permissions/permissions.md)

Key fact: pick **FullCalendar** in a View's *Format*. The style is
`@ViewsStyle(id = "fullcalendar")` (`views.style.fullcalendar` config schema). Drag-and-drop
updates post to `/fullcalendar/ajax/update/drop/{entity_type}/{entity}`; navigation fetches
from `/fullcalendar/ajax/results/{view}/{display_id}`. Submodule: `fullcalendar_legend`.
