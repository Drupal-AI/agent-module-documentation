# Views iCal — manual setup guide

**Views iCal** (`views_ical`) turns any View of dated content — events, bookings,
deadlines, sessions — into a subscribable iCalendar (`.ics`) feed. Point Google
Calendar, Apple Calendar or Outlook at the feed's URL and your site's dates show
up as calendar entries that stay in sync. Everything is built with the Views UI:
the module adds new Views *display*, *style* and *row* plugins, so there is no
settings page and no code to write.

The recommended way to build a feed is the **wizard** pair — the *iCal Style
Wizard* style plus the *iCal fields row wizard* row. You add the plain Views
fields you need (a start date, an end date, a title), then map each one to an
iCal property (DTSTART, DTEND, SUMMARY, UID, …) in the style's settings form. Under
the hood the wizard assembles standards-compliant VEVENT components with the
bundled `eluceo/ical` PHP library, and converts any rich-text descriptions to
plain text automatically. A legacy style and row are also included for people who
prefer to label each field by hand to match the RFC 5545 spec, but the wizard is
recommended for all new feeds.

The feed is served with the correct `Content-Type: text/calendar` header so
browsers and calendar apps treat it as a calendar rather than a web page. You can
give the display a custom download filename (for example `events.ics`), filter and
sort the feed with ordinary Views filters and sorts, and use contextual filters to
produce per-organizer or per-user calendars. The module depends only on core's
Views module and bundles the two PHP libraries it needs (`eluceo/ical` and
`html2text/html2text`).

This guide is written for a **human** clicking through the Views UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

Views iCal has no admin settings page — a feed is configured entirely inside a
View. Once the module is enabled, build a feed like this:

1. Create a View of the content that has dates (for example your *Event* content
   type).
2. Add an **iCal Display** to the view.
3. Under **Format**, set the style to **iCal Style Wizard**.
4. Under **Show**, set the row plugin to **iCal fields row wizard**.
5. Add the Views **fields** you need — at minimum a start date, an end date
   (date-range fields are supported) and a title.
6. Open the **Format** (style) settings and map each iCal property
   (DTSTART / DTEND / SUMMARY / UID / …) to one of the fields you added. See
   [icalendar.org](https://icalendar.org) for what each property means.
7. Give the display a **path**, and optionally set a **filename** (such as
   `events.ics`) in the iCal settings so the download is named nicely.

Save the view and visit the display's path — you now have a live `.ics` feed you
can hand to any calendar application. Add standard Views filters to limit the feed
(only upcoming events, only a category), sorts to order it chronologically, and
contextual filters to produce personalized calendars.

If you prefer the manual RFC 5545 approach, use the **Legacy iCal style** with the
**Legacy iCal Fields row** and label each field (DTSTAMP, DTSTART, DTEND, SUMMARY,
UID) yourself, formatting dates with the shipped **Views iCal date** format
(pattern `Ymd\THis\Z`). The wizard is easier and is recommended for new feeds.
