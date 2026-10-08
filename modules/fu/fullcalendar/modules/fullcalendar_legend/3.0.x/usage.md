<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
FullCalendar Legend is a submodule of FullCalendar that adds a Views area handler which prints a color legend explaining the per-bundle and per-taxonomy-term colors configured on a FullCalendar calendar display.

---

The submodule provides a single Views area handler plugin, `fullcalendar_legend` (`@ViewsArea`, class `FullCalendarLegend`), registered via `hook_views_data()` in `fullcalendar_legend.views.inc`. You add it to a View that uses the FullCalendar style, typically in the *Header* or *Footer*, and at render time it reads the FullCalendar style plugin's `colors` options (`color_bundle` and `color_taxonomies` / `vocabularies`). For each configured bundle color it emits a labelled list item (using the bundle label as the section heading) and for each configured taxonomy term color it emits another section headed by the vocabulary label; each item carries the color as a CSS custom property (`--dot-color`, `--text-color`) and display-style classes (`fc-display--background|block|...`). The only configurable option is `heading_level` (one of `h2`–`h5`, default `h3`), validated by a regex in its config schema (`views.area.fullcalendar_legend`). If the calendar has no `colors` configured, the handler renders nothing. It attaches its own CSS library (`fullcalendar_legend/fullcalendar_legend`) and depends on the parent `fullcalendar` module plus core `block`. It has no settings page, no permissions, and no other plugins — it is a thin presentational add-on to the parent's existing color configuration.

---

- Show a color key beneath a FullCalendar calendar so visitors understand event colors.
- Explain per-content-type (bundle) event colors with a labelled legend section.
- Explain per-taxonomy-term event colors (e.g. event categories) in the legend.
- Place the legend in the calendar View's footer as a Views area.
- Choose the legend's heading level (h2–h5) for correct document semantics/accessibility.
- Add an accessible, non-color-only reference for color-coded calendar events.
- Automatically reflect whatever bundle colors the FullCalendar style has configured.
- Automatically reflect the vocabulary/term colors configured on the calendar.
- Display the vocabulary label as the heading for the taxonomy color section.
- Keep the legend in sync with the calendar's colors with no extra configuration.
- Hide the legend automatically when no colors are configured on the calendar.
- Style the legend swatches via the provided `--dot-color` / `--text-color` CSS variables.
- Differentiate "background", "block", and default event display styles in the legend.
- Provide a legend for a public events calendar embedded on a landing page.
- Give editors a preview of how their configured colors will read as a legend.
- Add a legend to a multi-view (month/week/list) FullCalendar without extra markup.
- Use the legend as a Header area so it appears above the calendar instead of below.
- Present a department/category color guide next to a shared team calendar.
- Reuse the parent module's taxonomy color mapping as a front-end legend.
- Support h2-level headings when the legend is the main content of a page region.
