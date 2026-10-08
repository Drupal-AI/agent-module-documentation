# Configure the Ical Parser (Feeds)

Feeds Ical has no page of its own. You configure it on a **Feeds feed type**
(`/admin/structure/feeds`): create/edit a feed type and choose **Ical Parser** as the Parser. The
**Fetcher** (Download from URL, Upload file, etc.) is a separate Feeds plugin you also choose — Feeds
Ical never fetches; it only parses the bytes the fetcher returns.

## Parser settings (`IcalParserForm`)

`defaultConfiguration()` = `filter_days_before => 0`, `skip_recurrence => FALSE`.

| Setting | Type | Meaning |
|---|---|---|
| `filter_days_before` | number (min 0) | Ignore events older than N days. **0 = no filtering.** When > 0 the parser calls `eventsFromRange("now -N days")`; when 0 it passes `NULL` to the library's `filterDaysBefore` (0 would be treated as "now" and drop today's events) and reads all events. |
| `skip_recurrence` | checkbox | Passed to the library as `skipRecurrence` — toggles whether RRULE parsing is skipped. |

Fixed (non-configurable) `ICal` options used: `defaultSpan` 2, `defaultTimeZone` UTC,
`defaultWeekStart` MO, `disableCharacterReplacement` FALSE, `useTimeZoneWithRRules` FALSE.

## Mapping sources (`getMappingSources()`)

Available in the feed type's **Mappings** tab:

| Source key | Label / value |
|---|---|
| `dtstart` / `dtend` | Start/End as **UNIX timestamp** (`dtX_array[2]`). |
| `dtstartTimezone` / `dtendTimezone` | Start/End in `2019-07-29T06:50:00Europe/Amsterdam` form (or raw if no TZID). |
| `dtstartRaw` / `dtendRaw` | Raw source date strings. |
| `dtstamp` | DTSTAMP. |
| `rrule` | Raw recurrence rule string. |
| `uid` | UID (suggested target: `guid`). |
| `created` | CREATED. |
| `description` | DESCRIPTION. |
| `lastmodified` | LAST-MODIFIED (see note). |
| `lastModifiedRaw` | Raw LAST-MODIFIED string. |
| `location` | LOCATION. |
| `sequence` | SEQUENCE. |
| `status` | STATUS. |
| `summary` | SUMMARY (suggested target: `title`). |
| `transp` | TRANSP. |

Notes on normalization (in `IcalParser::parse()`):
- `dtstart`/`dtend` are stored as timestamps; a `dtend` with no `dtend_array[2]` is skipped.
- `last_modified`: mapped to `lastModified` as `strtotime()`; if empty/unparseable it defaults to
  `time()` (now). `lastModifiedRaw` keeps the original.
- Any extra event `additionalProperties` (e.g. `X-` properties) are copied onto the item too,
  except keys containing `_array`.
- Errors during parsing are caught and logged to the `feeds` logger channel; the parser returns
  whatever items were built.

## Config example (feed type)

```php
$ft = \Drupal\feeds\Entity\FeedType::load('events');
$ft->setParser('feeds_ical');
$ft->getParser()->setConfiguration(['filter_days_before' => 30, 'skip_recurrence' => TRUE]);
$ft->save();
```
