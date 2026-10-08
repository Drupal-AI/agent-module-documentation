# Build a Views iCal feed

No admin form — everything is done in the Views UI (`/admin/structure/views`). The feed is two
cooperating Views plugins plus the shared generator service.

## Create the feed
1. Add or edit a view whose base entity has a date field (nodes, events, etc.).
2. Add a **Feed** display (or set an existing display's Format via the Feed attachment).
3. Set **Format → iCal Feed** (style plugin `date_ical`, `src/Plugin/views/style/DateIcal.php`).
4. Set **Show → iCal Fields** (row plugin `date_ical`, `src/Plugin/views/row/DateICal.php`).
   The style `render()` hard-requires a `date_ical` / `date_ical_fields` row plugin and errors
   otherwise.
5. Add the view **fields** you want to expose (Date, Title, Body, etc.) — the row plugin only
   offers fields that are actually added to the display, filtered by field type.
6. Give the Feed display a **path** (e.g. `/events/ical`); that path becomes the feed URL.
7. Add a Date filter/argument to scope results (recommended — the DTSTART field is required).

## Row plugin: map fields → iCal properties
Each option is a select limited to compatible field types (`getConfigurableFields()`):

| Row option | iCal property | Notes |
|---|---|---|
| `date_field` (**required**) | DTSTART | daterange/datetime/timestamp/smartdate/created/changed/date_recur. 10-char values become all-day (VALUE=DATE). |
| `end_field` | DTEND | datetime/timestamp. Falls back to start+1 day if empty. |
| `summary_field` | SUMMARY | text/string/list/entity_reference (ref → label). |
| `description_field` | DESCRIPTION | If empty, non-excluded fields are joined as the body; HTML also emitted as X-ALT-DESC. |
| `location_field` | LOCATION | text/address/link/entity_reference; link→ALTREP. |
| `geo_field` | GEO | geofield/geolocation; also adds X-APPLE-STRUCTURED-LOCATION. |
| `categories_field` | CATEGORIES | entity_reference/list. |
| `organizer_field` | ORGANIZER | user reference or email (validated). |
| `attendee_field` | ATTENDEE | user reference or email; sets ROLE/PARTSTAT/RSVP. |
| `status_field` | STATUS | must be CONFIRMED / CANCELLED / TENTATIVE. |
| `rrule` + `rrule_field` | RRULE FREQ + COUNT | dropdown frequency + numeric count. |
| `rrule_raw_field` | RRULE / EXDATE / RDATE / EXRULE | full raw RRULE string; takes precedence over FREQ/COUNT. |
| `url_field` | URL | link/url/entity_reference; forced absolute, http(s) only. |
| `alarm_field` | VALARM | integer field = minutes-before trigger. |
| `attach_field` | ATTACH | file/image/link/entity_reference → file URLs. |

The row plugin resolves each mapped field per row (absolute-izing URLs, decoding entities,
extracting referenced-entity labels/emails) and returns a normalized event array.

## Style plugin: VCALENDAR options
`buildOptionsForm()` exposes calendar-level settings (schema in
`config/schema/date_ical.views.schema.yml`):

- **iCal Calendar Name** (`cal_name`) → X-WR-CALNAME; falls back to view title, then site name.
- **Exclude Calendar Name** (`no_calname`) — omit X-WR-CALNAME so events merge into an existing calendar.
- **Disable webcal://** (`disable_webcal`) — keep http(s) links so the feed downloads as a file instead of subscribing.
- **Exclude DTSTAMP** (`exclude_dtstamp`) — strips DTSTAMP lines post-render so buggy clients don't flag every event as updated.
- **Unescape Commas and Semicolons** (`unescape_punctuation`) — removes spec-required backslash escaping (non-compliant, but works around client bugs).
- **Skip blank dates** (`skip_blank_dates`, default on) — silently drop rows with no date instead of erroring.
- **Download directly** (`download_directly`, default on) — send `Content-Type: text/calendar`.

`attachTo()` adds the feed icon/`<link rel=alternate type=text/calendar>` to the parent
display and rewrites the URL to `webcal://` unless disabled. `render()` sets an Expires header
(+2 days) and suppresses the devel shutdown handler.

## Alter hooks (export)
Invoked via the module handler during rendering:

- `hook_date_ical_export_vevent(&$vevent, $view, $row)` — alter each event array before it is added to the calendar.
- `hook_date_ical_export_post_render(&$vcalendar, $view)` — alter the final VCALENDAR string.

The normalized event array is then passed to the `date_ical.feed` service — see
[../api/service.md](../api/service.md) for how properties become icalcreator calls.
