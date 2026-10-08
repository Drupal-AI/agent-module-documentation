<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Event to Calendar turns event nodes into calendar-friendly outputs: it can produce an iCal (.ics) download, a vCalendar (.vcs) download, a CSV export, an RSS feed, and "Add to Calendar" redirect links for Google, Outlook and Yahoo. Site builders map, per content type, which fields hold the start date, end date and location, and the controller reads those to build each format. An "Add to Calendar" block is also provided.
It suits event sites that want visitors to save events to their own calendars or subscribe to an events feed.
---
Install with `drush en event_to_calendar` (requires `node`, `views`, `field`). Configure enabled content types and their start/end date and location field mappings at `/admin/config/event-to-calendar` (permission `administer site configuration`). Then expose the per-event links (e.g. via the provided Add to Calendar block or template links) pointing at `/event/{event_id}/ical`, `/google`, `/outlook`, `/yahoo`, `/rss`, `/vcs` or `/csv`.
Every download/link route requires `_permission: 'access content'`; the single-node controllers (`generateIcal`, `generateVcs`, `generateCsv`, `getGoogleCalendarUrl`, `getOutlookCalendarUrl`, `getYahooCalendarUrl`) load the node by ID and output its title, body and location. The RSS feed method filters on `status = 1`.
---
- Install: `composer require drupal/event_to_calendar && drush en event_to_calendar -y` (needs node, views, field).
- Configure at `/admin/config/event-to-calendar` (perm `administer site configuration`).
- Enable the content types that represent events.
- Map each type's start date, end date and location fields.
- Add an iCal download link: `/event/{nid}/ical`.
- Add a vCalendar (.vcs) download link: `/event/{nid}/vcs`.
- Add a CSV export link: `/event/{nid}/csv`.
- Offer an RSS feed of published events: `/event/{nid}/rss`.
- Add "Add to Google Calendar" via `/event/{nid}/google` (redirect).
- Add Outlook/Yahoo add-to-calendar via `/event/{nid}/outlook` and `/yahoo`.
- Place the provided "Add to Calendar" block.
- Dates are converted from America/Denver to UTC in the output.
- The RSS method filters on published status.
