<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Color Element adds a color-picker field so editors can choose and store a color value on an entity.

---

Color Element provides a **color-picker field type** (`color_field`) for Drupal's Field
API. Once added to a content type or any fieldable entity, editors pick a color from a
palette of swatches instead of typing a value by hand, and the chosen color (a hex
string such as `#ff0000`) is stored on the entity. The palette of selectable colors is
defined per field on **Manage form display** as a comma-separated list of hex values;
the widget renders each as a clickable swatch and writes the picked value into the
field. On **Manage display**, the bundled **Color formatter** renders the stored color
as a small swatch — the value is HTML-escaped and placed into the swatch's inline
`background-color` style — and you can override the `color-element.html.twig` template in
your own theme to present it however you like. The module has no dependencies beyond
core, no settings page, and no permissions of its own; it simply stores a color.

---

- Add a color-picker field to a content type or other fieldable entity.
- Let editors pick a color from a defined palette of swatches rather than typing hex codes.
- Define the selectable palette per field as a comma-separated list of hex colors.
- Store a single hex color value (`#rrggbb`) on each entity.
- Render the stored color as a swatch via the built-in Color formatter.
- Override the `color-element.html.twig` template to customize how the color is displayed.
- Drive per-entity styling or theming accents from a content-editable color value.
- Use the color in a custom template or preprocess to style related markup.
- Reuse the same field on multiple bundles, each with its own palette.
- Ship a lightweight, dependency-free field type that builds only on core's Field API.
- Give a design/brand color a home on the entity that non-technical editors can manage.
- Present a consistent set of approved brand colors to editors through the swatch palette.
