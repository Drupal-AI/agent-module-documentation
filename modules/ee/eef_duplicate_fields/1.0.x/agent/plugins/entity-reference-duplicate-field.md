<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Reference Duplicate Field plugin

`src/Plugin/ExtraFieldType/EntityReferenceDuplicateFieldPlugin.php` —
`@ExtraFieldType(id = "entity_reference_duplicate_field", label = "Entity Reference Duplicate
Field")`, extends `DuplicateFieldPluginBase`, and additionally injects
`entity_type.manager` in `create()`. Renders a **field taken from a referenced entity** on the
parent entity's display, with optional one-level-deeper chaining.

## Configuration form (`buildConfigurationForm()`)

Progressive, AJAX-rebuilt selects under `field_type_config`:

1. `reference_field` — required, options from `getFieldOptions('entity_reference')` (only
   entity_reference fields on the host bundle). Warning markup if a saved value vanished.
2. `target_bundle` — bundle of the referenced entity. `getTargetBundles()` reads the field's
   `handler_settings[target_bundles]`; if empty it loads all bundles of the target type (or
   uses the type itself when it has no bundle entity type). Rendered as a select only when
   >1 bundle; otherwise a `#type => value` with the single bundle.
3. `target_field` — required, field from the referenced bundle
   (`getFieldOptionsForEntityType()`).
4. If the chosen `target_field` is itself an `entity_reference`
   (`isFieldEntityReference()`), a `drill_deeper` radios element appears:
   - `0` = *Render this field* → formatter is configured for `target_field` directly.
   - `1` = *Select field from referenced entity* → exposes `second_level_bundle`
     (`getTargetBundlesForEntityType()`) and `second_level_field`
     (`getFieldOptionsForEntityType()` on the second-level type), then configures the
     formatter for that second-level field.
5. `addFormatterConfiguration()` adds the required `formatter_type` select and the
   `formatter_settings` details subform via `buildFormatterSubformForEntityType()` (same core
   formatter `settingsForm()` + third-party-settings embedding as the base helper).

`submitConfigurationForm()` extracts + re-stores `third_party_settings` around the parent
submit, identically to the Duplicate Field plugin.

## Config keys

`reference_field`, `target_bundle`, `target_field`, `drill_deeper` (bool),
`second_level_bundle`, `second_level_field`, `formatter_type`, `formatter_settings`,
`third_party_settings`. No config schema ships with this module.

## Render (`build()`)

- Requires the host entity to be a `FieldableEntityInterface` with the `reference_field`;
  returns `[]` otherwise, or when `target_field`/`formatter_type` are unset.
- Checks **`$referenceItems->access('view')`** and non-empty before iterating. For each
  referenced item: gets `$item->entity`, skips it unless it **`->access('view')`**.
- Non-drill path: renders `target_field` on each referenced entity via
  `renderFieldWithFormatterForEntity()` (guards `hasField`, `$field->access('view')`, empty,
  then `$field->view([...])`). All accessible values are appended (`$build[$delta++]`).
- Drill path (`drill_deeper`): from each first-level entity it reads `target_field` (a
  reference), checks its `access('view')`, then renders `second_level_field` from the **first
  accessible** second-level entity only (`break` after one) with the same helper.

## Dependencies (`calculateDependencies()`)

Adds `field.field.*` and `field.storage.*` config deps for `reference_field`, for
`target_field` on the resolved target type/bundle, and (when drilling) for
`second_level_field` on the resolved second-level type/bundle.
