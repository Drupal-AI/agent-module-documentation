# BAT Unit — agent index

Defines the bookable-resource entities of the BAT suite: `bat_unit` (an individual resource) and
`bat_unit_type` (a resource template), each fieldable with config bundles. Depends on `bat` + `views`.
No `configure` route; admin pages under `/admin/bat/unit`.

- **Entities, bundles, base fields, routes, Views, actions** → [configure/entities.md](configure/entities.md)
- **Procedural API: load/create/save units & types, id enumerators, state options** → [api/api.md](api/api.md)
- **Permissions (BAT per-bundle scheme + bundle admin perms)** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- `bat_unit`: base table `unit`, bundle entity `bat_unit_bundle`, keys id/uuid/uid/type, fields
  `unit_type_id` (→ `bat_unit_type`), `name`, `status`.
- `bat_unit_type`: base table `unit_type`, bundle entity `bat_type_bundle` (bundle config carries
  `default_event_value_field_ids`).
- Access via base `bat_entity_access()`; `permission_granularity = bundle`.
- Actions: `unit_publish_action`, `unit_unpublish_action`, `unit_delete_action`, `unit_set_state_action`.
- Registers `bat_unit` as a BAT event target entity (`hook_bat_event_target_entity_types`).
