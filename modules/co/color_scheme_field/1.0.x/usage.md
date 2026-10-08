<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Color Scheme Field provides a field type for storing a chosen color scheme.

---

Color Scheme Field adds one **field type** ("Color Scheme") whose value is the machine name of a
scheme picked from the list a **theme declares** in its `.info.yml` under a `color_scheme:` key.
The field stores only that identifier (a string, up to 255 chars) — the actual colors live in the
theme. A select **widget** offers the default theme's declared schemes; there is no formatter, so
the module does not output anything itself. Instead, on entity view it exposes the chosen scheme to
the render array as `#color_scheme_field`, and a theme (via preprocess/template) maps that to a CSS
class or scheme stylesheet. Works on Drupal 10 and 11; no dependencies, permissions, or routes.

Typical use: attach the field to a content type so editors can flag which of a few predefined,
on-brand palettes a piece of content should be shown with, then have the theme apply the palette.

---

- Provide a single "Color Scheme" field type storing a scheme machine name (`varchar(255)`).
- Constrain the choice to schemes the default theme declares (`color_scheme:` in `.info.yml`).
- Offer a select widget populated from those theme-declared options.
- Ship no formatter; surface the chosen scheme via `hook_entity_view` as `#color_scheme_field`.
- Let a theme read that value and apply the matching palette (theme owns output/escaping).
- Warn on the status report (`hook_requirements`) when the default theme declares no valid schemes.
