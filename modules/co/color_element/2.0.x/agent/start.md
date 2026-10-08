<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Color Element (color_element) — agent index

Defines a **color-picker field type** for fieldable entities. An editor picks from a
palette of admin-configured color swatches; the chosen value (a hex string like
`#ff0000`) is stored on the entity and rendered by default as a small colored swatch.
Package `Custom`. Core `^10 || ^11`. License GPL-2.0-or-later. Installed **2.0.1**
(version dir `2.0.x`). No composer dependencies; builds only on core's Field API.

## Dependencies

- Drupal modules: none beyond core (`field`, jQuery via `core/jquery`).
- PHP libraries: none (`composer.json` `require` is empty).

## What it provides (from source)

- **Field type** `color_field` — `Plugin/Field/FieldType/ColorField`. Single `value`
  property (`string`, required); DB column `value` is `varchar(7)`, nullable (fits
  `#rrggbb`). `isEmpty()` treats `NULL`/`''` as empty. `getConstraints()` adds nothing
  beyond the parent — there is no hex/format constraint; the `varchar(7)` column length
  is the only cap on the stored value. Default widget `color_widget`, default formatter
  `color_formatter`.
- **Field widget** `color_widget` — `Plugin/Field/FieldWidget/ColorWidget`. Setting
  `color_values` (textarea, default `#000000,#ffffff`) is a comma-separated palette. The
  real input is a plain `textfield` (`#size 7`) that JS hides; a `#suffix` renders one
  clickable `<div class="color-element-swatch" data-swatch-color="#…">` per palette
  entry. Attaches library `color_element/color_element_field`.
- **Field formatter** `color_formatter` — `Plugin/Field/FieldFormatter/ColorFormatter`.
  `viewElements()` renders `#theme => 'color_element'` with `#color =>
  Html::escape($item->value)` and attaches `color_element/color_formatter`.
  `settingsSummary()` is empty (no formatter settings).
- **Theme hook** `color_element` (`hook_theme` in `.module`) → template
  `templates/color-element.html.twig`:
  `<div class="color-element" style="background-color: {{ color }}"></div>`.
- **JS** `js/color_element_field.js` — `Drupal.behaviors.color_element` (jQuery + `once`).
  On swatch click: marks the swatch `.selected`, and sets the sibling text input's value
  to the swatch's `data-swatch-color`. Also hides the raw text input. Reads only the
  DOM `data-swatch-color` attribute — never `innerHTML`s a value.
- **Libraries** (`.libraries.yml`): `color_element_field` (field CSS + JS, dep
  `core/jquery`) and `color_formatter` (formatter CSS only).
- **Config schema** (`.schema.yml`): `field.widget.settings.color_widget_type` (keys
  `size`, `placeholder`). Note this schema key does not match the widget plugin id
  `color_widget`, so it is effectively unused by the shipped widget.
- **hook_help** for `help.page.color_element` (one "About" paragraph). No routing,
  services, permissions, install/update hooks, or config entities.

## How to use

Add a **Color selector** (`color_field`) field to a bundle via Field UI. On **Manage
form display**, set the widget's **Color values** (comma-separated hex list) to define
the selectable palette. On **Manage display**, the **Color formatter** renders the
stored value as a swatch; override `color-element.html.twig` in a theme for custom
output. There is no admin settings page and no configuration route (`configure: null`).

## Surface note

The whole module is the three field plugins above plus one template, one behavior, and
two CSS files. No subdocs are warranted — this index covers the full surface.
