Views iCal adds Views plugins that render a view's results as an iCalendar (`.ics`) feed, so any content with dates (events, bookings, deadlines) can be published as a calendar subscribable in Google Calendar, Apple Calendar, Outlook, etc.

---

The module ships a Views **display** plugin (`ical`, extending core's Feed display, adding an optional download `filename`), two **style** plugins, and two matching **row** plugins. The recommended path is the "wizard" pair: the `ical_wizard` style ("iCal Style Wizard") plus the `ical_fields_wizard` row ("iCal fields row wizard"), which build VEVENT components with the bundled `eluceo/ical` PHP library — you add plain Views fields (a date/start field, end date, title, etc.) and then map them to iCal properties in the style's settings form. A legacy pair also exists: the `ical` style ("Legacy iCal style") and `ical_fields` row ("Legacy iCal Fields row"), where each field is manually labelled to match the RFC 5545 spec (DTSTAMP, DTSTART, DTEND, SUMMARY, UID) and dates formatted as `Ymd\THis\Z`; the wizard is recommended for new feeds. The display sets the `Content-Type: text/calendar` header (and a `Content-Disposition` attachment header when a filename is set) via template preprocess. The module also installs a locked core date format, `views_ical` ("Views iCal date", pattern `Ymd\THis\Z`), for use on date fields in the legacy flow, and uses `html2text/html2text` to convert rich-text descriptions to plain text. It provides no admin settings page, permissions, services beyond a helper, or config schema of its own — all configuration lives inside the view.

---

- Publish a public events calendar as a subscribable `.ics` feed from an "Event" content type.
- Let visitors add site events to Google Calendar / Apple Calendar / Outlook via one feed URL.
- Export a room- or resource-booking view as an iCalendar feed.
- Offer a "Download .ics" link with a custom filename (e.g. `events.ics`) via the display's filename option.
- Build the feed the easy way with the iCal Style Wizard and iCal fields row wizard, mapping fields to VEVENT properties.
- Produce a standards-compliant RFC 5545 feed the manual way with the legacy style + labelled fields.
- Include event summaries/descriptions, converting HTML bodies to plain text automatically.
- Expose start and end dates, including date-range fields, as DTSTART / DTEND.
- Attach the iCal feed to an existing page display so the calendar link appears as an alternate representation in the page head.
- Filter the feed with standard Views filters (only upcoming events, only a category, etc.).
- Sort events chronologically using Views sort criteria before export.
- Serve a per-user or per-argument calendar using contextual filters (e.g. events for one organizer).
- Format dates in UTC (`Ymd\THis\Z`) using the shipped "Views iCal date" date format.
- Set the calendar title from the view title or the site name + slogan.
- Emit correct `text/calendar; charset=utf-8` headers so browsers/clients treat the response as a calendar.
- Generate unique UIDs for events so calendar clients de-duplicate and update entries correctly.
- Provide a departmental or team calendar feed driven entirely by Views configuration, no code.
- Combine with contextual filters to output one attendee's schedule as a personal calendar.
- Migrate an older Views iCal feed to the wizard plugins for easier maintenance.
- Theme the raw feed output by overriding `views-view-ical.html.twig` / `views-view-ical-fields.html.twig`.
- Export deadlines from a project/task view so they appear on a team's shared calendar.
- Publish a class or session timetable as an iCal subscription.
