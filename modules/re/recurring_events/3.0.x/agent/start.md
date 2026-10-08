# Recurring Events — agent index

Two entity types: `eventseries` (the recurrence rule) and `eventinstance` (each occurrence,
auto-generated from the series). `EventCreationService` calculates dates and creates/recreates
instances; per-instance fields inherit from the series via `field_inheritance`. Instance creation is
a pluggable `event_instance_creator`. Depends on `datetime_range`, `options`, `field_inheritance`.

- **Entity types, series/instance settings pages & config keys, excluded/included dates** →
  [configure/settings.md](configure/settings.md)
- **`EventCreationService` — calculate dates, create/clear instances, field inheritance** →
  [api/event-creation-service.md](api/event-creation-service.md)
- **The `event_instance_creator` plugin type & how to add one** →
  [plugins/event-instance-creator.md](plugins/event-instance-creator.md)
- **The many `hook_recurring_events_*` alter/lifecycle hooks** → [hooks/hooks.md](hooks/hooks.md)
- **Permissions** → [permissions/permissions.md](permissions/permissions.md)

Submodules (own docs):
- `recurring_events_ical` → [../../modules/recurring_events_ical/3.0.x/agent/start.md](../../modules/recurring_events_ical/3.0.x/agent/start.md)
- `recurring_events_registration` → [../../modules/recurring_events_registration/3.0.x/agent/start.md](../../modules/recurring_events_registration/3.0.x/agent/start.md)
- `recurring_events_views` → [../../modules/recurring_events_views/3.0.x/agent/start.md](../../modules/recurring_events_views/3.0.x/agent/start.md)

Key facts:
- Add a series at `/events/add/{eventseries_type}`; view at `/events/series/{eventseries}`; instances
  at `/events/{eventinstance}` (`recurring_events.routing.yml`).
- Default creator plugin: `recurring_events_eventinstance_recreator` (config key `creator_plugin`).
- Config: `recurring_events.eventseries.config`, `recurring_events.eventinstance.config`.
