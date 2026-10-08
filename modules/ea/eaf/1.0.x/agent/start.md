<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EAF - Entity Attributes Field (eaf) — agent index

A pluggable **field type** that stores non-content *attributes* (CSS classes, alignment/full-width
flags, spacing, etc.) about an entity, its fields, or its field items, as a single JSON string, and
exposes them to the theme layer via preprocess hooks. Package `Field types`. Core
`^10 || ^11 || ^12`. License GPL-2.0-or-later. Installed version **1.0.2** (dir `1.0.x`).
**No dependencies** beyond core, **no routes, no permissions, no Drush, no external libraries.**

## What it provides

- **Field type** `field_attributes_storage` (`AttributesStorageItem`) — one `value` text column holding
  a JSON blob; `default_widget: eaf_widget`, `default_formatter: string`, `cardinality: 1`,
  `list_class: EntityAttributesFieldItemList`.
- **Widget** `eaf_widget` (`AttributesFieldWidget`) — renders a collapsible form of the enabled
  attribute plugins and JSON-encodes their values on validate.
- **Two formatters** for `field_attributes_storage`: `field_attributes_raw_formatter`
  (`AttributesRawFormatter`, prints the JSON in a `<div>`) and `field_attributes_pretty_formatter`
  (`AttributesPrettyFormatter`, pretty-prints the JSON in a `<pre>`). Both are debug displays.
- **Plugin type `EntityAttribute`** (`Plugin/EntityAttribute`): PHP attribute
  `Drupal\eaf\Attribute\EntityAttribute` (+ legacy annotation), interface
  `EntityAttributePluginInterface`, base `EntityAttributePluginBase`, manager service
  `eaf.eaf_plugin_manager` (`EntityAttributePluginManager`). Ships two plugins: `entity_css_class`
  (`EntityCssClass`) and `full_width` (`FullWidth`).
- **Service** `eaf.field_attribute.service` (`FieldAttributeService`) — decides which sibling fields
  may carry attributes and injects field/field-item attribute widgets.
- **Hooks** (`Hook/EafHooks`, OOP `#[Hook]`): `field_widget_complete_form_alter`, `preprocess_field`,
  `preprocess_node`, `preprocess_paragraph`, `preprocess_form_element__new_storage_type`.
- **Config schema** `config/schema/eaf.schema.yml` (field-settings schema for the three plugin maps).
  No config/install; `configure` route is null.

## Solution docs

- **Field type, widget, formatters, storage & field settings** →
  [fields/field-type.md](fields/field-type.md)
- **The EntityAttribute plugin type, base class, manager, the two shipped plugins, writing your own** →
  [plugins/entity-attribute.md](plugins/entity-attribute.md)
- **How attributes reach the theme: FieldAttributeService, hooks, preprocess variables** →
  [api/service-and-hooks.md](api/service-and-hooks.md)

## Key facts

- Storage is one JSON string with three top-level sections (constants in `EntityAttributes`):
  `_entity_attributes`, `_field_attributes`, `_field_item_attributes`.
- Attribute availability is configured per field instance in three maps
  (`entity_attribute_plugins`, `field_attribute_plugins`, `field_item_attribute_plugins`).
- The module ships **no rendering template** — `preprocess_*` hooks only populate variables; the site
  theme is responsible for applying classes/flags to markup.
- `EntityCssClass` runs every class through `Html::cleanCssIdentifier()`; the raw/pretty formatters
  output through core's `html_tag` element (`Xss::filterAdmin()` on `#value`).
