# The `date_ical.feed` service

`services.yml` registers one service:

```yaml
date_ical.feed:
  class: Drupal\date_ical\DateICal
```

It implements `Drupal\date_ical\DateICalInterface`:

```php
public function feed(array $events, array $header = []): string;
```

Both Views plugins and both controller routes depend on it (`$container->get('date_ical.feed')`),
and you can call it from custom code to produce a VCALENDAR string.

## Input shape
- `$header` — associative array of X-WR-* values (keys `CALNAME`, `CALDESC`, `RELCALID`,
  `TIMEZONE`, …); each becomes `x-wr-<key>` via `setXprop`. Empty values are skipped.
- `$events` — a list of event arrays. Recognized keys (all optional except `date_field`):
  `date_field` (DTSTART; scalar timestamp/ISO string, or an array with `value`/`end_value`),
  `end_field` (`['value' => …]`), `summary_field`, `description_field`, `location_field`
  (string or `['title','url']`), `geo_field` (`['lat','lon']`), `categories_field`,
  `organizer_field`, `attendee_field` (list of `['mail','name']`), `status_field`, `url_field`,
  `rrule`/`rrule_field`, `rrule_raw_field`, `alarm_field`, `attach_field`, plus metadata keys
  `created`, `last-modified`, `uuid` (UID), `exclude_dtstamp`.

## What it does (`src/DateICal.php`)
- Builds a `Kigkonsult\Icalcreator\Vcalendar` (UNIQUE_ID = site `$base_url`, METHOD = PUBLISH).
- Per event, normalizes start/end to `DateTime` in UTC: 10-char dates become all-day
  (`VALUE=DATE`); missing end defaults to start + 1 day; swapped start/end are re-ordered.
- Emits VEVENT with TRANSP=OPAQUE, CLASS=PUBLIC, then conditionally SUMMARY (stripped/collapsed),
  DESCRIPTION (+ `X-ALT-DESC;FMTTYPE=text/html` when HTML differs), GEO,
  LOCATION (+ ALTREP, + X-APPLE-STRUCTURED-LOCATION when geo present), ORGANIZER/ATTENDEE
  (email-validated), CATEGORIES, STATUS (whitelist), URL, ATTACH, VALARM.
- Recurrence: `rrule_raw_field` is parsed by `parseRruleString()` (accepts optional `RRULE:`
  prefix, casts COUNT/INTERVAL) and can also carry `EXDATE` / `RDATE` / `EXRULE` lines
  (`parseDateListLines()`); otherwise falls back to `FREQ` + numeric `COUNT`.
- Calls `->vtimezonePopulate()->createCalendar()` to render VTIMEZONE blocks + the string.

Callers post-process the returned string (e.g. `str_replace('kigkonsult.se ', '', $out)`,
optional DTSTAMP stripping / punctuation unescaping) — the service itself does not.

## Related hooks
Alter hooks are invoked by the *callers*, not this service: export hooks
(`hook_date_ical_export_vevent`, `hook_date_ical_export_post_render`) fire in the Views style
plugin — see [../configure/feed.md](../configure/feed.md); import hooks fire in the Feeds
parser — see [../extend/feeds-import.md](../extend/feeds-import.md).
