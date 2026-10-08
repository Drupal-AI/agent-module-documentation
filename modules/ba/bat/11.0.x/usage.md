BAT (Booking and Availability Tools) is a generalized booking and availability-management framework for Drupal, built on the Roomify `roomify/bat` PHP library. The base `bat` module is the shared foundation: a custom per-bundle entity-access model, site-wide date-format settings, a `bat_type_group` grouping entity, and helper APIs that the functional submodules (Unit, Event, Booking, ...) build on.

---

BAT models "who/what can be booked" as **Units** and **Unit Types**, "when it is available/blocked/priced" as **Events** stored on fast per-event-type calendar tables, and "who reserved it" as **Bookings** — but almost none of that lives in the base `bat` module itself. The base module provides the cross-cutting scaffolding the rest of the suite reuses: `bat_entity_access()` (a bundle-granular access hook that grants `create/view/update/delete any|own <entity> of bundle <x>` and a restricted `bypass … entities access`), a matching query-alter that filters entity listings/Views by those grants, and `bat_entity_access_permissions()` which generates that whole permission set for any BAT content entity type. It also ships two locked `date_format` config entities (`bat` = `Y-m-d H:i`, `bat_daily` = `Y-m-d`) plus a `bat.settings` object, a `DateForm` at `/admin/bat/config/date` to edit them, and a `bat_date` param converter that turns URL date strings into `DateTime` objects. A `bat_type_group` content entity (with `bat_type_group_bundle` config bundles) lets sites group unit types. The module registers the `/admin/bat` admin section and a toolbar item, and exposes `hook_bat_entity_access()` so other modules can allow/deny non-view operations. Real functionality — units, events, bookings, calendars, pricing — comes from the ten submodules; install `bat` alone only to build on the framework.

---

- Provide the shared entity-access layer (`bat_entity_access`) for all BAT content entities (units, types, events, bookings, series).
- Generate a full bundle-granular permission set (`create/view/update/delete any|own … of bundle …`, plus `bypass … entities access`) for a BAT entity type via `bat_entity_access_permissions()`.
- Filter entity Views/listings by a user's BAT permissions using the `hook_query_alter` access rewrite (`bat_entity_access_query_alter`).
- Let other modules veto or grant non-view operations through `hook_bat_entity_access()`.
- Configure the site-wide BAT datetime format (`bat`, default `Y-m-d H:i`) at `/admin/bat/config/date`.
- Configure the site-wide BAT daily/date-only format (`bat_daily`, default `Y-m-d`).
- Set how many days ahead a new availability event may start (`bat_event_start_date`).
- Convert a date string in a route path into a `DateTime` object via the `bat_date` param converter.
- Build paired start/end date-range form fields with shared JS behaviour via `bat_date_range_fields()`.
- Group related unit types together using the `bat_type_group` entity and its bundles.
- Add/administer type-group bundles at `/admin/bat/group/group-types`.
- Provide the `/admin/bat` administration section and toolbar entry that the submodules hang their pages under.
- Programmatically load, create, save, and delete type groups (`bat_type_group_load`, `_create`, `_save`, `_delete`).
- Get or lazily create an entity view/form display with `bat_get_entity_display()`.
- Serve as the composer dependency that pulls in `roomify/bat` (the calendar/availability engine) and `rlanvin/php-rrule` (recurrence).
- Act as the base install target when building a custom booking product (hotel, rental, appointments) on the BAT stack.
- Reuse the framework's access model for custom booking-adjacent entity types rather than reimplementing per-bundle permissions.
- Restrict availability administration to trusted roles via the `bypass <entity> entities access` (restricted) permission.
- Delegate "view own vs view any" listing visibility to the built-in access query rewrite.
- Provide a consistent admin IA (`Bat` → Configuration / Group) for downstream booking modules.
