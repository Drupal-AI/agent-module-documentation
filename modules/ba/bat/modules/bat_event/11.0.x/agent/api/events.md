# BAT Event — availability & CRUD API

All functions in `bat_event.module` unless noted. The heavy lifting delegates to the Roomify
`roomify/bat` library (`Calendar`, `DrupalDBStore`, `Event`).

## Availability queries

- `bat_event_get_matching_units(DateTime $start, DateTime $end, $valid_name_states, $type_ids, $event_type, $intersect = FALSE, $drupal_units = [])`
  — unit ids that are in the given states over the period.
- `bat_event_get_calendar(array $type_ids, string $event_type, $drupal_units = [])` — build a
  `Roomify\Bat\Calendar\Calendar` for the units of those types.
- `bat_event_get_matching_units_from_calendar($calendar, DateTime $start, DateTime $end, $valid_name_states, $intersect = FALSE, $reset = TRUE)`.
- `bat_event_get_calendar_response(DateTime $start, DateTime $end, $valid_name_states, $type_id, $event_type, $intersect = FALSE)`
  — a response object with included/excluded units.
- `bat_event_constraints_get_info()` — collected booking constraints (from
  `hook_bat_event_constraints_info`), applied when matching.

## States

`bat_event_get_states($event_type = NULL, array $conditions = [])`, `bat_event_load_state($id)`,
`bat_event_load_state_by_machine_name($name)`, `bat_event_create_state($values)`,
`bat_event_save_state(State $state)`.

## Event & event-type CRUD

- Events: `bat_event_load($id, $reset)`, `bat_event_load_multiple($ids, $reset)`,
  `bat_event_create($values)`, `bat_event_save(Event $e)`, `bat_event_delete(Event $e)`,
  `bat_event_delete_multiple($ids)`, `bat_event_ids($conditions)`, `bat_event_uri(Event $e)`.
- Types: `bat_event_get_types($name, $reset)`, `bat_event_type_load($type)`,
  `bat_event_types_ids()`, `bat_event_type_create/save/delete`.

## Event entity methods (`Drupal\bat_event\Entity\Event`)

- `getUnit()` / `getUnitId()` / `setUnit()` / `setUnitId()` — the target unit.
- `getEventValue()` — resolves the type's value field (entity_reference id, commerce_price number, or
  scalar value).
- `getEventLabel()` — resolves the type's `default_event_label_field_name`.
- `batStoreSave(Unit $unit, DateTime $start, DateTime $end, $event_type, $granularity, $event_state, $event_id, $remove = FALSE)`
  — writes the event into the state store and event store calendars (set `$remove = TRUE` to clear).

## EventManager service

`bat_event.util.event_manager` (`Drupal\bat_event\Util\EventManager`, ctor:
`logger.factory`, `entity_type.manager`, `database`, `renderer`). Builds/normalizes BAT events from
Form-API values (e.g. `getEventId()` from values). Also see `Util\EventMaintenance`.

## Views handlers & selection plugin

Field handlers `BatEventHandlerDurationField`, `BatEventHandlerValueField`,
`BatEventHandlerEventTypeField`; filter `BatEventHandlerBlockingFilter`. Entity-reference selection
`bat_event:state` (`StateSelection`) for state fields.

## Access

`bat_event_access($entity, $op, $account)` and `bat_event_type_access(...)` delegate to base
`bat_entity_access()`; `bat_event_query_bat_event_access_alter()` wires events into the access query
rewrite. See the base module's `agent/api/framework.md` for the model.
