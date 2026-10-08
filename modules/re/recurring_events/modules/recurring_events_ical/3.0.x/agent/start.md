# Recurring Events iCalendar — agent index

Adds `.ics` downloads for event series/instances and a token-based property mapping. Depends on
`recurring_events` + `token`. Configure route `entity.event_ical_mapping.collection`
(`/admin/structure/events/ical`, permission `administer eventinstance types`).

- **Download routes, the `event_ical` service, mapping entity, and the computed link field** →
  [configure/ical.md](configure/ical.md)

Key facts:
- Routes: `/events/series/{eventseries}/ical` (access `eventseries.view`) and
  `/events/{eventinstance}/ical` (access `eventinstance.view`); controller `EventExportController`.
- Service `recurring_events_ical.event_ical` = `EventICal` (`render(EventInterface): string`).
- Config entity `event_ical_mapping` maps iCal properties to token values.
- Computed base field `event_ical_link` added to `eventseries` + `eventinstance`; `ical` link template.
