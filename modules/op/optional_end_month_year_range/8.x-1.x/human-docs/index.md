# Optional End Month Year Range — manual setup guide

**Optional End Month Year Range** (`optional_end_month_year_range`) adds a date‑range
field type whose **end date is optional**. It is built on Drupal core's `datetime`
and `datetime_range` modules, and it behaves like a normal date range with one extra
touch: a per‑value **"No end date" checkbox**. When an editor ticks that box, the end
date is cleared and the value represents an open‑ended, still‑ongoing period.

This is exactly what you need for things that have a clear start but no known end —
"2019 – present" employment on a profile, a membership or subscription that is still
running, a publication or availability window with no set close date, or a course
whose end is not yet decided. When the box is unchecked, the field works like any
other date range with both a start and an end.

The module provides the field type, an edit **widget** (which shows the start date,
the end date, and the "No end date" checkbox), and **three formatters** — Default,
Plain, and Custom — that render the range appropriately, showing just the start (or a
"present"‑style output) when no end date is stored. The label on the checkbox
defaults to "No end date" but you can change it in the field's settings.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its core date dependencies.

There is **no global configuration page** for this module — it is a field type, so
you set it up on individual fields through Drupal's Field UI, described below. The one
option it adds (the checkbox label) lives in the field's own settings, not on a
separate admin page.

## How to use it

1. **Add the field.** Go to the entity you want to add it to — for example
   **Structure → Content types → *(your type)* → Manage fields** — and add a new
   field of type **Optional End Month Year Range**.
2. **(Optional) Rename the checkbox.** In the field's storage/settings you can change
   the "No end date" checkbox label to whatever suits your content (for example
   "Ongoing" or "Present").
3. **Choose the widget.** On the bundle's **Manage form display**, the field uses the
   Optional End Month Year Range widget, which presents the start date, end date, and
   the "No end date" checkbox for editors.
4. **Choose a formatter.** On **Manage display**, pick one of the three formatters —
   **Default**, **Plain**, or **Custom** — to control how the range renders when a
   value has no end date.
5. **Create content.** Editors enter a start date and either add an end date or tick
   "No end date" for an open‑ended range.

Because it is a standard Field API field, it works with **Views** — you can list or
filter entities by whether an end date exists — and you can migrate existing
`datetime_range` data into it.
