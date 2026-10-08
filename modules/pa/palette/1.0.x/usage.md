<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Palette adds a reusable color palette on top of the Color Field module: administrators define `palette_color` entities and editors pick from them with a swatch widget instead of retyping hex values.

---


A `palette_color` content entity stores each managed color (label + value + owner). The `PaletteColorWidget` field widget (for `color_field_type`) renders the palette as selectable swatches with an AJAX-refreshed wrapper, and an Entity Browser widget (`palette_color_add`) lets editors add a new palette color inline. Palette colors are managed at `/admin/structure/palette-colors` (add/edit/delete), gated by the `administer palette` permission. This keeps brand colors consistent and avoids ad-hoc hex entry.

Setup: enable Color Field + Entity Browser + Palette, create palette colors, then set a color_field's widget to the Palette widget on the form display.
---
- Define a reusable set of brand colors.
- Let editors pick colors from swatches instead of hex codes.
- Manage palette colors at `/admin/structure/palette-colors`.
- Add a new palette color.
- Edit an existing palette color's label or value.
- Delete a palette color.
- Assign the Palette widget to a color_field on a form display.
- Add a palette color inline via Entity Browser.
- Keep color usage consistent across content.
- Restrict palette management with `administer palette`.
- Reuse the same palette across multiple fields/bundles.
- Refresh the widget selection via AJAX.
- Own palette colors per user (entity owner).
- List all palette colors in the admin collection.
- Standardize colors for theming components.
- Reduce invalid or off-brand color entries.
- Seed default palette colors via config.
