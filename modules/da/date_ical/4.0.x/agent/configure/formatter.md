# "Add to calendar" field formatter + feed/download routes

Besides Views feeds, the module can turn a single date field into an "Add to calendar" link,
backed by two controller routes.

## Field formatter
`src/Plugin/Field/FieldFormatter/DateIcalFormatter.php` (id `date_ical`, extends core
`DateTimeDefaultFormatter`) applies to `daterange`, `datetime`, `timestamp`, `smartdate`,
`published_at` fields. Configure it at *Manage display* for the entity/view mode:

1. Set the date field's format to **Date iCal**.
2. In the formatter settings, map optional properties (`summary_field`, `description_field`,
   `location_field`, `geo_field`, `categories_field`, `organizer_field`, `attendee_field`,
   `status_field`, `url_field`, `rrule`/`rrule_field`, `alarm_field`, `attach_field`) — same
   property set as the Views row plugin, restricted to compatible field types on the same bundle.
3. Toggle **Disable webcal://** (default on here) and **Download directly**.

The rendered date is wrapped in a `date_ical_icon` themed link (`templates/date-ical-icon.html.twig`,
default 📅) pointing at the `date_ical.field` route with the chosen mappings as query args, and
`download="event.ics"`. Formatter settings schema: `field.formatter.settings.date_ical` in
`config/schema/date_ical.schema.yml`.

## Routes (date_ical.routing.yml)
Both routes are `_access: 'TRUE'` (open) but the feed controller does its own access checks.

### `date_ical.field` — `/date-ical/{entity_type}/{entity_id}/{field_name}/{view_mode}`
`DateIcalController::feed()` loads the entity, then **enforces access before emitting data**:
- 404 if the entity type/entity/field doesn't exist.
- `AccessDeniedHttpException` if the current user lacks `view` on the entity.
- `AccessDeniedHttpException` if the user lacks `view` on the date field.
- Each mapped field is re-checked with `isAccessibleFieldMapping()` (field-level `view` access)
  before its value is added — a caller cannot exfiltrate fields they can't see.

Field mappings come from the view-mode display's formatter settings, but URL query params
override them (`$fieldSettings = $query`), so the endpoint can render an ad-hoc event for any
field the current user is allowed to view. It returns a single-entity VCALENDAR.

### `date_ical.download` — `/date-ical/download`
`DateIcalController::download()` builds a **one-off event from query params** — used by the
CKEditor button. Inputs are sanitized: `summary`/`description`/`location`/`categories` go
through `PlainTextOutput::renderFromHtml()`, `organizer` must pass `FILTER_VALIDATE_EMAIL`,
`url` must pass `FILTER_VALIDATE_URL`, and `dtstart`/`dtend` feed the generator (invalid dates
return HTTP 400). Responds with `Content-Disposition: attachment; filename=event.ics`.

Both controllers hand the assembled events to the `date_ical.feed` service — see
[../api/service.md](../api/service.md).
