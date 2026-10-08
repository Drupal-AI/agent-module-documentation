# Date All Day — manual setup guide

**Date All Day** (`date_all_day`) adds an **"All day"** checkbox to Drupal's core Datetime
Range fields and ships matching display formatters that print a clean date-only string when a
range covers a whole day. It is built for events and similar content: an editor can mark a
conference session or a holiday closure as running the whole day instead of fiddling with
`00:00` and `23:59`, and the front end shows just "2026-07-24" for that all-day item while
timed entries still show their hours and minutes.

It does not add a field type of its own — it works on core's existing **Datetime Range**
(`daterange`) fields. It provides one widget ("Date and time range with All day") that shows
the checkbox and, when ticked, hides the time inputs and forces the start/end to exact
midnight-to-one-second-before-midnight boundaries. There is no separate "all day" flag stored
anywhere: all-day status is *derived* from those exact times, so it stays consistent even for
values set by import or migration. On the display side, three formatters mirror core's
Datetime Range formatters but add a **date-only format** used just for all-day occurrences,
and they tolerate an open-ended range with no end date.

The module depends only on core's **Datetime Range** module and supports Drupal 8.7.7 through
11. It has **no settings page, no permission and no configuration object** — you set it up
per field on the *Manage form display* and *Manage display* screens.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable it.

## How to use it

Date All Day works on any core **Date range** field of type *Date and time* — you pick its
widget on the form display and one of its formatters on the display.

1. **Have a Date range field.** Add a **Date range** field to your bundle (or use an
   existing one), and make sure its storage type is *Date and time* — an all-day toggle only
   makes sense where there is a time to hide. If you want to allow ranges with no end date,
   turn on the field's core *optional end date* setting.
2. **Set the widget.** On the bundle's **Manage form display**, set the field's widget to
   **Date and time range with All day**. On the entity form the field now shows an **All
   day** checkbox; ticking it hides both time inputs and stores the range as exact
   `00:00:00` to `23:59:59`.
3. **Set the formatter.** On the bundle's **Manage display**, set the field's format to one
   of:
   - **Default (All day)** — like core's default Datetime Range formatter, plus a **Date
     only format** setting (choose one of the site's date-format entities) used when the
     item is all-day.
   - **Custom (All day)** — like core's custom formatter, where the **Date only format** is a
     raw PHP date pattern (e.g. `Y-m-d` or `l j F Y`). Set this yourself — the literal
     default is not a usable pattern.
   - **Plain (All day)** — *deprecated*; avoid on new sites.

   Open the formatter's cog to pick the date-only format used for all-day items, then
   **Save**.

That is the whole setup. You can give different view modes different date-only formats on
the same field — for instance a short `Y-m-d` in teasers and a long `l j F Y` in the full
view.

**Good to know:**

- All-day status is detected from the stored times *in the site's default timezone*, so
  setting a start/end to `00:00:00`/`23:59:59` by hand (or via import) also reads as
  all-day and shows the box ticked.
- The formatters render each date as a `<time datetime="…">` element, which is helpful for
  SEO and structured data.
- Custom code can check all-day status with the module's
  `DateRangeAllDayHelper::isAllDay($item)` helper.
