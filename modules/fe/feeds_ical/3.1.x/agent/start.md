# Feeds Ical — agent index

Adds an **Ical Parser** to Feeds for importing iCalendar (.ics) events. No global config
(`configure` null), no permission, no Drush, no config schema — all config is on the Feeds feed type.
Requires `feeds:feeds` (^3.0) and the `johngrogg/ics-parser` (^3.4) library.

- **Set up a feed type with the parser: the two parser settings, the mapping sources, and how
  fetch vs. parse split** → [configure/parser.md](configure/parser.md)

Key facts:
- Parser plugin id `feeds_ical` (`Feeds/Parser/IcalParser`), custom source plugin `feeds_ical`
  (`IcalSource` extends Feeds `BlankSource`), item class `IcalItem`.
- Feeds Ical **only parses** the raw bytes; fetching (remote URL / file / inline) is done by the
  feed type's Feeds fetcher, configured by a feed-type admin — no fetching/SSRF logic here.
- Parsing delegated to `ICal::initString()` with fixed options (`defaultTimeZone` UTC, `defaultSpan`
  2); events via `events()` or `eventsFromRange("now -N days")` when Filter Days Before > 0.
- Settings: `filter_days_before` (0 = no filter), `skip_recurrence` (skip RRULE parsing).
- Does not yet expand RRULE occurrences into separate items. Parse errors logged to `feeds` channel.
