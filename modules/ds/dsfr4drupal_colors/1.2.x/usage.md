<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds a field type, box/text widgets, a render element and four formatters that let editors store and display colors from the official DSFR (French State Design System) palette.

---

DSFR for Drupal - Colors provides the `dsfr4drupal_color_field_type` field type plus a color-box widget (`dsfr4drupal_color_field_widget_box`), a `dsfr4drupal_color_box` render element, and four field formatters (text, swatch, CSS declaration, and a base class). Values are stored as DSFR CSS variable names (e.g. `blue-france-main-525`) rather than hex codes, so they track light and dark mode automatically. The available palette is parsed at runtime from the installed DSFR library CSS (`libraries/dsfr/dist/core/core.css` and `scheme/scheme.css`) by `ColorsHelper`, cached, and periodically written to `public://dsfr4drupal-colors.css` by `hook_cron`. Per-field settings let you restrict selectable colors and enable a JS contrast-ratio check. An admin collection page (`/admin/config/user-interface/dsfr4drupal-colors`) previews every palette color, and a settings form chooses the light/dark form palette. It depends only on core `field`; `color_field` is an optional integration for one contrast-ratio option, and `token` (if present) enables tokens in the CSS formatter.

---

- Add a DSFR palette color field to a content type, taxonomy, or any fieldable entity.
- Let editors pick colors from a visual box widget instead of typing hex codes.
- Restrict a field instance to a subset of DSFR colors (allowed colors) so editors stay on-brand.
- Group selectable colors into DSFR families (primary, neutral, system, illustrative).
- Store color values as DSFR variable names that adapt to light and dark themes.
- Display a color as plain text (the variable name) with the "Color as text" formatter.
- Render a color swatch (circle, square, parallelogram, or triangle) at a configurable size.
- Inject an inline CSS declaration (e.g. `background-color` on a selector) from a stored color via the "Color CSS declaration" formatter.
- Use advanced CSS mode to build an arbitrary CSS statement around the color value.
- Use tokens (with the token module) to compose the CSS statement dynamically.
- Enable a live contrast-ratio validation in the widget against a fixed hex code.
- Validate contrast against a named DSFR color variable.
- Validate contrast against another DSFR color field on the same entity.
- Validate contrast against a `color_field` (Color Field module) field.
- Preview every color in the current DSFR library, in both light and dark modes, on the admin collection page.
- Switch the widget's form palette between light and dark on the settings form.
- Automatically pick up new colors after upgrading the DSFR library, with no manual re-import (cron regenerates the CSS file).
- Enable a search input in the box widget to filter a large palette.
- Choose small/medium/large color squares in the box widget.
- Expose stored colors as tokens (`color`, `color_variable_name`, `color_variable_css`) for other modules.
- Export color field values with the single_content_sync module.
- Provide a reusable `dsfr4drupal_color_box` render element for custom forms.
- Build DSFR-compliant French government sites that constrain color choices to the official palette.
