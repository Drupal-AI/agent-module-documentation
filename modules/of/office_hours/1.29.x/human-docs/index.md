# Office Hours — manual setup guide

**Office Hours** (`office_hours`) adds a "weekly office hours" field type to
Drupal, so you can record when something — an office, a shop, a venue, a clinic —
is open or closed. You attach the field to any content type, taxonomy term, or
other fielded entity, and each field stores a set of time slots for every weekday.
On top of the plain weekly schedule you can add **exception days** (specific dates
such as public holidays) and **seasons** (date ranges that follow their own hours,
like a summer timetable).

Editors fill the hours in with a choice of widgets — a compact week grid, a
list‑style form, or richer week/season/exception forms — and the module renders
them with a choice of formatters. There is a plain schedule table, a select‑list
table, a schema.org output for SEO, and, most usefully, a live **status**
formatter that works out whether the entity is open *right now* and shows an
"Open now / Closed" badge. That status can even refresh over AJAX without a full
page reload.

Under the hood the field exposes a rich API (`isOpen()`, `getStatus()`,
`getCurrentSlot()`, `getNextDay()`, and season/exception helpers) so you can drive
custom code or a decoupled front end, and it ships Views integration — fields plus
an open/closed status filter — so you can list and filter entities by whether
they are currently open. Everything is templated with `office-hours*.html.twig`
files, and two alter hooks let you shift the "current time" (for example to each
owner's timezone) or reformat the displayed times. It depends only on core's
**Field** and **Datetime** modules, and integrates optionally with Diff, Feeds,
and Webform.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Office Hours has **no central settings page** — it is a field type, so everything
happens on the entity you attach it to. You add and tune it through Field UI,
under **Structure → Content types → (your type) → Manage fields**, and its display
and entry options live on the **Manage form display** and **Manage display** tabs
for that bundle.

## How to use it

1. Enable the module (see [Installation](installation/index.md)) — this also
   requires core's Field and Datetime modules, which Drupal turns on for you.
2. Go to **Structure → Content types → (your content type) → Manage fields → Add
   field** and choose **Office hours** (field type `office_hours`).
3. Pick a **widget** on the **Manage form display** tab — the compact week grid,
   the list widget, or the complex week/season/exception widgets — to control how
   editors enter hours.
4. Pick a **formatter** on the **Manage display** tab — a schedule table, the
   schema.org output, or the **status** formatter for a live "Open now / Closed"
   badge. Formatter and widget settings (number of slots per day, time format,
   day grouping, highlighting the current day, and so on) are set right there in
   Field UI.
5. Create or edit content of that type and fill in the weekly hours, plus any
   holiday exceptions or seasonal schedules you need.

Common things people build with it: a business's weekly opening hours on a node,
an "Open now" badge for a location page, a full weekly opening‑hours table,
multiple slots per day for a lunch break, holiday closures, seasonal summer/winter
hours, a View listing every venue that is currently open, and schema.org
structured data for search engines.
