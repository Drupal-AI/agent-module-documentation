<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Properties Field provides a "Properties" field type that stores an ordered list of typed key/value properties (specifications) on any fieldable entity.

---

Properties Field adds a single field type, `properties`, whose each item is a **machine name + human label + value type + value** quadruple, with unlimited cardinality so one field holds many rows. Editors fill a drag-orderable table widget (`properties_default`): they type a label (autocompleted from labels already used on that entity type/bundle), get an auto-generated machine name, pick a **value type**, then enter the value in a type-specific control. Value types are plugins (`@PropertiesValueType`) shipped for `string`, `Integer`, `decimal`, `size` (number + length unit) and `weight` (number + mass unit); each defines its own widget control, formatter settings and render logic. A `UniqueProperties` constraint rejects duplicate labels or machine names within one entity. Two formatters display the data: `properties_table` (label/value rows, optional striping — the default) and `properties_list` (a `<dl>` definition list). The value column is stored as a serialized blob, so a value can be a scalar or a small array (size/weight store `value` + `unit`). The module has no admin settings, permissions, services beyond the plugin manager, or Drush commands; you use it purely by adding the field to a bundle and configuring the widget/formatter. New in 1.2.x: Drupal 11 compatibility (the 1.x branch now targets `^9 || ^10 || ^11`; Drupal 8 support was dropped in 1.1.0). No field/widget/formatter API changes from 1.0.x.

---

- Store arbitrary product specifications (dimensions, weight, material) on a Commerce/product content type.
- Attach a flexible bag of key/value attributes to nodes without creating a field per attribute.
- Model technical spec sheets (CPU, RAM, resolution) as ordered typed rows.
- Add ad-hoc metadata to media or taxonomy terms.
- Capture recipe facts (servings, prep time, calories) with mixed value types.
- Let editors reorder properties by drag-and-drop to control display order.
- Provide typed numeric input (integer/decimal) with formatting separators on output.
- Record physical size values with a unit (cm, m, km, inch, feet, mile).
- Record weight values with a unit (grams, kilograms).
- Reuse property labels across entities via the label autocomplete.
- Enforce unique property labels/machine names per entity.
- Render properties as a striped table in a view mode.
- Render properties as a definition list (`<dl>`) instead of a table.
- Configure decimal/thousands separators for number-based value types on the formatter.
- Add a new custom value type (e.g. currency, boolean) by writing a `@PropertiesValueType` plugin.
- Expose per-entity key/value data to REST/JSON:API as structured field items.
- Store specification tables on event or venue entities.
- Build a lightweight EAV-style store for occasional attributes.
- Keep display separators and formatting consistent site-wide via formatter settings.
- Let content authors define both the property name and its typed value inline.
