Calendar renders Views results that contain a date field as month, week, day, or year calendars using a dedicated Views style, row, pager, and contextual-filter/argument set. It is a beta release.

---

Calendar plugs into Drupal's Views system: it adds a Views **style** plugin (`calendar`) that lays out results into a month/week/day/year grid, a **row** plugin (`calendar_row`, "Calendar entities") that turns each result into a placed calendar item with legend colors, a **pager** plugin (`calendar`, "Calendar Pager") that moves forward/back through time periods, an **area** handler (`calendar_header`) that prints the period heading and can embed the pager, and an **argument validator** (`calendar`) that parses period values from the URL. The date period shown is driven by a Views contextual filter (date argument) — core provides year/month/day granularities and Calendar adds an ISO `year_week` granularity via `hook_views_data_alter()`/`hook_field_views_data_alter()`. The bundled `calendar_datetime` submodule supplies a `date` argument-default plugin ("Calendar Current date") so a calendar opens on today when no period is in the URL. The fastest way to build a calendar is the "Add from template" link on the Views listing page (provided by the required `views_templates` module): its `calendar_base_field` / `calendar_config_field` templates generate a full view with Master plus Month, Week, Day, and Year page displays wired to a chosen date field. Presentation is theme-driven — the module registers many theme hooks (`calendar_month`, `calendar_week`, `calendar_day`, `calendar_year`, `calendar_mini`, `calendar_datebox`, `calendar_item`, `calendar_header`, `calendar_pager`, stripe legend, overlap variants) with matching Twig templates and CSS/JS for multi-day and overlapping events. Depends on core `views` and `datetime` (plus `views_templates` and the `calendar_datetime` submodule). A small settings form (`administer calendar settings` permission) only toggles session date-tracking; nearly all configuration happens inside the Views UI.

---

- Show content that has a date field (events, deadlines, publications) as a monthly calendar.
- Add Month, Week, Day, and Year displays of the same content from one view.
- Generate a ready-made calendar view with the "Add from template" link on the Views page.
- Build a calendar on the node "Authored on" (created) or "Changed" date without a custom field.
- Present a taxonomy term's date field as a calendar.
- Let visitors page forward and back through months/weeks/days with the Calendar Pager.
- Drive the displayed period from the URL via a date contextual filter (e.g. `/calendar/2026-07`).
- Open a calendar on the current date by default using the `calendar_datetime` "Current date" argument.
- Filter a week view to an ISO week using Calendar's `year_week` granularity argument.
- Color-code calendar items by content type using the row plugin's legend colors.
- Color-code calendar items by taxonomy term / vocabulary and show a stripe legend.
- Display a compact "mini" month calendar (e.g. as a sidebar block).
- Group day/week items by hour or half-hour time slots for a schedule-style layout.
- Handle multi-day and overlapping events with the overlap themes and multi-day styling.
- Cap the number of items shown per day and add a "more" link when there are too many.
- Add a heading area that prints the current month/week/day title above the grid.
- Embed the pager inside the header area so navigation sits next to the period title.
- Add tab links to switch between Day, Week, Month, and Year granularities.
- Place a calendar legend block to explain the stripe colors on the page.
- Override the look of any period by editing the Twig templates (month/week/day/year).
- Restyle calendar cells, dateboxes, and items with the module's CSS or theme overrides.
- Enable session date-tracking so users keep their place when switching granularities.
- Cache rendered calendar output in the view's Advanced settings for performance.
- Integrate recurring dates by adding the suggested `date_recur` module.
- Reuse the calendar style on any date-bearing base table exposed to Views.
