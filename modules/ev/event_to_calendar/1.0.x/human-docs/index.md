# Event to Calendar — manual setup guide

**Event to Calendar** (`event_to_calendar`) turns your event nodes into
calendar-friendly outputs so visitors can save events to their own calendars or
subscribe to a feed. For a configured event, it can produce an **iCal (.ics)**
download, a **vCalendar (.vcs)** download, a **CSV** export, an **RSS feed**, and
**"Add to Calendar"** redirect links for **Google, Outlook, and Yahoo**.

You tell the module, per content type, which fields hold the **start date**, **end
date**, and **location**. Its controller then reads those fields to build each
format on demand. A ready-made **"Add to Calendar" block** is provided so you can drop
the links onto your event pages, and you can also link to the endpoints directly from
a template.

It suits event-heavy sites — universities, conferences, community organizations — that
want to offer one-click calendar integration for their events.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable
   it.
2. [Configuration](configuration/index.md) — choose which content types are events and
   map their date and location fields.

## Where it lives in the admin menu

The settings form lives at **/admin/config/event-to-calendar** (it requires the
**Administer site configuration** permission). The per-event outputs are served from
paths under `/event/{node_id}/…` — for example `/event/123/ical`, `/google`,
`/outlook`, `/yahoo`, `/rss`, `/vcs`, and `/csv`.

## How to use it

1. Configure your event content types and their field mappings — see
   [Configuration](configuration/index.md).
2. Place the provided **Add to Calendar** block from **Structure → Block layout** (or
   via Layout Builder) on your event pages, or add your own links pointing at the
   `/event/{node_id}/…` paths.
3. Visitors then see buttons/links to download the event as iCal/vCal/CSV, subscribe
   via RSS, or add it to Google, Outlook, or Yahoo calendars.

The per-event download and link endpoints use the **access content** permission. The
RSS feed filters to published content. This project is **not covered by Drupal's
security advisory policy**.
