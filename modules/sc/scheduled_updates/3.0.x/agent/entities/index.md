<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entities

The module defines two entity types that work as a bundle pair.

## `scheduled_update_type` (config entity, the bundle)

`src/Entity/ScheduledUpdateType.php` — `@ConfigEntityType`, `bundle_of = "scheduled_update"`,
`config_prefix = scheduled_update_type`, `admin_permission = "administer scheduled update types"`.

Exported config keys (`config_export`): `id`, `label`, `uuid`, `update_entity_type`,
`update_types_supported`, `field_map`, `update_runner`, `default_values`. Schema in
`config/schema/scheduled_update_type.schema.yml` (marked `FullyValidatable`).

- **`update_entity_type`** — the single entity type this type updates (e.g. `node`, `user`,
  `taxonomy_term`).
- **`update_types_supported`** — array of `embedded` and/or `independent`.
- **`field_map`** — associative array: **source field on the `scheduled_update`** → **destination
  field on the target entity**. `transferFieldValues()` copies each mapped value at run time.
- **`update_runner`** — the runner plugin config (`id` + settings). Default `default_embedded`.
- **`default_values`** — `_no_form_display` (hide the mapped field on the update form) and an
  optional `field_map_default`.

Helpers: `isEmbeddedType()` / `isIndependentType()` (test membership in
`update_types_supported`), `getFieldMap()`, `getUpdateRunnerSettings()`. **`postDelete()`** deletes
the `FieldStorageConfig` for each source field in the map and purges field data — deleting a type
tears down its cloned fields.

## `scheduled_update` (content entity)

`src/Entity/ScheduledUpdate.php` — `@ContentEntityType`, `base_table = scheduled_update`,
`bundle = type`, `admin_permission = "administer scheduled updates"`,
`field_ui_base_route = entity.scheduled_update_type.edit_form` (so mapped fields are managed on the
type's Manage-fields tab). Access handler:
`ScheduledUpdateAccessControlHandler`. Forms: `ScheduledUpdateForm` (add/edit),
`ScheduledUpdateDeleteForm`.

Base fields (`baseFieldDefinitions`):

- **`update_timestamp`** (timestamp, required, translatable) — when the update should run. Also the
  entity **label** (`label()` formats it).
- **`status`** (list_integer) — `STATUS_UNRUN` (0/default), `STATUS_INQUEUE`, `STATUS_REQUEUED`,
  `STATUS_SUCCESSFUL`, `STATUS_UNSUCESSFUL`, `STATUS_INACTIVE`. Only Un-run and Re-queued are
  "ready" to run. `isArchived()` = Successful or Un-successful.
- **`entity_ids`** (entity_reference, unlimited cardinality, required) — the target entities. For
  **independent** types `bundleFieldDefinitions()` re-points this to the target entity type with an
  autocomplete widget (restricted to configured `bundles`); for **embedded** types it is hidden
  from the form/view (targets come from the reference field on the target entity instead).
- **`user_id`** (entity_reference → user) — creator; defaulted to the current user in
  `preCreate()`.
- `type`, `uuid`, `langcode`, `created`, `changed`.

`getUpdateEntityIds()` / `setUpdateEntityIds()` read/write `entity_ids` target ids.

## How a type gets its fields

When you add an update type against a target (or click **Add Update Field** on the target's Manage
Fields page, provided by `Plugin/Derivative/AddUpdateFieldLocalAction` and `FieldClonerForm`),
source fields are **cloned** from the target's field definitions onto the `scheduled_update`
bundle and recorded in `field_map`. Cloned field storages are cleaned up on type delete/uninstall.
