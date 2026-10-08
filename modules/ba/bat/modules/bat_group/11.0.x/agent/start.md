# BAT Group — agent index

Skeleton submodule for future BAT unit-grouping. As of 11.0.x it only registers one service with
stub methods — no entities, routes, permissions, config, or UI. Depends on `bat_unit`.

No solution docs warranted (nothing to configure or call meaningfully yet).

Key facts:
- Service `bat_group.service` → `Drupal\bat_group\Service\Group` (ctor: `entity_type.manager`).
- Methods (all `@todo`, return empty defaults today):
  - `unitBelongs($unit_id, $group_id)` → `FALSE`.
  - `getUnits($group_id)` → `[]`.
  - `unitGroups($unit_id)`.
- `.module` is empty except a `@todo` to move group code out of the base `bat` module.
- For working grouping today, use the base module's `bat_type_group` entity instead
  (see `modules/ba/bat/11.0.x/agent/configure/settings.md`).
