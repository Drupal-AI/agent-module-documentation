# Add to Cal — manual setup guide

**Add to Cal** (`addtocal`) turns a date field into an **"Add to Calendar"
button**. When a visitor clicks it, they get one-click links to add the event to
Google Calendar, Yahoo, Outlook.com, and Office.com, plus a downloadable `.ics`
file that imports into Apple Calendar, Microsoft Outlook, and other calendar apps.
It's the fast way to give events, sessions, and webinars a calendar button without
writing any code.

Add to Cal works as a **field formatter**, so there's nothing global to switch on —
you enable it per field on an entity's *Manage display* screen. It ships two
formatters: **Add to Cal** (a button that opens a menu of calendar options) and
**Add to Cal grouped button** (a more compact grouped variant). Both attach to the
common date field types — `date`, `datestamp`, `datetime`, `daterange`,
`daterange_timezone`, `date_recur`, and `smartdate` — and honor start and end times
for range fields.

Each formatter has a handful of settings: the event **title**, **location**, and
**description** (all token-aware, so you can pull in `[node:title]` and similar),
a **separator** for date-range fields, and a **past events** toggle that decides
whether the button still shows for events that have already happened. Because both
formatters extend Drupal's custom date formatter, they also carry the usual
date-format settings. Add to Cal depends on core's **Datetime** module and the
`spatie/calendar-links` PHP library (installed automatically via Composer), and it
**suggests** the Token module to unlock token support and a handy `addtocal-url`
token for embedding a single calendar URL elsewhere. It has no admin settings page,
permissions, Drush commands, or submodules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — including the `addtocal-url`
token and the `hook_addtocal_links_alter()` hook for customizing the links — read
the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There is no central settings page. Add to Cal appears as a **formatter** on the
*Manage display* screen of any entity that has a supported date field — for example
**Structure → Content types → Event → Manage display**.

## How to use it

1. Make sure your content type (or other entity) has a **date field** of a
   supported type — `date`, `datestamp`, `datetime`, `daterange`,
   `daterange_timezone`, `date_recur`, or `smartdate`.
2. Go to that bundle's **Manage display** screen.
3. Find the date field and, in its **Format** column, choose **Add to Cal** (the
   button-with-menu) or **Add to Cal grouped button** (the compact variant).
4. Click the format's gear icon to configure its settings:
   - **Event title** — token-aware; leave it empty to use the entity's label (for
     example the node title), or set something like `[node:title]`.
   - **Location** — token-aware; pull the venue from a field or type a fixed value.
   - **Description** — token-aware text for the calendar entry.
   - **Separator** — shown only for date-range field types; sets what appears
     between the start and end dates.
   - **Show for past events** — untick to hide the button once an event's start
     time has passed.
   - The inherited **date format** options let you control how the date itself is
     formatted.
5. Click **Update**, then **Save**.

The button then appears wherever that field is displayed, honoring the field's
timezone and handling all-day (time-less) events. If you enable the **Token**
module, you can also drop a single calendar URL anywhere tokens are supported — for
example `[node:field_event_date:addtocal-url:google]` for just the Google Calendar
link (other variants: `yahoo`, `web_outlook`, `web_office`, `ics`).
