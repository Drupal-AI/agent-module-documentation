# Recurring Events Views — shipped Views & glue

No configuration is required — enabling the module installs the Views and swaps the listings.

## Shipped Views
- `views.view.recurring_events_event_instances` (config/install) — replaces the instance list builder.
- `views.view.recurring_events_event_series` (config/install) — replaces the series list builder.
- `views.view.recurring_events_registrations` (config/**optional**) — installed only when
  `recurring_events_registration` is enabled.

Admin displays ship with sensible defaults and exposed filters; front-end series listings show only
current/future events. Edit them like any View at *Structure → Views*.

## Glue (`recurring_events_views.module`)
- `hook_local_tasks_alter` — re-points `entity.registrant.instance_listing` (and removes the duplicate
  user registrations local task) to the registrations View when its route exists.
- `hook_views_query_alter` — for the `event_registrant_list` display of the `registrations` /
  `recurring_events_registrations` view: loads the current `eventinstance`, asks
  `RegistrationCreationService::getRegistrationType()`, then adds a WHERE condition on
  `registrant.eventinstance_id` (instance registration) or `registrant.eventseries_id` (series
  registration).
- `hook_views_pre_render` — sets the View title to "Registrations for %name on %date" (instance) or
  "Registrations for series: %name" (series), using `recurring_events.eventinstance.config` date format.
- `hook_help` — renders this submodule's README on its help page.
