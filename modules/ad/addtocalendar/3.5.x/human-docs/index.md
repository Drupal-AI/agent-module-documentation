# Add To Calendar — manual setup guide

**Add To Calendar** (`addtocalendar`) renders an "Add to Calendar" button next to date
fields on your entity pages, so visitors can export an event straight into their own
calendar — iCalendar (`.ics`), Google Calendar, Outlook, Outlook Online, or Yahoo. It's
the classic feature you want on an event node, a webinar, or a conference session: one
click and the date is on the visitor's calendar. The interactive button itself is
produced by the third‑party addtocalendar.com JavaScript widget, which the module loads
for you.

There are two ways to use it. The most common is a **formatter setting**: on a date
field's *Manage display*, you tick "Show Add to Calendar" and the button is appended
after the rendered date. You then map the calendar event's title, description, location,
organizer and end date to other fields on the entity, to a token or static string, or to
the node title. This works on core's **Date/time** (`datetime`) and **Datetime Range**
(`daterange`) fields. The second way is a dedicated **field type**,
`add_to_calendar_field`, which adds a standalone button to any entity (even one without a
date field) and can be placed in Views — with a per‑item checkbox so an editor can switch
the button on or off for an individual node.

You can restrict which calendar providers appear in the dropdown, mark events public or
private, force HTTPS‑only links, and choose one of the prebuilt button styles ("Blue" or
"Glow Orange") or output unstyled markup for your own CSS. There is **no central settings
page** — everything is configured on the field formatter or the field instance. Two alter
hooks let developers rewrite the emitted event values in code.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable it.

## How to use it

There's no admin settings page (`configure` is null). You set the button up in one of two
places.

### Option A — add the button to an existing date field

This works on any core **Date/time** or **Datetime Range** field.

1. Go to the bundle's **Manage display** (for example
   `/admin/structure/types/manage/event/display`).
2. Find your date field and open its formatter settings (the cog icon).
3. Tick **Show Add to Calendar**.
4. Fill in the event mappings — for each of **Title**, **Description**, **Location**,
   **Organizer**, **Organizer email**, and **End date**, choose another field on the
   entity, or pick "token" and enter a token/static string (e.g. `[node:title]`), or use
   the node title. The event's *start* date comes from the date field itself.
5. Choose a **Style** ("No styling", "Blue", or "Glow Orange"), set the **display text**,
   pick which **calendars** appear in the dropdown, set **privacy** (public/private) and
   the **security level** (auto / HTTPS / HTTP), and — for multi‑value date fields —
   whether the button shows on one delta or all of them.
6. Click **Update**, then **Save**.

The settings are stored on the entity view display, so they export cleanly with your
configuration.

### Option B — add a standalone Add‑to‑Calendar field

Use this when you want a button on an entity that has no date field, or a button you can
reuse as a Views field. Add a field of type **Add to calendar** (`add_to_calendar_field`)
to your content type just like any other field. It uses the *Add to calendar widget* for
editing and the *Add to calendar* formatter for display. Because it extends core's boolean
field, each item carries a checkbox ("Show add to calendar widget") that an editor can
toggle per node, and the event's title/description/location/dates/organizer, style,
privacy, and calendar list are configured on the **field settings** form.

### The button library

The interactive button is drawn by the addtocalendar.com script
(`//addtocalendar.com/atc/1.5/atc.min.js`), which the module attaches automatically
whenever a button renders — there is nothing to install into `/libraries`. Choosing "No
Styling" emits the markup without a style so you can add your own CSS.
