<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Color Picker Field (color_picker_field) — agent index

Adds a **`color_picker` field type** whose widget is an HTML5 `<input type="color">`
picker and whose formatter renders the stored color as a colored text swatch. Intended
for choosing a text color to pair with a body/text field. Package `Other`. Core
`^10.3 || ^11`. License GPL-2.0-or-later. Installed **1.0.1** (version dir `1.0.x`).

## Dependencies

- Drupal module: **`field`** (core) — from `.info.yml`. Nothing else.
- No PHP-library requirements (`composer.json` requires only `drupal/core`).

## What it provides (from source)

- **Field type** `color_picker` — `Plugin/Field/FieldType/ColorPickerItem`.
  Single `value` column, `varchar` **length 7** (holds `#rrggbb`), nullable in schema;
  `value` property is a required string. `default_widget = color_picker_widget`,
  `default_formatter = color_picker_formatter`.
- **Widget** `color_picker_widget` — `Plugin/Field/FieldWidget/ColorPickerWidget`.
  Renders `#type => 'color'` (native color input) titled "Select Text color", default
  `#ffffff`, adds CSS class `color-picker-field`, and attaches the
  `color_picker_field/background_color` library. Overrides `extractFormValues()` with a
  custom multi-value extraction/sort; defines a `color_picker_format` default setting
  (value `#HEX`) that is not surfaced or consumed anywhere.
- **Formatter** `color_picker_formatter` — `Plugin/Field/FieldFormatter/ColorPickerFormatter`.
  For each item emits `#markup` of
  `<span style="color: {color};">{color}</span>`, where `{color}` is
  `Html::escape($item->value)` — the value is HTML-escaped before it is placed in the
  style attribute and the text.
- **Hook** `hook_page_attachments` — `Hook/ColorPickerFieldHooks` (OOP `#[Hook]`
  attribute, wired in `.services.yml` with `@current_route_match`). On the
  `entity.node.canonical` route it attaches the `background_color` library.
- **Library** `background_color` (`.libraries.yml`) → `js/background_color.js`,
  depends on `core/drupal` + `core/once`. The behavior runs on node pages (body has
  `path-node`, not an edit form): it binds `input` on `.color-picker-field` to write the
  chosen color to `localStorage['backgroundColor']` and set `.style.color` on every
  `.text-content` element, and on load re-applies the saved color to `.text-content`.
  (Named "background" but it sets text `color`.)

## Surface notes

- **No** routes, controllers, permissions, blocks, services beyond the hook class,
  config schema, config/install YAML, templates, `.install`/update hooks, or Drush
  commands. `.module` is an empty stub (just `declare(strict_types=1)`).
- Everything is wired through the standard Field UI (add a "Color Picker" field to a
  bundle); there is no dedicated settings page.

The surface is a single field type + widget + formatter + one JS behavior; no separate
solution docs are warranted. See [../usage.md](../usage.md) for the narrative overview.
