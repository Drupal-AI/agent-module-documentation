# Configuration

Calendar View has no global settings page — you configure everything on a View display
in the Views UI. The one rule to remember: the View must have a supported **date field**
in its fields, and that field must be ticked in the calendar style's settings, or the
display just shows "Missing calendar field."

## Build a calendar View

1. Create a View of your content at **Structure → Views → Add view** (any entity works,
   e.g. Content).
2. Set the display's **Format** to **Calendar by month** or **Calendar by week**.
3. Under **Fields**, add at least one supported **date field** — for example
   *Content: Authored on* (`created`), or a Datetime / Date range field. Supported types
   are `date`, `created`, `changed`, `datetime`, `daterange`, `smartdate`, and
   `timestamp`.
4. Open the calendar style's **Settings** and, under **Date fields**, tick the date
   field you just added. That is what tells the calendar which day to place each result
   on.
5. Save the View and preview it — your results now appear on a month (or week) grid.

## Style options

In the calendar style's Settings you can adjust:

| Option | What it does | Default |
|--------|--------------|---------|
| **Date fields** | Which View field(s) supply each result's date. Required. | none |
| **Display rows** | Also render the normal row output beneath the calendar. | off |
| **Weekday start** | Which weekday the calendar starts on (Sunday…Saturday). | Monday |
| **Sort order** | Ascending or descending order of events within a single day cell. | ascending |
| **Default date** | The date the calendar opens on. Accepts human dates like `this month`, `today`, or `2025-12-31`; empty = the date of the first result. | `this month` |
| **Calendar title** | A caption above the table. Supports date/view/site tokens, e.g. `[date:custom:F Y]` for "December 2025". | empty |
| **Row title** | An HTML title (tooltip) attribute on each rendered result. | empty |
| **Work week** | *(Calendar by week only)* Hide the weekend days. | off |

## Add navigation (pager)

To let visitors move between months or weeks, set the display's **Pager** to
**Calendar by month** or **Calendar by week**. These pagers give previous/next
navigation and have their own options (offset, label format, a previous/next toggle, and
a reset link).

## Add a "Jump to" filter

To let visitors jump straight to any date, add the **Calendar View: Jump to** filter
(under Filter criteria) and expose it. Visitors can then pick a date, and the calendar
also honours a `?calendar_timestamp=<date>` value in the URL (any human‑readable date,
e.g. `tomorrow` or `2025-12-31`), so you can deep‑link a calendar to a specific month.

## Theming the calendar

The calendar renders into a plain table with helpful CSS classes on each day cell —
`is-today`, `is-past`, `is-future`, `previous-month` / `current-month` / `next-month`,
the weekday name, and `empty` — so you can style days from your theme's CSS. To change a
day cell's markup, override the `calendar_view_day` theme hook / template (see the
module's `templates/` directory). If your events span multiple days, enable the
**Calendar View Multiday** submodule for better rendering.
