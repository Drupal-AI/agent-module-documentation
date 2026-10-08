<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `field_attributes_storage` field type, widget & formatters

## Install & enable

```bash
composer require drupal/eaf
drush en eaf -y
```

Depends only on Drupal core (`^10 || ^11 || ^12`). No sub-modules, no permissions, no Drush commands,
no external libraries.

## Field type — `AttributesStorageItem`

`src/Plugin/Field/FieldType/AttributesStorageItem.php`, id `field_attributes_storage`, label
*"Entity attributes field"*, category `general`.

- **Storage schema** (`schema()`): a single column `value`, `type: text`, `size: normal`, nullable.
- **Property** (`propertyDefinitions()`): `value` (string), labelled "Attributes settings".
- Attributes: `default_widget: "eaf_widget"`, `default_formatter: "string"` (core string formatter),
  `cardinality: 1`, `list_class: EntityAttributesFieldItemList`.
- **Serialization**: `setValue()` keeps only `['value' => <string>]`. `getValue()` `json_decode`s the
  stored string into an array (`$decoded['value']` = decoded array). So the stored DB value is a JSON
  string; the runtime value is a nested array.
- **Section accessors** (`getAttributeValue()` / `setAttributeValue()` and the typed wrappers
  `get/setEntityAttributeValue`, `get/setFieldAttributeValue`, `get/setFieldItemAttributeValue`) read
  and write the three top-level sections named by `Drupal\eaf\EntityAttributes` constants:
  `_entity_attributes`, `_field_attributes`, `_field_item_attributes`. An unknown type falls back to
  `_entity_attributes`.
- `isEmpty()` returns TRUE only when the `value` property is `NULL`.
- `generateSampleValue()` stores a JSON-encoded random word (for `drush …:generate` / tests).

The field item list (`EntityAttributesFieldItemList`) adds convenience getters/setters
(`getEntityAttributeValue`, `getFieldAttributeValue`, `getFieldItemAttributeValue`,
`setFieldAttributeValue`, plus `get/setSettingValue`) and always JSON-encodes on write
(`toEncodedValue()` → `['value' => json_encode($value)]`). It fetches the plugin manager via
`\Drupal::service('eaf.eaf_plugin_manager')` in its constructor (service-locator, not DI).

## Field settings (per instance)

`defaultFieldSettings()` defines three empty maps; `fieldSettingsForm()` builds their UI, and
`fieldSettingsToConfigData()` casts every leaf to bool before save:

| Setting | Shape | Meaning |
|---|---|---|
| `entity_attribute_plugins` | `{plugin_id: bool}` | Which attribute plugins apply to the **entity** as a whole. |
| `field_attribute_plugins` | `{field_name: {plugin_id: bool}}` | Attributes offered for **another whole field** on the bundle. |
| `field_item_attribute_plugins` | `{field_name: {plugin_id: bool}}` | Attributes offered **per item** of another field. |

The form lists every available `EntityAttribute` plugin as checkboxes. The "for fields" / "for field
items" fieldsets appear only for **sibling fields that `FieldAttributeService::isAllowed()` accepts**
(field types `string`, `string_long`, `entity_reference`, `entity_reference_revisions`, `link`, not
read-only, not in the forbidden-name list — see api/service-and-hooks.md).

### Config schema

`config/schema/eaf.schema.yml` defines `field.field_settings.field_attributes_storage` with the three
sequences above (`orderby: key`, leaves are `bool`). It also declares `eaf.settings` (a stub
`config_object` with a single `example` string — no settings form ships to write it),
`field.storage_settings.field_attributes_storage` (stub `foo`), and `field.value.…` default-value
mapping. There is **no `config/install`** and **no `configure` route**.

## Widget — `AttributesFieldWidget` (`eaf_widget`)

`src/Plugin/Field/FieldWidget/AttributesFieldWidget.php`, `multiple_values: FALSE`.

- `formElement()` reads the instance's `entity_attribute_plugins` setting and, for each enabled
  plugin, calls `$plugin->prepareFormElement($options, $value)` with the current stored value; the
  enabled elements are wrapped in a closed `details` element titled *"@label (content)"* and the
  `eaf/eaf.attribute-widget` library is attached.
- `validate()` (an `#element_validate` callback) rebuilds the full value: it iterates all plugin
  widgets and calls `$plugin->setValue($submitted, …)` for the entity section, then collects
  per-field (`_field_attributes`, delta key `add_more`) and per-field-item (`_field_item_attributes`)
  values, and finally `json_encode`s the whole `{_entity_attributes, _field_item_attributes,
  _field_attributes}` structure with `$form_state->setValueForElement()`. So the widget is the single
  place editor input is normalized before storage — each plugin's `setValue()` decides how its own
  value is sanitized (e.g. `EntityCssClass` cleans CSS identifiers).

## Formatters (debug displays)

Both target `field_attributes_storage` and iterate items, emitting a core `html_tag` render element
(so `#value` is passed through `Xss::filterAdmin()` by `HtmlTag::preRenderHtmlTag`):

- **`field_attributes_raw_formatter`** (`AttributesRawFormatter`) — `<div>` with `#value => $item->value`
  (the raw stored JSON string).
- **`field_attributes_pretty_formatter`** (`AttributesPrettyFormatter`) — `<pre>` with
  `#value => json_encode(json_decode((string) $item->value), JSON_PRETTY_PRINT)`.

Neither has settings. They are for inspecting the stored JSON; real display of the attributes on
entity markup is done by the theme using the preprocess variables (see api/service-and-hooks.md). The
field type's default formatter is core `string`.

## Enable on a field (UI)

1. *Structure → (entity type) → Manage fields → Add field* → **Entity attributes field**.
2. On the field settings form, tick the attribute plugins to allow for the entity, and (if sibling
   fields qualify) for those fields / field items.
3. On *Manage form display* the `eaf_widget` widget is selected by default.
4. On *Manage display* leave it as `string`/hidden (attributes are usually applied by the theme), or
   pick a raw/pretty formatter to debug.
