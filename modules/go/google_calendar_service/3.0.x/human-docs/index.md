# Google Calendar Service — manual setup guide

**Google Calendar Service** (`google_calendar_service`) connects Drupal to Google
Calendar so you can import calendar events into your site and keep them in sync. You
create Calendar entities in Drupal, point each at a Google Calendar ID, and the
module pulls the events in — either all of them or within a chosen time range. It's
built for sites that want to track and display calendars and their events over time.

Authentication uses a **Google service account** (with domain‑wide delegation to
read the target calendar), rather than an interactive OAuth login. You upload the
service account's JSON key file and supply the user email the delegation acts as.
The module depends on core **Inline Entity Form**, **Text**, **User** and **Views**.

> **Credentials.** Store the service‑account key file outside the web root and out
> of version control, and scope the delegation as narrowly as possible.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the
   Google API PHP client) and enable the module.
2. [Configuration](configuration/index.md) — create a Google Cloud project and
   service account, share your calendar with it, and wire up the module.

## Where it lives in the admin menu

The settings form is at **Configuration → Google Calendar Service → Settings**
(`/admin/config/google-calendar-service/settings`). Calendars are managed at
`/calendar` (add one at `/calendar/add`), where each calendar row offers an **Import
Events** operation.

## How to use it

After the module is configured, go to `/calendar`, add a calendar (giving it a name
and the Google Calendar ID to read), save it, then use the **Import Events**
operation on that calendar. Importing may take a moment; afterward the events appear
under the calendar.
