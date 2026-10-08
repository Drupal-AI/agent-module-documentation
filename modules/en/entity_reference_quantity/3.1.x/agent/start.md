<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Reference Quantity — agent index

An entity-reference field type that stores an integer `quantity` per referenced entity, plus two widgets
and a label formatter. Extends core `EntityReferenceItem` (inherits target type/bundles/selection
handlers). No dependencies, no permissions, no config page — everything is per-field/per-display.

- **Field type, `quantity` column, field settings (`qty_label`/`qty_min`/`qty_max`), the two widgets,
  the label formatter and its Twig template** → [configure/field.md](configure/field.md)

Key facts:
- Field type `entity_reference_quantity` (`src/Plugin/Field/FieldType/EntityReferenceQuantity.php`):
  default widget `entity_reference_quantity_autocomplete`, default formatter
  `entity_reference_quantity_label`, `list_class` = core `EntityReferenceFieldItemList`.
- Adds property/column `quantity` (int) beside `target_id`; field settings add `qty_label`,
  `qty_min` (0), `qty_max` (999).
- Widgets: `entity_reference_quantity_autocomplete` (default), `entity_reference_quantity_select`
  (extends `OptionsWidgetBase`, inline select + number).
- Formatter `entity_reference_quantity_label` extends `EntityReferenceLabelFormatter`; settings
  `location` (pre-title/post-title/suffix/attribute) and `template` (Twig, default ` ({{ quantity }})`).
- Config schema keys extend `field.field_settings.entity_reference` /
  `field.formatter.settings.entity_reference_label`.
