<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Add to calendar provides a computed field and formatter that render "add to calendar" links (Google, iCalendar, Office, Outlook, Yahoo) from a content entity's date-range, description, and address fields, using the Spatie Calendar Links PHP library with no external services.

---

Add to calendar lets you place an "add to calendar" element on any content entity type. You enable the module's computed field per entity type at a settings form, then on each bundle's Manage display you choose the "Add to calendar" formatter and map a daterange field (start/end), an optional description field, and an optional address field to the calendar link. The formatter builds one link per enabled generator — Google Calendar, iCalendar (ics), Office Calendar, Outlook Calendar, Yahoo Calendar — from the event's own field values. Links are generated entirely in PHP via `spatie/calendar-links`, so no third-party JavaScript widget or API call is involved; the iCalendar link is a self-contained data URI. The element only appears for events whose end date is in the future.

---

- Add an "add to calendar" element to event nodes.
- Generate a Google Calendar link from a date-range field.
- Offer an iCalendar (.ics) download link with no external service.
- Add an Outlook Calendar link to an event page.
- Add an Office 365 / Outlook.com web calendar link.
- Add a Yahoo Calendar link.
- Build all calendar links from a single daterange field's start and end values.
- Include the event description in the calendar entry from a text field.
- Include the event location/address in the calendar entry from a string field.
- Show calendar links only for upcoming (future-dated) events.
- Enable the add-to-calendar field only on chosen entity types (nodes, media, etc.).
- Configure calendar options per bundle on Manage display.
- Choose exactly which calendar providers appear via checkboxes.
- Avoid manual construction of provider-specific calendar URLs.
- Keep event calendar links in sync with the entity's date field automatically.
- Add calendar links to any content entity type, not just nodes.
- Use a computed field so no extra database storage is consumed.
- Restrict who can enable the field via a dedicated admin permission.
- Pair with Font Awesome for a calendar icon on the label (suggested dependency).
- Provide calendar links for conferences, webinars, or meetups.
- Let visitors save a class or session to their personal calendar.
- Theme the calendar link list with the module's Twig template and CSS.
