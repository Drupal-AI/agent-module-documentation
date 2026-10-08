<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure an Entity Reference Quantity field

No admin page. Add a field of type **Entity reference w/quantity** (`entity_reference_quantity`) to a
bundle, then set the target type/bundles/selection handler exactly as a core entity-reference field
(these are inherited). Configure the quantity extras below on the field, form display and view display.

## Field type & storage

`EntityReferenceQuantity extends EntityReferenceItem`
(`src/Plugin/Field/FieldType/EntityReferenceQuantity.php`):
- `propertyDefinitions()` adds an integer `quantity` property; `schema()` adds a `quantity` int column
  next to core's `target_id`.
- `getPreconfiguredOptions()` returns `[]` (no per-entity-type preconfigured field options in the
  "Add field" list — you choose the target type afterwards).

## Field (instance) settings

`defaultFieldSettings()` adds, on top of core entity-reference settings:

| Setting | Default | Meaning |
|---|---|---|
| `qty_label` | `Quantity` | Label for the quantity input; also used as placeholder in multi-value instances. |
| `qty_min` | `0` | Minimum quantity (number input `#min` equivalent). |
| `qty_max` | `999` | Maximum quantity. |

Schema: `field.field_settings.entity_reference_quantity` (extends
`field.field_settings.entity_reference`, adds `qty_label`).

## Widgets (form display)

| Widget id | Class | Renders |
|---|---|---|
| `entity_reference_quantity_autocomplete` (default) | `EntityReferenceQuantityAutocomplete` | Entity autocomplete + a `number` input for quantity. |
| `entity_reference_quantity_select` | `EntityReferenceQuantitySelect` (extends `OptionsWidgetBase`) | Inline `select` of referenceable entities + a `number` input (default value 1). For multi-value fields `qty_label` becomes the number `#placeholder`; otherwise its `#title`. |

## Formatter (view display)

`entity_reference_quantity_label` (`EntityReferenceQuantityLabelFormatter` extends core
`EntityReferenceLabelFormatter`). Settings (schema
`field.formatter.settings.entity_reference_quantity_label`):

| Setting | Default | Meaning |
|---|---|---|
| `location` | `suffix` | Where the quantity goes: `pre-title`, `post-title`, `suffix`, or `attribute` (data attribute). |
| `template` | ` ({{ quantity }})` | A small Twig snippet rendered with the `quantity` variable. |

Plus inherited `link` (link label to the referenced entity). The `template` is a field-display admin
setting (requires the display-admin permission), rendered with the integer `quantity` — trusted admin
config, no untrusted input reaches it.
