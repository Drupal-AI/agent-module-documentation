<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Routes, tabs & helpers

The module adds routes and local tasks dynamically (per entity type) rather than in a static
`*.routing.yml`. Useful when linking to these pages or automating.

## Dynamic routes (`RouteSubscriber`, priority -101)

For every entity type with a `field_ui_base_route`, under its manage-fields `$path`:

| Route id | Path suffix | Purpose |
|---|---|---|
| `entity.base_field_override.<et>.base_field_override_ui_fields` | `/fields/base-field-override` | list base fields (the tab) |
| `entity.base_field_override.<et>_base_field_override_add_form` | `/fields/base-field-override/{base_field_name}/add` | add an override |
| `entity.base_field_override.<et>_base_field_override_edit_form` | `/fields/base-field-override/{base_field_override}` | edit an override |
| `entity.base_field_override.<et>_base_field_override_delete_form` | `/fields/base-field-override/{base_field_override}/delete` | delete an override |

`<et>` = entity type id. The list route requires permission `administer <et> fields`; add/edit/
delete use custom access / `base_field_override` entity access.

## Local tasks

`BaseFieldOverrideUiLocalTask` deriver adds, under `field_ui.fields:overview_<et>`:
- a **Fields** task, and
- a **Base fields Override** task (route above), plus an **Edit** task on the edit form.

## Helper URLs (`BaseFieldOverrideUI` extends `field_ui`'s `FieldUI`)

Static methods returning `\Drupal\Core\Url` for a given `BaseFieldOverride`:
`getOverviewRouteInfo($entity_type_id, $bundle)`, `getAddRouteInfo($config)`,
`getEditRouteInfo($config)`, `getDeleteRouteInfo($config)`, `getTranslateRouteInfo($config)`.

## Hooks it implements (`.module`)

`hook_entity_type_build` (sets the base_field_override edit/delete forms + list builder),
`hook_entity_type_alter` (config-translation list builder),
`hook_config_translation_info` (a `BaseFieldOverrideMapper` per entity type). No API for other
modules to implement — this is internal wiring.
