# BAT Event — agent index

The availability engine: `bat_event` entities record a unit's state/value over a date range, and the
module maintains fast per-event-type calendar tables (Roomify `roomify/bat` library) for querying
availability. Defines the `state` entity and `bat_event_type` bundles. Depends on `bat_unit` +
`datetime_range`. No `configure` route; pages under `/admin/bat/events`, settings at
`/admin/bat/config/bat_event`.

- **Entities, event types, granularity, states, the dynamic calendar tables, routes** →
  [configure/event-types.md](configure/event-types.md)
- **Availability API: matching units, calendars, states, constraints, event CRUD, EventManager** →
  [api/events.md](api/events.md)
- **Permissions** → [permissions/permissions.md](permissions/permissions.md)
- **Hooks: target entity types, constraints info, facets results alter** → [hooks/hooks.md](hooks/hooks.md)

Key facts:
- `bat_event`: base table `event`, bundle = `bat_event_type` (config). Fields: `unit_id` (→ target
  entity), `event_dates` (daterange), `event_state_reference` (→ `state`), plus type-defined value fields.
- `state`: content entity, base table `states` — the vocabulary of availability states.
- `bat_event_type` config: `event_granularity` (`bat_daily`/`bat_hourly`), `fixed_event_states`,
  `target_entity_type`, `default_event_value_field_ids`, `default_event_label_field_name`.
- Creating an event type creates two dynamic SQL tables (state store + event store); `Event::batStoreSave()`
  writes availability through the library `Calendar`/`DrupalDBStore`.
- `bat_event.util.event_manager` service (`EventManager`) builds events from form values.
