<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EEF - Duplicate Fields (eef_duplicate_fields) — agent index

Add-on for **Entity Extra Field** (`entity_extra_field`) providing two `ExtraFieldType`
plugins that re-render an existing field, or a referenced entity's field, as a computed
extra field on an entity display. Package `Custom`. Core `^10 || ^11`. Requires
`drupal/entity_extra_field:^2.0`. License GPL-2.0-or-later. Version 1.0.0.

- **Duplicate Field plugin** (mirror a field on the same entity) →
  [plugins/duplicate-field.md](plugins/duplicate-field.md)
- **Entity Reference Duplicate Field plugin** (render a referenced entity's field, with
  optional one-level chaining) →
  [plugins/entity-reference-duplicate-field.md](plugins/entity-reference-duplicate-field.md)

## What it actually is

- Two plugins in `src/Plugin/ExtraFieldType/`, both extending the shared abstract
  `DuplicateFieldPluginBase` (which extends `entity_extra_field`'s `ExtraFieldTypePluginBase`
  and implements `ContainerFactoryPluginInterface`):
  - `DuplicateFieldPlugin` — `@ExtraFieldType(id = "duplicate_field", label = "Duplicate Field")`.
  - `EntityReferenceDuplicateFieldPlugin` — `@ExtraFieldType(id = "entity_reference_duplicate_field",
    label = "Entity Reference Duplicate Field")`.
- No routes, no `*.permissions.yml`, no `*.services.yml`, no `*.module`/`*.install`, no
  `config/` (no install config, no schema), no submodules, no libraries. Only the info.yml,
  composer.json, README.md, LICENSE.txt and the three PHP classes.
- Configured per entity view-display via Entity Extra Field's own "Add extra field" UI
  (Manage display). The extra-field config is stored by `entity_extra_field`, not by this
  module.

## Shared base (`DuplicateFieldPluginBase`)

- `create()` injects `entity_field.manager`, `plugin.manager.field.formatter`, `module_handler`.
- `defaultConfiguration()`: `field_name`, `formatter_type`, `formatter_settings`,
  `third_party_settings`.
- Helpers: `getFieldOptions($field_type?)`, `getFormatterOptions($field_name)`,
  `buildFormatterSubform()` (instantiates the core formatter and calls its `settingsForm()`),
  `getThirdPartySettingsForm()` (invokes `hook_field_formatter_third_party_settings_form`),
  `renderFieldWithFormatter()`, `extractThirdPartySettings()`.
- `renderFieldWithFormatter()` guards on `FieldableEntityInterface` + `hasField()`, checks
  `$field->access('view')`, skips empty fields, then returns `$field->view([...])` — rendering
  goes through core's field/formatter pipeline (no raw output).

See the per-plugin docs for the config forms, `build()` render logic, and
`calculateDependencies()`.
