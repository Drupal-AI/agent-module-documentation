# Import external .ics feeds (Feeds parser)

Optional integration with the contrib **Feeds** module (`drupal/feeds`, not a hard dependency —
the classes only load when Feeds is installed). It lets you import remote/uploaded iCalendar
files into entities.

## Plugin
`src/Feeds/Parser/DateiCalFeedsParser.php` — a `@FeedsParser` (id `date_ical`, "iCal parser").
Select it as the **Parser** on a Feeds feed type; pair it with any Fetcher (URL/upload) and an
entity Processor. It parses the raw `.ics` via `Kigkonsult\Icalcreator\Vcalendar::parse()` and
iterates VEVENT / VTODO / VJOURNAL / VFREEBUSY / VALARM components, emitting an
`ICalItem` (`src/Feeds/Item/ICalItem.php`) per component that has any mapped source. If the
icalcreator library is missing it throws a RuntimeException; an empty feed throws
`EmptyFeedException`; parse failures throw a RuntimeException naming the source.

## Mapping sources (`getMappingSources()`)
Map these to your target entity's fields in the Feeds mapping UI. Each source names an
icalcreator getter:

`summary` (SUMMARY → node title), `comment`, `description`, `dtstart`, `dtend`, `dtstamp`,
`rrule`, `uid` (set Unique to allow updates), `url`, `location`, `location:alrep` (ALTREP),
`categories`, `organizer`, `attendee`, `duration`, `priority`, `status`, `created`,
`last_modified`, `geo:lat`, `geo:lon`, `contact`.

`DateTime` values are converted to the site timezone and formatted as `DATE_ATOM`. Some sources
run a `parse<Field>()` transform: `parseGeolat`/`parseGeolon` split the GEO value,
`parseOrganizer`/`parseAttendee` extract the email address.

## Import alter hooks
Fired by the parser via the module handler:

- `hook_date_ical_import_vcalendar(&$calendar, $context)` — alter the parsed `Vcalendar`
  object before components are read. `$context` has `source` (the feed) and `fetcher_result`.
- `hook_date_ical_import_component(&$vcalendar_components, $context)` — alter the array of
  components of one type before each is converted to an `ICalItem`.

Use these to normalize timezones, filter events, or rewrite properties before they hit the
Feeds processor.
