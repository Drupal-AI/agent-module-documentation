# Alter hooks + helpers (for integrators)

`bat_api` invokes three alter hooks so other modules can reshape the calendar JSON before it is
returned. They are documented in `bat_api.api.php`. Implement them in your `MODULE.module`.

## `hook_bat_api_events_index_calendar_alter(array &$events, array $context)`

Invoked by the events endpoints (`EventsRestResource::get()` and legacy `CalendarEventsIndex`) just
before the response is built. `$events` is the FullCalendar events array (each item has
`resourceId`, `bat_id`, and the formatter's `toJson()` keys). `$context` carries the request inputs:
`unit_ids`, `unit_types`, `start_date`, `end_date`, `event_types`, `background` (and, when a specific
`edit event entities` / `bee.node.availability` condition holds, a `useraccess` marker).

```php
function mymodule_bat_api_events_index_calendar_alter(array &$events, array $context) {
  foreach ($events as &$event) {
    // e.g. add a display field or filter events out.
  }
}
```

## `hook_bat_api_units_index_calendar_alter(array &$units)`

Invoked by the legacy `UnitIndex` service before returning the unit-type/children tree. `$units` is the
resource tree (`[{id, title, children: [...]}]`).

## `hook_bat_api_matching_units_calendar_alter(array &$events, array $context)`

Invoked by the legacy `MatchingUnitIndex` service after the green/red availability segments are
computed and merged. `$context` has `unit_types`, `start_date`, `end_date`, `event_type`,
`event_states`.

## Helper: `bat_api_merge_non_blocking_events($events)`

In `bat_api.module`. Collapses consecutive `rendering == 'background'`, non-`blocking` events that
share `resourceId`, `title`, and `color` into a single continuous span (extends the previous event's
`end`, drops the later one). Used internally by `MatchingUnitIndex`; safe to call on your own
FullCalendar background-event arrays.
