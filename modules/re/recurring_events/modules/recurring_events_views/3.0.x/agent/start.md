# Recurring Events Views — agent index

Swaps the default event series / instance / registration list builders for shipped, customizable
Views. No routes, services, permissions, or settings — pure Views config plus glue in
`recurring_events_views.module`. Depends on `views` + `recurring_events`. Enable and it just works.

- **Which Views ship and the series-vs-instance query/title glue** → [configure/views.md](configure/views.md)

Key facts:
- Views: `recurring_events_event_instances`, `recurring_events_event_series` (config/install);
  `recurring_events_registrations` (config/optional, needs `recurring_events_registration`).
- `hook_views_query_alter` filters the registrations View by `eventinstance_id` (instance
  registration) or `eventseries_id` (series registration).
- `hook_local_tasks_alter` re-points the registrations tabs to the View.
