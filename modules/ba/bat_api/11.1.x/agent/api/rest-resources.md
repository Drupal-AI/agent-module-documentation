# REST resources (core `rest`)

The current API surface is two core REST resource plugins in
`src/Plugin/rest/resource/`. They serve a FullCalendar front end: one returns the **resources** (BAT
units), the other returns the **events** (availability) for a date range.

## Enabling

These are standard core REST resources. Enable/configure them with REST UI (`restui`, a dependency) or
by installing the shipped config in `config/install/`:

```yaml
# rest.resource.bat_api_events_resource.yml  (and ...units_resource.yml)
id: bat_api_events_resource
plugin_id: bat_api_events_resource
granularity: resource
configuration:
  methods: [GET]
  formats: [json]
  authentication: [cookie]
```

Enabling a REST resource makes core generate the permission `restful get <resource_id>`, i.e.
`restful get bat_api_events_resource` / `restful get bat_api_units_resource`; a caller must hold that
permission (and satisfy the configured `cookie` authentication) to reach the endpoint. Requests are
served as JSON; both resources force `max-age: 0` (never cached).

## `bat_api_events_resource` — `GET /bat_api/rest/calendar-events`

Class `Drupal\bat_api\Plugin\rest\resource\EventsRestResource::get()`. Returns the events (availability
segments) for the requested unit types over a date window, formatted for FullCalendar.

Query parameters (all read from `?...`):

| Param | Meaning |
|-------|---------|
| `unit_types` | Comma-separated BAT unit-type ids, or `all` (expands via `bat_unit_get_types()`). |
| `event_types` | Comma-separated BAT event-type ids, or `all` (expands via `bat_event_get_types()`). |
| `unit_ids` | Comma-separated unit ids to restrict to (empty = all units of the type). |
| `background` | Passed to the event formatter (`setBackground()`) — FullCalendar background rendering. |
| `path` | Read into `$data['path']` (context only). |
| `start` | Window start; parsed as `new \DateTime($start)`. |
| `end` | Window end; parsed as `new \DateTime($end)`. |

Behavior:
- For each requested event type, the caller must hold `view calendar data for any {event_type} event`
  (from `bat_event`); types the caller lacks are skipped.
- Without `view past event information`, the window start is clamped to "now"; if the whole window is
  in the past, returns `[]`.
- Units are resolved with a direct `unit` table query (see below), wrapped as
  `bat_roomify\Unit\Unit`, and availability is read via `bat_roomify\Calendar\Calendar::getEvents()`
  against a `DrupalDBStore` (state store when the event type `usesStates()`, else event store).
- Each event is serialized with `FullCalendarFixedStateEventFormatter` or
  `FullCalendarOpenStateEventFormatter` (chosen by `$bat_event_type->getFixedEventStates()`), then
  emitted only when `$event->getValue() > 0` as
  `['resourceId' => $unit_id, 'bat_id' => $event->getValue()] + $event->toJson($formatter)`.
- The full array is passed through `hook_bat_api_events_index_calendar_alter($events_json, $context)`
  before being returned in a `ResourceResponse`.

## `bat_api_units_resource` — `GET /bat_api/rest/calendar-units`

Class `UnitsRestResource::get()`. Returns the units of a type as FullCalendar resources.

| Param | Meaning |
|-------|---------|
| `unit_type` | A single BAT unit-type id. |
| `unit_ids` | Comma-separated unit ids to restrict to (empty = all of the type). |

Returns `getReferencedIds()` → `[{ "id": <unit id>, "title": <unit name> }, ...]`. Response is
uncached (`getCacheMaxAge()` returns 0).

## Unit lookup query

Both resources fetch units with the DB API against the `unit` table (BAT's unit storage), e.g.:

```php
$query = $this->connection->select('unit', 'n')
  ->fields('n', ['id', 'unit_type_id', 'type', 'name']);
if (!empty($ids)) {
  $query->condition('id', $ids, 'IN');   // $ids = explode(',', unit_ids)
}
$query->condition('unit_type_id', $unit_type);
```

`unit_ids` and `unit_type` are bound as parameters via `condition()` (placeholders), not concatenated
into SQL. The lookup is a direct table read (not an entity query), so it returns id/name for every
matching row of the type.

## Notes

- `EventsRestResource` logs to the `example_rest` channel and injects `current_user`, `request_stack`,
  `database`, `bat_fullcalendar.fixed_state_event_formatter`,
  `bat_fullcalendar.open_state_event_formatter`, and `module_handler`.
- `BatApiMiddleware` would set the response/request format from a `?_format=` arg, but the module
  registers no service for it in this branch, so `_format` is not honored here — pass the standard
  core REST format negotiation instead.
