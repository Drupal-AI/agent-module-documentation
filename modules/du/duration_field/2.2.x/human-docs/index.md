# Duration Field — manual setup guide

**Duration Field** (`duration_field`) adds a new field type to Drupal for
collecting a **length of time** — any combination of years, months, days, hours,
minutes, and seconds (and optionally weeks). Instead of asking an editor to type
a number and hope everyone agrees on the unit, you get a proper duration widget
with one input per time unit, and the value is stored in a way that sorts and
filters correctly.

Under the hood each value is saved as an ISO 8601 duration string (like
`P1Y2M10DT2H30M`), alongside a `seconds` column so durations can be compared
mathematically in queries and Views, and a `weeks` column (ISO 8601 has no week
token). You choose which units the widget collects with a per-field
**granularity** setting, and whether to include a weeks input. Three display
formatters ship: **Human Friendly** ("1 year 2 months", the default), **Duration
String** (the raw ISO value), and **Time Format** (`YY/MM/DD HH:MM:SS`).

Duration Field has **no admin settings page and no permissions** — everything is
configured per field on the usual *Manage fields*, *Manage form display*, and
*Manage display* screens of whatever entity you add it to. It has no third-party
Composer or PHP dependencies, ships no submodules, and provides one Drush command
for cleaning up before uninstall. The field is available the moment you enable the
module; there is nothing global to set up.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — including the storage
columns, the `duration`/`granularity` Form API elements, the services, and the
query-alter for filtering — read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There is no central settings page. Duration Field shows up as a field type you can
add wherever you manage fields — for example **Structure → Content types →
[your type] → Manage fields → Add field**, and likewise for taxonomy, users,
media, and other fieldable entities.

## How to use it

**Add the field.** On any bundle's *Manage fields* screen, choose **Add field**,
pick **Duration** as the type, and give it a label (for example "Reading time" or
"Prep time"). On the field settings step you set two things:

- **Granularity** — which time units the editor can fill in, chosen as
  colon-separated units `y:m:d:h:i:s` (years, months, days, hours, minutes,
  seconds). For a workout time you might use only minutes and seconds (`i:s`); for
  equipment age only years (`y`).
- **Include weeks** — adds a separate "Weeks" input when thinking in weeks is more
  natural (sprints, pregnancy, and so on).

**Choose the widget.** On *Manage form display* the field uses the **Duration**
widget, which renders one numeric input per enabled unit.

**Choose the formatter.** On *Manage display* pick how the value shows:

- **Human Friendly** (default) — friendly text like "2 hours 30 minutes", with a
  *text length* option (`full` or `short`, e.g. "2 hr 30 min") and a *separator*
  option (space, hyphen, comma, or newline).
- **Duration String** — the raw ISO 8601 string, useful for machine consumption or
  debugging.
- **Time Format** — a clock-style `00/00/00 02:30:00` display.

You can use different formatters in different view modes — friendly text in the
full view, a compact form in the teaser.

Because a `seconds` value is stored alongside each duration, you can sort and
filter content by duration in Views, and compare durations correctly. Duration
Field also provides two Form API elements (`duration` and `granularity`) for use
in custom forms, plus hooks for customizing the Human Friendly separators and
labels — see the [`agent/`](../agent/start.md) references. Before uninstalling,
run `drush duration_field:prepare_uninstall` to cleanly remove all duration
fields first.
