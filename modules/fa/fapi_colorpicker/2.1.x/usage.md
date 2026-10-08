<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Provides a reusable `colorpicker` Form API element for custom Drupal forms, backed by the browser's native HTML5 color input with a companion hex text field.

---

Colorpicker form element (`fapi_colorpicker`, package Form) is a developer building block that registers a single Form API element type, `colorpicker`, implemented as the `FormElementBase` plugin `Drupal\fapi_colorpicker\Element\Colorpicker`. A developer places `'#type' => 'colorpicker'` in any form array and the module renders a native `<input type="color">` swatch plus an adjacent hex text input (`.fapi-colorpicker-hex`), attaches its JavaScript library, and validates/normalises the submitted value to a seven-character lowercase hex string including the leading `#` (e.g. `#1a2b3c`); malformed input falls back to `#000000`. The element supports the usual core properties (`#default_value`, `#title`, `#required`, `#description`, AJAX via `processAjaxForm`). The module has no admin UI, routes, permissions, services, entities, config objects or config schema — it works only through Drupal core's Form API, and the submitted colour value is consumed downstream by whatever form declares the element.

---

- Add a colour field to a custom config form with `'#type' => 'colorpicker'`.
- Let editors pick a brand or accent colour for a theme settings form.
- Collect a per-entity colour value on a custom entity form.
- Prefill a saved colour by setting `#default_value` to a stored hex string.
- Make a colour selection mandatory with `#required => TRUE`.
- Offer both a native OS colour swatch and a typed hex entry (`.fapi-colorpicker-hex`) for the same value.
- Build a palette editor from several `colorpicker` elements in one form.
- Store a normalised, lowercase `#rrggbb` value regardless of how the editor typed it.
- Fall back safely to `#000000` when a user enters an invalid colour.
- Validate colour input server-side against a six-digit hex pattern without writing custom validation.
- Use the element inside a block configuration form for a colourable block.
- Add a colour option to a Layout Builder component or section settings form.
- Provide a colour control in a Views exposed or settings form.
- Collect a background/foreground colour pair for a custom formatter's settings.
- Use the element inside multistep or AJAX-driven forms (it registers `processAjaxForm`).
- Standardise colour input across many custom modules with one shared element type.
- Replace ad-hoc `<input type="color">` markup with a validated, themed Form API element.
- Attach the colour picker JS/CSS automatically whenever the element renders, via `#attached`.
- Capture a colour token for design-system or CSS-variable generation from site config.
- Let module developers expose colour choices without depending on a third-party JS colour library.
- Provide an accessible hex text alternative (with `aria-label`) alongside the native swatch.
- Reuse the element in webform or contact-form extensions that build render arrays in code.
