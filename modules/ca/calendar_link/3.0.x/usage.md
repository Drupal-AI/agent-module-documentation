<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Calendar Link exposes two Twig functions — `calendar_link()` and `calendar_links()` — that build "add to calendar" URLs (Google, Yahoo, iCal/`.ics`, Outlook, Office 365) from an event's title, dates, description and location, so themers add calendar buttons in templates without writing PHP.

---

Event content — a meeting, a webinar, a concert, a class — is more useful when a visitor can add it to their own calendar in one click. Calendar Link solves that at the template layer: pass an event's fields (title, start/end `DateTime`, all-day flag, description, location) to `calendar_link('google', ...)` for a single provider, or `calendar_links(...)` for an array of every supported provider, and render the returned URL(s) as links or buttons.

Everything happens server-side in Twig as pure URL construction — there are no routes, no stored configuration, no external API calls and no JavaScript. The generation is driven entirely by the values the template passes in, which normally come from the node's own fields. Twig auto-escapes the returned URL strings (the functions do not mark output as safe HTML), so field values flow through core's normal escaping.

For event nodes, program listings, course schedules and any date-bearing content, it is a dependency-free way to offer Google/Yahoo/iCal/Outlook links. The main integration task is mapping your date field(s) to PHP `DateTime` objects and choosing which providers to render; Views support lets the links appear in listings as well as full content.

---

- Add an "add to calendar" button to an event node.
- Generate a Google Calendar link in a Twig template.
- Offer iCal (`.ics`) download links for events.
- Render Outlook / Office 365 calendar links.
- Produce links for all providers at once with `calendar_links()`.
- Map a node date field to a calendar link.
- Show calendar links in a Views listing.
- Add calendar buttons to a webinar page.
- Link a class schedule to Google Calendar.
- Build a Yahoo Calendar link.
- Handle all-day events in calendar links.
- Include event location in the calendar link.
- Include a description in the calendar link.
- Add calendar links without custom PHP.
- Theme a per-event calendar dropdown.
- Support multiple events on one page.
- Generate calendar links for a concert listing.
- Add "save the date" links to an invitation.
- Expose calendar links in a paragraph template.
- Offer calendar links for a conference agenda.