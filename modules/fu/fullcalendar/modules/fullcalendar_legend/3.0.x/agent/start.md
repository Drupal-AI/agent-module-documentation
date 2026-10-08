<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# FullCalendar Legend — agent index

Submodule of FullCalendar. Adds one **Views area handler**, `fullcalendar_legend`, that renders
a color legend for the bundle/taxonomy colors configured on a FullCalendar calendar display. No
configure route, no settings form, no permissions. Depends on `fullcalendar` + core `block`.

- **Add the legend area to a FullCalendar View, its `heading_level` option, and how it reads
  the parent style's colors** → [configure/legend-area.md](configure/legend-area.md)

Key fact: it is a `@ViewsArea("fullcalendar_legend")` handler (registered via
`hook_views_data()`), added to a View's Header/Footer. Its only option is `heading_level`
(`h2`–`h5`, default `h3`, schema `views.area.fullcalendar_legend`). It renders nothing unless
the FullCalendar style has `colors` (`color_bundle` / `color_taxonomies`) configured.
