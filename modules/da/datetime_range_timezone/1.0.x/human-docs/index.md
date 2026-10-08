# Datetime Range Timezone — manual setup guide

**Datetime Range Timezone** (`datetime_range_timezone`) extends Drupal core's
Datetime Range field so that each date range also remembers the **timezone** it
was entered in — and displays it back in that same timezone. This solves a
common headache with events: a conference that runs "9:00–17:00 in New York"
should read the same for every visitor, regardless of the site's timezone or
where the reader happens to be. Core stores dates in UTC and shows them in the
viewer's or site's zone; this module pins display to the timezone the editor
chose.

It adds a new field type, **`daterange_timezone`**, plus a matching widget and
two formatters. The widget adds a **Timezone** select (grouped by region) next to
the normal start/end date fields. When an editor saves, the entered times are
interpreted as being in the chosen timezone before Drupal converts them to UTC
for storage, and on display everything is rendered back in that stored timezone —
so daylight-saving and off-by-hours bugs are avoided. The same widget also works
on plain core `daterange` fields if you just want to capture a timezone.

Two formatters ship with the module: a default one that renders the full
start–end range, and a single-date formatter that shows just the start or just
the end. Both let you choose the date format and whether to append the timezone
label. The module also integrates with the **Token** module, exposing
timezone-correct `start_date` and `end_date` tokens for use in emails and
elsewhere.

There is **no admin settings page** — you configure everything per field on the
usual **Manage fields**, **Manage form display**, and **Manage display** tabs. It
depends on core's **Datetime Range** module (`datetime_range`).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

The module adds no menu items and has no settings screen. You work with it on any
fieldable entity under **Structure → Content types → *(your type)* → Manage
fields**, where **Datetime Range Timezone** appears as a field type you can add.

## How to use it

1. **Add the field.** On **Manage fields** for your content type, add a new field
   of type **Datetime Range Timezone**. As with core date ranges, you choose
   whether it stores a **date only** or a **date and time**.
2. **Use the timezone widget.** On **Manage form display** the field uses the
   *Datetime Range Timezone* widget, which shows the start and end date fields
   plus a **Timezone** select. Editors pick the region/timezone the event is in.
   (You can also assign this widget to an existing core `daterange` field to add
   a timezone capture to it.)
3. **Choose a formatter.** On **Manage display**, pick one of the two formatters
   and set its options:

   **Datetime Range Timezone** *(default)* — renders the full start–end range:
   - **Separator** — the text shown between the start and end dates (default `-`).
   - **Date format** — which of your site's date formats to use (default
     *medium*).
   - **Display timezone** — when on, appends the timezone label after the range
     (default on). Turn it off to hide the label; the times themselves are still
     shown in the stored timezone either way.

   **Datetime Range Timezone (single date)** — renders just one endpoint:
   - **Date field** — show the **start date** or the **end date** (default start).
   - **Date format** and **Display timezone** — same as above.

4. **Save and try it.** Create content, enter a range, pick a timezone, and view
   it. The dates display in the timezone you chose, no matter the site or
   viewer's timezone.

### Tokens

If you have the **Token** module installed, timezone-aware tokens become
available for your field, for example
`[node:field_event_when:start_date]` and `[node:field_event_when:end_date]`
(with date sub-formats such as `:long` or `:custom:Y-m-d H:i`). These format each
date using the field's stored timezone, so token output — in emails, for
instance — matches what's shown on the page.
