Office Hours defines a "weekly office hours" field type that lets you record when an entity (an office, shop, venue, etc.) is open or closed, with per-day time slots, exceptions, and seasons, plus formatters that show a schedule and a live open/closed status.

---

The module adds an `office_hours` field you attach to any fielded entity (node, term, etc.) via Field UI. Each field stores one or more time slots per weekday, and optional **exception days** (specific dates like holidays) and **seasons** (date ranges with their own hours). Several widgets let editors enter data — a compact week grid, a list widget, complex week/season/exception widgets — and several formatters render it: a default/table schedule, a table-select list, a schema.org output, and a **status** formatter that computes and displays whether the entity is currently open or closed (with an AJAX status-update endpoint to refresh it without a full page load). The field exposes a rich API (`isOpen()`, `getStatus()`, `getCurrentSlot()`, `getNextDay()`, seasons/exceptions helpers) for use in code, and Views integration provides fields and a status filter so you can list and filter entities by open/closed state. Theming is fully templated (`office-hours*.html.twig`) and two alter hooks let you shift the "current time" (e.g. per owner timezone) and reformat displayed times. It integrates optionally with Diff, Feeds, and Webform.

---

- Store a business's weekly opening hours on a node.
- Show an "Open now / Closed" badge for a location.
- Display a full weekly opening-hours table on a page.
- Add multiple time slots per day (e.g. lunch break).
- Define holiday/exception closures on specific dates.
- Set seasonal hours (summer vs. winter schedules).
- Compute whether an entity is currently open in code (`isOpen()`).
- Show the next opening time when currently closed.
- Refresh open/closed status live via AJAX without reloading.
- List all currently-open venues in a View.
- Filter a View by open/closed status.
- Output opening hours as schema.org structured data for SEO.
- Let editors enter hours with a compact week grid widget.
- Use a list widget for simpler hours entry.
- Highlight the current day in the displayed schedule.
- Adjust the "current time" per content owner's timezone (hook).
- Reformat displayed times (e.g. "9am" instead of "09:00") via a hook.
- Show "Around the clock" / all-day-open labels.
- Import opening hours in bulk via Feeds.
- Collect office hours through a Webform element.
- Compare office-hours field revisions with Diff.
- Theme the schedule with custom Twig templates.
- Attach office hours to any entity type (nodes, terms, custom).
- Group multiple locations and display each one's hours.
- Provide accessible, translatable open/closed messaging.
- Show a compact "today's hours" summary.
- Drive a decoupled front end from the field's status API.
