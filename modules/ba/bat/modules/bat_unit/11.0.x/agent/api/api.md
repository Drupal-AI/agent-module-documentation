# BAT Unit — procedural API

All functions live in `bat_unit.module`. Use these instead of raw storage calls; they wrap the
entity classes `Drupal\bat_unit\Entity\Unit` and `UnitType`.

## Units (`bat_unit`)

- `bat_unit_load($unit_id, $reset = FALSE)` → `Unit|null`.
- `bat_unit_load_multiple(array $unit_type_ids, array $conditions, $reset = FALSE)` — load by
  conditions (e.g. `['unit_type_id' => $type_id]`).
- `bat_unit_create(array $values)`, `bat_unit_save(Unit $unit)`, `bat_unit_delete(Unit $unit)`,
  `bat_unit_delete_multiple(array $unit_ids)`.
- `bat_unit_ids($bundle = '')` — all unit ids (optionally by bundle).
- `bat_unit_uri(Unit $unit)`, `bat_unit_get_bundles($name, $reset)`, `bat_unit_bundle_load($bundle)`,
  `bat_unit_bundles_ids()`, `bat_unit_types_ids()`.
- `bat_unit_state_options($event_type)` — option list of states available for a unit's event type.
- Bundle CRUD: `bat_unit_bundle_create/save/delete`.

## Unit types (`bat_unit_type`)

- `bat_unit_type_load($type_id, $reset)`, `bat_unit_type_load_multiple($type_ids, $conditions, $reset)`.
- `bat_unit_type_create/save/delete`, `bat_unit_type_delete_multiple`.
- `bat_unit_type_ids($bundle = NULL)`, `bat_unit_type_uri($type)`, `bat_unit_get_types($bundle)`.
- Type-bundle helpers: `bat_type_bundle_load`, `bat_type_bundles_ids`, `bat_unit_type_bundle_load`,
  `bat_unit_type_bundle_create/save/delete`, `bat_unit_bat_type_bundle_new()`.

## Access helpers

- `bat_unit_access($entity, $op, $account)` / `bat_unit_type_access(...)` → delegate to base
  `bat_entity_access()`.
- `bat_unit_access_filter($op, $units, $account)` / `bat_unit_type_access_filter(...)` — filter a set
  of entities to those the account may act on.
- `bat_unit_query_bat_unit_access_alter()` / `_bat_unit_type_access_alter()` and the
  `bat_unit_bat_entity_access_view_condition_bat_unit_alter()` condition hook wire units into the
  base access query rewrite.

## Framework integration

- `bat_unit_bat_event_target_entity_types()` returns `['bat_unit']`, registering units as targets for
  BAT events (`bat_event` calls `hook_bat_event_target_entity_types`).
- `bat_unit_entity_delete()` removes related events when a unit is deleted.
- The `Unit` entity implements `getEventDefaultValue()` / `formatEventValue()` (required of any BAT
  event target entity) used by the availability calendar.
