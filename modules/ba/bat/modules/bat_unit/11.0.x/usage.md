BAT Unit defines the "bookable thing" in the BAT framework: the `bat_unit` content entity (an individual bookable resource, e.g. a specific room) and the `bat_unit_type` content entity (a template/category of unit), each with configurable, fieldable bundles. It ships Views integration and bulk actions for managing units.

---

The module provides two fieldable content-entity types plus their config bundles: `bat_unit` (base table `unit`, bundle entity `bat_unit_bundle`) and `bat_unit_type` (base table `unit_type`, bundle entity `bat_type_bundle`). A Unit references its Unit Type via `unit_type_id`, has an owner (`uid`), a `name`, and a published `status`; both entity types are owner-aware and `permission_granularity = bundle`. Access is delegated to the base module's `bat_entity_access()` model, and the module adds `hook_query_*_access_alter` implementations plus condition-alter hooks so listings and Views respect per-bundle grants. It defines four actions — `unit_publish_action`, `unit_unpublish_action`, `unit_delete_action`, and `unit_set_state_action` (assign a fixed-state availability event to selected units) — exposed through a Views bulk form (`views.field.unit_bulk_form`) and two optional Views (`units`, `unit_management`). Admin pages live under `/admin/bat/unit` (units, unit types, and their bundles). It implements `hook_bat_event_target_entity_types()` to register `bat_unit` as an entity that BAT events can target, and exposes a large procedural API (`bat_unit_load`, `bat_unit_create`, `bat_unit_type_load`, `bat_unit_ids`, `bat_unit_state_options`, ...). Type-bundle config can carry `default_event_value_field_ids` used by the Event/Options submodules for pricing/valuation.

---

- Model each individual bookable resource (a specific hotel room, desk, bike, court) as a `bat_unit` entity.
- Model a category/template of resources (Double Room, Standard Desk) as a `bat_unit_type` entity.
- Create multiple unit bundles (e.g. `room`, `bed`) with their own Field UI fields.
- Attach arbitrary fields to units or unit types via the Field UI (base route on the bundle edit form).
- Link a unit to its unit type through the `unit_type_id` reference.
- Publish/unpublish units in bulk from a Views bulk operations form.
- Delete units in bulk with the `unit_delete_action` / multiple-delete confirm form.
- Bulk-assign a fixed availability state to units with the `unit_set_state_action`.
- List all units at `/admin/bat/unit/unit` and unit types at `/admin/bat/unit/unit_type`.
- Manage unit bundles and type bundles under `/admin/bat/unit/unit-bundles` and `/type-bundles`.
- Register `bat_unit` as a valid target entity type for BAT availability events.
- Configure per-type `default_event_value_field_ids` so events know which field holds a unit's value/price.
- Enforce per-bundle create/view/update/delete permissions through the BAT access model.
- Scope a user to only their own units with `view/update/delete own … of bundle` permissions.
- Load units programmatically by id or by conditions (`bat_unit_load`, `bat_unit_load_multiple`).
- Enumerate unit ids for a bundle or type-ids for a bundle (`bat_unit_ids`, `bat_unit_type_ids`).
- Build state option lists for a unit's event type with `bat_unit_state_options()`.
- Provide the `units` and `unit_management` Views as starting points for custom listings.
- Drive owner-scoped visibility of unit listings via the access query rewrite.
- Use unit entities as the availability subjects that `bat_event` writes calendar state against.
- Support multilingual units (entities declare a `langcode` key).
- Clean up related events automatically when a unit is deleted (`bat_unit_entity_delete`).
