# Add to Calendar — manual setup guide

**Add to Calendar** (`add_to_calendar`) gives your event pages an "add to
calendar" button without you having to build any links by hand. It provides a
**computed field** — a field that generates its value automatically from other
fields on the same content — that turns an event's date, title, and location into
ready-to-use calendar links for **Google Calendar**, **Outlook**, and an **iCal**
download. A visitor clicks and the event drops straight into their own calendar.

Because the links are computed from the event's own date/range field, there's
nothing to keep in sync: change the event date and the calendar links update with
it. It depends on Drupal core's **Datetime Range** module, which supplies the
start/end date field the links are built from.

This is a display-layer field. It stores no data of its own and has no security
surface — the links simply reflect the event content that's already on the page.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no dedicated settings page. You add and arrange the calendar links per
content type under **Structure → Content types → [your event type] → Manage
display** (and, for placing the field, **Manage fields**).

## How to use it

1. Make sure your event content type has a **date** or **date range** field
   (provided by core Datetime Range) holding the event's start/end time.
2. Go to **Structure → Content types**, pick your event type, and open **Manage
   fields**. Add the Add to Calendar computed field to the content type.
3. Open **Manage display** for that content type and position the field where you
   want the button to appear, then configure it to point at your event's date,
   title, and location fields as the source data.
4. Save. View an event — the Google / Outlook / iCal calendar links now render
   from the event's own fields.
