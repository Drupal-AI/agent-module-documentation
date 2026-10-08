Feeds Ical adds an "Ical Parser" to the Feeds module so you can import events from iCalendar (.ics/.ical) sources into Drupal entities, mapping calendar fields (DTSTART, DTEND, SUMMARY, LOCATION, …) onto content.

---

The module contributes a single Feeds parser plugin, `feeds_ical` ("Ical Parser",
`Feeds/Parser/IcalParser`), that plugs into a Feeds **feed type**; the actual fetching of the source
(a remote URL, uploaded file, or pasted text) is done by whichever Feeds **fetcher** the feed type
uses — Feeds Ical only parses the bytes handed to it. Parsing is delegated to the
`johngrogg/ics-parser` library (`ICal`): the raw string is loaded with `initString()` using a fixed
option set (`defaultTimeZone` UTC, `defaultSpan` 2), and events are read either with `events()` or,
when **Filter Days Before** > 0, `eventsFromRange("now -N days")`. Each event becomes an `IcalItem`
with normalized properties — `dtstart`/`dtend` as UNIX timestamps, `dtstartTimezone`/`dtendTimezone`
in `2019-07-29T06:50:00Europe/Amsterdam` form, `dtstartRaw`/`dtendRaw` for the raw source strings,
`lastModified` as a timestamp (defaulting to now if unparseable) plus `lastModifiedRaw`, and the usual
`uid`, `summary`, `description`, `location`, `status`, `rrule`, etc. — all offered as mapping sources
in the Feeds UI (UID suggests `guid`, SUMMARY suggests `title`). Two parser settings are exposed
(`Feeds/Parser/Form/IcalParserForm`): **Filter Days Before** (ignore events older than N days; 0 =
no filtering) and **Skip Recurrence** (skip RRULE parsing). Parse errors are caught and logged to the
`feeds` channel. Note the module does not yet expand RRULE occurrences into separate items, though the
library can. It has no admin settings page, permission, or config of its own — configuration lives on
the Feeds feed type. Requires Feeds ^3.0 and the ics-parser ^3.4 library.

---

- Import events from a public iCalendar feed URL into an Event content type.
- Sync a Google Calendar / Outlook `.ics` export into Drupal nodes.
- Map DTSTART/DTEND to date fields as UNIX timestamps.
- Map DTSTART/DTEND with timezone (e.g. `...Europe/Amsterdam`) via the Timezone-format sources.
- Keep the raw source date strings using DTSTART_RAW / DTEND_RAW sources.
- Map SUMMARY to the node title (suggested target) and DESCRIPTION to the body.
- Map UID to the feed item GUID for stable de-duplication on re-import.
- Map LAST-MODIFIED to a revision timestamp (auto-converted to UNIX time).
- Import event LOCATION into an address/text field.
- Import STATUS, SEQUENCE, TRANSP, CREATED, DTSTAMP calendar metadata.
- Filter out old events with "Filter Days Before" (e.g. only import events from the last 30 days).
- Import all events regardless of age by leaving Filter Days Before at 0.
- Skip recurrence-rule parsing for performance with "Skip Recurrence".
- Store the raw RRULE string on an imported event for later handling.
- Schedule periodic re-import of a calendar via Feeds' cron/import settings.
- Import from an uploaded .ics file using the Feeds file/upload fetcher.
- Import from pasted iCal text using the Feeds directory/inline fetcher.
- Aggregate multiple team/room calendars into a single events listing.
- Populate a Views-driven calendar or event list from external iCal data.
- Capture additional non-standard iCal properties (X- properties) as extra sources.
