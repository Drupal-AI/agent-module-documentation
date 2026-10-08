<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Palette (palette) — agent index

**Reusable color palette for Color Field: a swatch widget + `palette_color` entities editors pick from.**

- **Version:** 1.0.x
- **Core:** ^10 || ^11 — requires `color_field`, `entity_browser`.
- **Entity:** `palette_color` (content entity, `src/Entity/PaletteColor.php`).
- **Widget:** `palette_color_widget` FieldWidget (for `color_field_type`); Entity Browser widget `palette_color_add`.
- **Routes:** `/admin/structure/palette-colors` collection + add/edit/delete — all require permission `administer palette`.
- **Permission declared:** `administer palette_color` (restricted).

**Security:** All palette management routes are permission-gated admin routes; no anonymous or mutating public endpoints. No security findings. See [configure/palette.md](configure/palette.md).
