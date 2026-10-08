<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# base_field_config plugin type

Content Entity Builder defines one plugin type for the base fields you can add to a custom entity type.

## Discovery
- Manager service: `plugin.manager.content_entity_builder.base_field_config` →
  `BaseFieldConfigManager` (extends `DefaultPluginManager`, subdir `Plugin/BaseFieldConfig`,
  interface `BaseFieldConfigInterface`).
- Plugin id declared via the PHP attribute `Attribute\BaseFieldConfig(id, label, description,
  field_type, deriver)` (legacy `Annotation\BaseFieldConfig` also supported).
- Alter hook: `hook_base_field_config_info_alter()`.
- Base classes: `BaseFieldConfigBase` (non-configurable) and `ConfigurableBaseFieldConfigBase`
  (adds `buildConfigurationForm`/`submitConfigurationForm` + a default-value form).

## Key interface methods
- `buildBaseFieldDefinition()` — returns a core `BaseFieldDefinition` used at runtime (label,
  description, default value, required, per-type settings, view/form display options).
- `exportCode($translatable, $revisionable)` — returns the PHP snippet that recreates this field in
  an **exported** module (see `export/export.md`).
- `getConfiguration()/setConfiguration()` — serialize to the `content_type` config `basefields`
  sequence (field_name, id, field_type, label, description, default_value, required, applied, index,
  weight, settings). Config settings schema: `content_entity_builder.base_field_config.*`.

## Shipped plugins (id → field_type)
- `string_base_field_config` → `string` (max_length setting)
- `string_long_base_field_config` → `string_long`
- `text_formatted_base_field_config` → `text_long` (formatted text, default format)
- `integer_base_field_config` → `integer`
- `decimal_base_field_config` → `decimal`
- `float_base_field_config` → `float`
- `boolean_base_field_config` → `boolean`
- `email_base_field_config` → `email`
- `telephone_base_field_config` → `telephone`
- `datetime_base_field_config` → `datetime`
- `timestamp_base_field_config` → `timestamp`
- `created_base_field_config` → `created`
- `changed_base_field_config` → `changed`
- `entity_reference_base_field_config` → `entity_reference`
- `list_string_base_field_config` → `list_string`
- `list_integer_base_field_config` → `list_integer`
- `list_float_base_field_config` → `list_float`
  (list plugins extend `ListItemBaseFieldConfigBase`; their Views integration is wired by
  `content_entity_builder_views_data_alter()` in `content_entity_builder.views.inc`, which sets a
  `list_base_field` filter — `Plugin/views/filter/ListBaseField`.)

A plugin may declare a `dependency` (module) in its definition; `ContentTypeEditForm::form()` hides
field types whose dependency module is not enabled.

## Adding a field type
Create a class in your module's `Plugin/BaseFieldConfig/`, add the `#[BaseFieldConfig(...)]` attribute,
extend `ConfigurableBaseFieldConfigBase`, and implement `buildBaseFieldDefinition()` (runtime) and
`exportCode()` (export). It then appears in the "Add base field" select on the entity-type edit form.
