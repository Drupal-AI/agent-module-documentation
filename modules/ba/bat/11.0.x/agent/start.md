# BAT (base framework) — agent index

`bat` is the foundation of the Booking and Availability Tools suite. It is a framework layer:
custom entity-access model, site-wide date settings, a `bat_type_group` grouping entity, and
helper APIs. Real features live in the submodules. Depends on the `roomify/bat` +
`rlanvin/php-rrule` composer libraries. `configure` route is null (settings live under `/admin/bat/config`).

- **Access model & helper APIs** — `bat_entity_access()`, the query-alter listing filter,
  `bat_entity_access_permissions()`, `bat_date` param converter, `bat_date_range_fields()`,
  type-group load/save helpers, `bat_get_entity_display()` → [api/framework.md](api/framework.md)
- **Settings & config entities** — `bat`/`bat_daily` date formats, `bat.settings`, the `DateForm`,
  the `bat_type_group` entity + bundles → [configure/settings.md](configure/settings.md)
- **Permissions** — what the base module defines and the generated per-entity scheme
  → [permissions/permissions.md](permissions/permissions.md)
- **Hook** — `hook_bat_entity_access()` for allow/deny of non-view ops → [hooks/hooks.md](hooks/hooks.md)

Submodules (own docs under `../modules/<name>/11.0.x/`):
- `bat_unit` — Unit & Unit Type entities → [../../modules/bat_unit/11.0.x/agent/start.md](../../modules/bat_unit/11.0.x/agent/start.md)
- `bat_event` — Events, States, calendar storage engine → [../../modules/bat_event/11.0.x/agent/start.md](../../modules/bat_event/11.0.x/agent/start.md)
- `bat_event_series` — recurring events (rrule) → [../../modules/bat_event_series/11.0.x/agent/start.md](../../modules/bat_event_series/11.0.x/agent/start.md)
- `bat_booking` — Booking entity → [../../modules/bat_booking/11.0.x/agent/start.md](../../modules/bat_booking/11.0.x/agent/start.md)
- `bat_fullcalendar` — FullCalendar rendering/management API → [../../modules/bat_fullcalendar/11.0.x/agent/start.md](../../modules/bat_fullcalendar/11.0.x/agent/start.md)
- `bat_calendar_reference` — reference + display availability on any entity → [../../modules/bat_calendar_reference/11.0.x/agent/start.md](../../modules/bat_calendar_reference/11.0.x/agent/start.md)
- `bat_options` — Commerce pricing options field → [../../modules/bat_options/11.0.x/agent/start.md](../../modules/bat_options/11.0.x/agent/start.md)
- `bat_facets` — availability-aware Search API facet → [../../modules/bat_facets/11.0.x/agent/start.md](../../modules/bat_facets/11.0.x/agent/start.md)
- `bat_event_ui` — calendar admin UI → [../../modules/bat_event_ui/11.0.x/agent/start.md](../../modules/bat_event_ui/11.0.x/agent/start.md)
- `bat_group` — group service (skeleton) → [../../modules/bat_group/11.0.x/agent/start.md](../../modules/bat_group/11.0.x/agent/start.md)

Key facts:
- Entities the access model covers: `bat_type_group`, `bat_unit`, `bat_unit_type`, `bat_event`,
  `bat_event_series`, `bat_booking`.
- Admin IA: `/admin/bat` (menu block), `/admin/bat/config` (Configuration), `/admin/bat/group` (Group).
- Config schema: `bat.settings`, `bat.date_format.bat`, `bat.date_format.bat_daily`, `bat.type_group_bundle.*`.
