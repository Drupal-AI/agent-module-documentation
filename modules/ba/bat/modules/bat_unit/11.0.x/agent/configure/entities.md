# BAT Unit — entities, bundles, routes, actions

## Entity types

| Entity | Type | Base table | Bundle entity | Owner | Notes |
|---|---|---|---|---|---|
| `bat_unit` | content | `unit` | `bat_unit_bundle` (config) | `uid` | An individual bookable resource. |
| `bat_unit_type` | content | `unit_type` | `bat_type_bundle` (config) | `uid` | A resource template/category. |

Both: `permission_granularity = bundle`, `admin_permission = "administer <unit|unit_type> entity"`,
access handler in `bat_unit`, EntityChanged + EntityOwner traits. `preCreate` sets `uid` to the
current user.

### `bat_unit` base fields

`id`, `uuid`, `uid` (→ user), `unit_type_id` (entity_reference → `bat_unit_type`), `name` (string),
`created`, `changed`, `type` (bundle → `bat_unit_bundle`), `status` (boolean, published).

### Config bundles

- `bat_unit_bundle` (schema `bat_unit.unit_bundle.*`): `name`, `type`.
- `bat_type_bundle` (schema `bat_unit.type_bundle.*`): `name`, `type`, and
  `default_event_value_field_ids` (sequence) — which fields hold a type's event value/price;
  read by `bat_event`/`bat_options`.

Add fields via Field UI on the bundle edit form (`field_ui_base_route =
entity.bat_unit_bundle.edit_form` / `entity.bat_type_bundle.edit_form`). Namespace custom fields.

## Routes (all under `/admin/bat/unit`, `_admin_route`)

- Units: collection `/unit/unit` (`view any bat_unit entity`), add `/unit/unit/add[/{unit_bundle}]`
  (custom `_unit_add_access`), canonical/edit/delete `/unit/unit/{bat_unit}[/edit|/delete]`
  (`_entity_access`).
- Unit types: collection `/unit/unit_type` (`view any bat_unit_type entity`), add
  `/unit/unit_type/add[/{type_bundle}]` (`_unit_type_add_access`), edit/delete (`_entity_access`).
- Unit bundles: `/unit/unit-bundles[...]` and type bundles `/unit/type-bundles[...]`
  (`administer bat_unit_bundle entities` / `administer bat_type_bundle entities`).
- Bulk ops: `/unit/units/delete` and `/unit/units/set-state` — both require the **restricted**
  `bypass bat_unit entities access`.
- `/unit/types/type/{bat_unit_type}/units` and `/units/add` route to `UnitController::listUnits` /
  `addUnits`, which are currently **empty no-op stubs** (`_access: TRUE`, return nothing).

Access-check services: `access_check.bat_unit.add` (`_unit_add_access`) and
`access_check.bat_unit_type.add` (`_unit_type_add_access`) allow the add page if the account may
create the bundle.

## Actions & Views

Four `@Action` plugins ship as `system.action.*` config in `config/install`:

| Action id | Label | Effect |
|---|---|---|
| `unit_publish_action` | Publish selected unit | set `status = 1` |
| `unit_unpublish_action` | Unpublish selected unit | set `status = 0` |
| `unit_delete_action` | Delete unit | delete via multiple-delete confirm |
| `unit_set_state_action` | Assign fixed-state event to units | write a fixed availability state for selected units (`UnitSetStateAction` form) |

Exposed through the `views.field.unit_bulk_form` bulk-form handler. Two optional Views ship in
`config/optional`: `units` and `unit_management`. Views field/filter plugins:
`BatUnitHandlerUnitBundleField`, `BatTypeHandlerTypeCalendarsField`, `BatUnitHandlerTypeIdFilter`,
`UnitBulkForm`.

## Create a unit with Drush

```bash
ddev drush php:eval '$u = \Drupal::entityTypeManager()->getStorage("bat_unit")->create(["type" => "room", "name" => "Room 101", "unit_type_id" => 1]); $u->save();'
```
