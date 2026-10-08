<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Activity entity

`src/Entity/Activity.php` — `@ContentEntityType id = "crm_core_activity"`, extends
`ContentEntityBase`, uses `EntityOwnerTrait`.

## Structure

- Base table `crm_core_activity` (no revision table). Keys: id `activity_id`, bundle `type`,
  owner `uid`, label `title`, uuid. `permission_granularity = "bundle"`,
  `bundle_entity_type = crm_core_activity_type`, `field_ui_base_route =
  entity.crm_core_activity_type.edit_form`.
- Links under `/crm-core/activity/...` (add-page, add-form, canonical, edit, delete).

## Base fields (`baseFieldDefinitions`)

- `type` — entity_reference to `crm_core_activity_type`, read-only.
- `title` — string, required, max 255 (the label).
- `created`, `changed`.
- `activity_participants` — **`dynamic_entity_reference`**, cardinality −1, required, restricted to
  `crm_core_individual` + `crm_core_organization`; view formatter `dynamic_entity_reference_label`
  (linked). This is what lets one activity reference several contacts of mixed types.
- `activity_date` — datetime, default `now`.
- `activity_notes` — text_long.

## Behaviour

- `label()` returns `$this->type->entity->getPlugin()->label($this)` — the label is computed by the
  bundle's activity-type plugin.
- `addParticipant(ContactInterface)`, `hasParticipant(ContactInterface)` helpers.
- List builder `ActivityListBuilder`; views data `ActivityViewsData`; view field plugin
  `Plugin/views/field/ActivityPreview`.

## Access — `ActivityAccessControlHandler`

`checkAccess()` allows (OR) on:

- **view**: `administer crm_core_activity entities`, `view any crm_core_activity entity`,
  `view any crm_core_activity entity of bundle {bundle}`.
- **update**: `administer …`, `edit any crm_core_activity entity`, `edit any … of bundle {bundle}`.
- **delete**: `administer …`, `delete any crm_core_activity entity`, `delete any … of bundle`.

`checkCreateAccess()` requires the bundle's activity **type to be enabled** (`status()`), AND one
of `administer …`, `create crm_core_activity entities`, `create … of bundle {bundle}`.

## Participant cleanup (`crm_core_activity.module`)

`hook_entity_predelete` for `crm_core_individual` / `crm_core_organization` calls
`crm_core_activity_pre_delete_checker()`, which queries activities referencing the deleted contact,
removes it from `activity_participants`, saves the survivor, and deletes any activity whose last
participant was removed (logged to the `crm_core_activity` channel).
