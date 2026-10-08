<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CSS Size Field (css_size_field) — agent index

A **field type** that stores a CSS size — a `number` + a CSS length `unit` (e.g. `20px`, `1.5rem`,
`100%`). Package `Field`. **No dependencies** beyond Drupal core. Core requirement
`^10 || ^11 || ^12`. License GPL-2.0-or-later. Version 1.0.1. No routes, permissions, services,
hooks, Drush commands, or admin settings page.

- **The field type, widget, formatter, `css_size` form element, and units** →
  [fields/field-type.md](fields/field-type.md)

## What it actually provides

- **Field type** `css_size` — `src/Plugin/Field/FieldType/CssSizeItem.php` (`#[FieldType]`,
  `default_widget: css_size_default`, `default_formatter: css_size_default`). Two properties:
  `number` (`numeric(19,6)`) and `unit` (`varchar(255)`, default `''`).
- **Widget** `css_size_default` — `src/Plugin/Field/FieldWidget/CssSizeDefaultWidget.php`. Settings:
  `default_unit`, `available_units`. Renders the `css_size` element.
- **Formatter** `css_size_default` — `src/Plugin/Field/FieldFormatter/CssSizeDefaultFormatter.php`.
  Outputs `"{number}{unit}"` as `#markup`.
- **Form element** `css_size` — `src/Element/CssSize.php` (`#[FormElement('css_size')]`). A number
  input + unit `<select>`, usable in any form. Attaches library `css_size_field/widget`.
- **Value class** `SizeUnit` — `src/SizeUnit.php` (implements `UnitInterface`). Twelve unit
  constants; `getLabels()`, `getAllUnits()`, `assertExists()`.
- **Config schema** — `config/schema/css_size_field.schema.yml` (field value, widget settings,
  formatter settings). **Library** `css_size_field/widget` — one small CSS file. No `.install`,
  `.module`, `.services.yml`, `.routing.yml`, or `.permissions.yml`.

## Units (from `SizeUnit`)

`cm`, `mm`, `Q`, `in`, `pc`, `pt`, `px`, `em`, `rem`, `vw`, `vh`, `%`. All available by default;
the widget/element can restrict them.

## Mechanism (from source)

- `CssSizeItem::isEmpty()` is TRUE when `number` is NULL/`''` **or** `unit` is empty.
- `CssSizeItem::getConstraints()` adds a `ComplexData` → `Regex` constraint on `number`:
  `/^[+-]?((\d+(\.\d*)?)|(\.\d+))$/i` (signed integer or decimal). `unit` has no field constraint.
- `CssSize::processElement()` builds a `number` sub-element + a `unit` sub-element; when exactly one
  unit is available the `unit` becomes a `#type: value` and its label is shown as a `#field_suffix`
  on the number input. `#available_units` must be an array (throws `\InvalidArgumentException`
  otherwise), and a supplied `#default_value` must have `number` and `unit` keys.
- The default formatter concatenates the raw properties into `#markup` (core's admin XSS filter
  applies to `#markup` at render).

See [fields/field-type.md](fields/field-type.md) for install, widget settings, the config-schema
keys, and how to reuse the `css_size` element and `SizeUnit` in custom code.
