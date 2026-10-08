<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Advent Calendar formats a View's results as an advent calendar of clickable doors.

---

Advent Calendar provides a Views style plugin that renders each View row as a numbered "door" using the
`advent_calendar:door` Single Directory Component. Doors start closed and open when a visitor clicks them, with
the open state remembered in the browser's `localStorage`. A door whose backing content is published renders as
clickable; a door for unpublished content renders as a plain closed door that cannot be opened — so a common
pattern is to schedule each day's content to publish on its date (e.g. with Scheduler or Scheduled Publish). The
style adds a configurable wrapper CSS class and optional custom closed/open door images. The bundled
`advent_calendar_quickstart` submodule scaffolds a whole calendar for you. It requires core's Single Directory
Components (Drupal 10.1+) and depends on Views.

---

- Turn a View of "day" content into a visual advent calendar.
- Render each row as a numbered door via the `advent_calendar:door` component.
- Let visitors click doors to open them.
- Remember which doors a visitor has opened via `localStorage`.
- Show unpublished days as closed, non-clickable doors.
- Reveal each day's content by publishing that day's node on schedule.
- Run a seasonal countdown/promotion on a site.
- Build a "12 days" style teaser campaign.
- Point each door at its content page via the door link.
- Customise the calendar wrapper with a CSS class.
- Supply a custom closed-door image.
- Supply a custom open-door image (frame).
- Show an image behind each door (the day's reveal).
- Style the doors with the shipped component CSS or override it.
- Scaffold a complete calendar quickly with the Quickstart submodule.
- Reuse the calendar year after year by creating new per-year content.
- Combine with a scheduling module to auto-publish daily.
- Use any content type as the door source by mapping View fields to component props.
- Display the calendar as a block or page via a standard View display.
- Theme the door markup by overriding the SDC Twig template.
- Localise door numbers and titles through standard View field output.
