Add to Calendar Date Augmenter provides a Date Augmenter plugin (`addtocal`) that injects "Add to calendar" links (Google, iCal/Apple, Outlook) into a date field's rendered output, with no external libraries.

---

The module implements one `DateAugmenter` plugin, id `addtocal`, that plugs into the Date Augmenter API. Instead of being a standalone field formatter, it augments the output of any date formatter that supports the Date Augmenter API (e.g. Smart Date), so you keep a feature-rich date formatter and add calendar links to its output. When enabled on a field's formatter, `augmentOutput()` builds three calendar targets from the event's start/end `DrupalDateTime`: a Google Calendar template URL, a `data:text/calendar` iCal link (Apple), and an Outlook-oriented iCal link, rendered through the `addtocal_links` theme (or `addtocal_links__modal` when the modal display is chosen, which attaches the module's `modal` JS/CSS library). Event title, location, and description are configurable per formatter and support tokens; the description can be length-trimmed with an optional ellipsis. Timezone handling extracts the timezone from the start date (falling back to the site default) and can be told to ignore UTC. Options control icons vs text, whether links show for past events, and an all-day vs timed event format. All persistent state is the plugin's settings stored as **field-formatter third-party settings** under the `date_augmenter` key (schema `date_augmenter.plugin.addtocal`); there is no admin settings page, permission, or Drush command.

---

- Add Google/Apple/Outlook "add to calendar" links under an event node's date field.
- Let visitors save a webinar's start and end time straight to their calendar.
- Provide calendar links without depending on any third-party JavaScript library.
- Inject calendar links into a Smart Date formatter's output while keeping its rich display.
- Configure the event title from a token (e.g. the node title) for the generated calendar entry.
- Set a fixed or token-based location on the calendar event (e.g. a venue address field).
- Populate the calendar event description from a body/summary field via tokens.
- Trim long descriptions to a maximum length and append an ellipsis.
- Show the links as a compact modal ("Add to calendar" button that opens a dialog) instead of an inline list.
- Display calendar icons instead of text labels for the links.
- Include add-to-calendar links for past events when building an archive of recordings.
- Respect a per-event timezone so the calendar entry lands at the correct local time.
- Ignore the timezone when it is UTC to avoid double-conversion for all-day items.
- Handle all-day events (date-only) with the correct iCal date format.
- Support recurring events by passing an RRULE through the augmenter options (`repeats`).
- Provide a friendly custom label prefix (e.g. "Save the date") before the links.
- Offer consistent calendar links across many content types by enabling the augmenter per field.
- Generate a valid VEVENT with SUMMARY, DTSTART/DTEND, DESCRIPTION, LOCATION and UID.
- Give editors calendar output without writing any custom render code.
- Add calendar links to a conference schedule listing built from a date field.
- Encourage event sign-ups by making it one click to add to a personal calendar.
- Keep the site's stored date data untouched — the plugin only augments display output.
- Combine with a date-range field so both start and end times populate the calendar entry.
- Localize the event title/description per language through translated token sources.
