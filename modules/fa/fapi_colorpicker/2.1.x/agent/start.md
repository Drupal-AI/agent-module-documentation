<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Colorpicker form element (fapi_colorpicker) — agent index

Registers a single Form API element type, **`colorpicker`**, for use in custom Drupal forms. Renders the
browser's native HTML5 `<input type="color">` swatch plus a companion hex text input, and normalises the
submitted value to a 7-char lowercase hex string (`#rrggbb`). Package `Form`. License GPL-2.0-or-later.
Version 2.1.0 (2.1.x). Core `^10.3 || ^11`. PHP `^8.1`.

## Dependencies

None beyond Drupal core. No contrib module dependencies; the JS library depends only on `core/drupal` and
`core/jquery`. (The old D7 `color_field` dependency was removed in 2.1.0.)

## What it provides (from source)

- **One Form API element**: `Drupal\fapi_colorpicker\Element\Colorpicker` (`@FormElement("colorpicker")`,
  extends `FormElementBase`, `src/Element/Colorpicker.php`) — `getInfo()`, `valueCallback()`,
  `preRenderColorpicker()`, `validateColorpicker()`, `normalizeHex()`. → [element/colorpicker.md](element/colorpicker.md)
- **One asset library**: `fapi_colorpicker/colorpicker` (`fapi_colorpicker.libraries.yml`) → `js/fapi_colorpicker.js`,
  deps `core/drupal`, `core/jquery`. Attached automatically by the element via `#attached`.
  → [element/colorpicker.md](element/colorpicker.md)

## What it does NOT provide

No routes, controllers, permissions, forms, services, entities, plugins beyond the element, config objects,
**config schema**, `config/install`, `.install`, hooks, or Drush. The `.module` file is a bare `@file` docblock
only. `configure` is null — there is nothing to configure; the element is used from code.

## Install / operate

1. `composer require drupal/fapi_colorpicker`
2. `drush en fapi_colorpicker -y`
3. In any form array: `$form['color'] = ['#type' => 'colorpicker', '#title' => $this->t('Colour'), '#default_value' => '#1a2b3c'];`
4. The submitted value arrives in form state as a normalised lowercase `#rrggbb` string.
