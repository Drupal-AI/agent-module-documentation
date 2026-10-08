# Legacy Services `@ServiceDefinition` resources

`src/Plugin/ServiceDefinition/` holds four plugins built for the contrib
[Services](https://www.drupal.org/project/services) module (`Drupal\services\ServiceDefinitionBase`,
`@ServiceDefinition` annotation). They predate the core-REST surface (`api/rest-resources.md`).

**Inert in this branch by default.** The `services` module is **not** a dependency here, and — unlike
the older `3.1.x` branch — this branch ships **no** `services.service_endpoint.*` /
`services.endpoint_resource.*` config. So these plugins only do anything if you install Services
yourself and create an endpoint that exposes them. `hook_uninstall()` in `bat_api.install` still
deletes a `services.service_endpoint.bat_api` config object if one exists (legacy cleanup).

Each plugin pairs with a deriver in `src/Plugin/Deriver/` that sets the resource `path`:

| ServiceDefinition id | Class | Deriver path | GET params |
|----------------------|-------|--------------|------------|
| `events_index` | `EventsIndex` | `events` | `target_ids`, `target_types`, `target_entity_type`, `start_date`, `end_date`, `event_types` |
| `calendar_events_index` | `CalendarEventsIndex` | `calendar-events` | `unit_types`, `event_types`, `unit_ids`, `background`, `path`, `start`, `end` |
| `unit_index` | `UnitIndex` | `calendar-units` | `event_type`, `types`, `ids` |
| `matching_unit_index` | `MatchingUnitIndex` | `calendar-matching-units` | `unit_types`, `event_type`, `event_states`, `start_date`, `end_date` |

All are `methods: {"GET"}`, `translatable: true`, `getCacheMaxAge()` = 0, and implement
`processRequest(Request, RouteMatchInterface, SerializerInterface)`.

## What each returns

- **`CalendarEventsIndex`** — the Services twin of the core `EventsRestResource`: same per-event-type
  `view calendar data for any {type} event` gate, same past-window clamp under
  `view past event information`, same `Calendar::getEvents()` + fixed/open state formatter pipeline.
  Emits `['id' => ..., 'bat_id' => ..., 'resourceId' => 'S'.$unit_id] + $event->toJson()`, runs
  `hook_bat_api_events_index_calendar_alter`, returns `array_values($events_json)`.
- **`EventsIndex`** — like the above but resolves targets by loading entities of `target_entity_type`
  for each `target_ids`, filtered by `target_types`; store is always `DrupalDBStore::BAT_EVENT`. No
  alter hook.
- **`UnitIndex`** — returns unit-type groups with child units for a FullCalendar resource tree:
  `[{id: <type id>, title: <type label>, children: [{id: 'S'.<unit id>, title: <name>,
  create_event: <bool>}]}]`. `create_event` comes from
  `bat_event_access(bat_event_create(['type' => $event_type]), 'create', currentUser)`. With
  `types=all`, iterates unit types whose bundle has a default-event-value field for `event_type`. Runs
  `hook_bat_api_units_index_calendar_alter`.
- **`MatchingUnitIndex`** — computes availability segments: for each date boundary it calls
  `Calendar::getMatchingUnits($sd, $ed, $states, [], FALSE, FALSE)` and emits a `background` event
  colored `green` (some unit available) or `red` (none), with `blocking: 0`. Merges adjacent
  equal-colored segments via `bat_api_merge_non_blocking_events()` and runs
  `hook_bat_api_matching_units_calendar_alter`. Honors the `view past event information` clamp.

## Unit lookup

`UnitIndex`, `MatchingUnitIndex`, `CalendarEventsIndex` each have a `getReferencedIds()` that runs the
same parameterized `unit`-table select as the REST resources (`condition('id', $ids, 'IN')` +
`condition('unit_type_id', $unit_type)`).

> Note: `EventsIndex` and `CalendarEventsIndex` build an event id as
> `(string) $key . $bat_id . $unit_id` where `$bat_id` is never assigned in scope — a latent bug in
> these legacy plugins (the live core-REST `EventsRestResource` does not have this line).
