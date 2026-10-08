<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the FullCalendar Views style

There is **no admin settings page** (`configure: null`). You configure everything in a View:
choose the **FullCalendar** format, then set its options. State lives in the View config entity
under `display.*.display_options.style` (schema `views.style.fullcalendar`).

## Attach the style to a View

1. Create/edit a View whose rows are date-bearing entities (e.g. nodes with a datetime or
   date-range field). Add a Fields-based row style and include the date field(s).
2. In **Format**, change the style to **FullCalendar**.
3. In the FullCalendar settings map at least the **Date** field, then choose which views
   (month / timeGrid / dayGrid / list) to enable.
4. (Optional) Enable **Use AJAX** under the View's *Advanced* settings for smooth navigation.

Minimum requirements: enable core `views` and `datetime`; the FullCalendar.io library
(`drupal/fullcalendar_io`) is installed via Composer with the module.

## The style plugin

- id `fullcalendar`, `@ViewsStyle(title = "FullCalendar", theme = "views_view--fullcalendar")`
- class `Drupal\fullcalendar\Plugin\views\style\FullCalendar` (`usesFields = TRUE`).
- It loads FullcalendarOption plugins via a `FullcalendarPluginCollection`; the built-in
  `fullcalendar` type plugin supplies the option form and processing.

## Key option groups (schema `views.style.fullcalendar`)

Stored as nested mappings; the most-used keys:

- **fields** — `title` / `title_field`, `url` / `url_field`, `date` / `date_field[]`: which
  View fields provide the event title, link, and start/end date(s).
- **View toggles** — `month_view`, `timegrid_view`, `daygrid_view`, `list_view` (booleans).
- **display** — `initialView` (e.g. `dayGridMonth`), `firstDay`.
- **header** / **footer** — FullCalendar toolbar definitions; `titleFormat`,
  `titleRangeSeparator`, `buttonText`, `buttonIcons`.
- **event_format** — `eventColor`, `eventDisplay`, `displayEventTime`, `nextDayThreshold`.
- **colors** — `color_bundle` (per-bundle `color`/`textcolor`/`style`), `tax_field`,
  `vocabularies`, `color_taxonomies` (per-term `color`/`textColor`/`display`). These feed the
  `fullcalendar_legend` submodule.
- **links** (interactivity) — `navLinks`, `navLinkDayClick`, `navLinkWeekClick`, `bundle_type`
  (bundle to create on day double-click), `formMode`, `createTarget`, `modalWidth`,
  `updateConfirm` (confirm drag-drop), `showMessages`.
- **times** — `convert_timezones`, `weekends`, `hiddenDays`, `dayHeaders`.
- **axis** — `slotDuration` (default `00:30:00`), `slotLabelInterval`, `slotLabelFormat`,
  `slotMinTime`, `slotMaxTime`, `scrollTime`.
- **week** — `weekNumbers`, `weekNumberCalculation`, `weekText`.
- **now** — `nowIndicator`, `now`.
- **business** — `businessHours`, `businessHours2`.
- **style** — `themeSystem`, `height`, `contentHeight`, `aspectRatio`, `handleWindowResize`,
  `windowResizeDelay`.
- **nav** — `initialDate`, `validRange`.
- **google** — `googleCalendarApiKey`, `googleCalendarId`.
- Per-view label/format overrides live under `month_view_settings`, `timegrid_view_settings`,
  `list_view_settings`, and `views_year|month|week|day`.

## Read it back

```bash
drush config:get views.view.<your_view>
# under display.default.display_options.style: type: fullcalendar, options: {...}
```

Programmatically, a View created with `display_options.style.type = 'fullcalendar'` is a
FullCalendar calendar; that `style.type` value is the single source of truth for "is this a
FullCalendar display".

## AJAX / interactivity routes

- `fullcalendar.update` → `/fullcalendar/ajax/update/drop/{entity_type}/{entity}`
  (`UpdateController::drop`, JSON) persists a drag-and-drop date change.
- `fullcalendar.results` → `/fullcalendar/ajax/results/{view}/{display_id}`
  (`ResultsController::getResults`) returns events for calendar navigation.
  Both require the `access content` permission (see
  [../permissions/permissions.md](../permissions/permissions.md)).
