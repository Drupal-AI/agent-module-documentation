<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# BAT API (bat_api) — agent index

Exposes **BAT** (Booking & Availability Toolkit) unit and event/availability data over an **HTTP JSON
API**, shaped for a [FullCalendar](https://fullcalendar.io) front end (resources + events). Only
meaningful on a BAT site. Version **11.1.0-rc3**, core `^10.2 || ^11`.

Depends on `bat_event`, `bat_fullcalendar` (BAT stack) and `restui` (to configure the core REST
resources in the UI). No settings page (`configure` null). Defines **no permissions, no Drush, no
config schema, no plugin types** of its own — its endpoint access reuses core REST permissions and
`bat_event` permissions.

Two surfaces ship in this branch:
- **Core REST resources** (the current surface) — two `@RestResource` plugins, enabled/configured
  via the core `rest` module (see `config/install/rest.resource.bat_api_*.yml`).
- **Legacy `services`-module resources** — four `@ServiceDefinition` plugins kept for the old
  [Services](https://www.drupal.org/project/services) endpoint. `services` is **not** a dependency of
  this branch and no endpoint config ships, so these are inert unless you add Services yourself.

- **The two REST endpoints (calendar-events, calendar-units): paths, query params, JSON shape, how to
  enable and which permission gates each** → [api/rest-resources.md](api/rest-resources.md)
- **The legacy Services `@ServiceDefinition` resources (events / calendar-events / calendar-units /
  matching-units indexes)** → [api/legacy-services.md](api/legacy-services.md)
- **The alter hooks the module invokes + the non-blocking-event merge helper** →
  [api/alter-hooks.md](api/alter-hooks.md)

Key facts:
- REST resource `bat_api_events_resource` → `GET /bat_api/rest/calendar-events`
  (`Drupal\bat_api\Plugin\rest\resource\EventsRestResource`). Query params: `unit_types`,
  `event_types`, `unit_ids`, `background`, `path`, `start`, `end`. Returns a FullCalendar events array.
- REST resource `bat_api_units_resource` → `GET /bat_api/rest/calendar-units`
  (`UnitsRestResource`). Query params: `unit_type`, `unit_ids`. Returns `[{id, title}]` (FullCalendar
  resources).
- Both REST resources: `methods: [GET]`, `formats: [json]`, `authentication: [cookie]`,
  `granularity: resource` (config ids `bat_api_events_resource`, `bat_api_units_resource`). Enabling a
  resource makes core generate the permission `restful get <resource_id>`.
- Events endpoint additionally filters by the `bat_event` permissions
  `view calendar data for any {event_type} event` and `view past event information`.
- Legacy `@ServiceDefinition` ids + paths: `events_index`→`events`, `calendar_events_index`→
  `calendar-events`, `unit_index`→`calendar-units`, `matching_unit_index`→`calendar-matching-units`.
- Alter hooks invoked: `hook_bat_api_events_index_calendar_alter`,
  `hook_bat_api_units_index_calendar_alter`, `hook_bat_api_matching_units_calendar_alter`.
- `.module`: `bat_api_merge_non_blocking_events($events)`. `.install`: `hook_uninstall()` deletes
  the `services.service_endpoint.bat_api` config object.
- `BatApiMiddleware` (`src/StackMiddleware`) sets the request format from a `_format` query arg, but
  the module ships **no** `*.services.yml`, so it is not registered/active in this branch.
