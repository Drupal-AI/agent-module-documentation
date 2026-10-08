Curated Colors gives editors a visual swatch picker backed by named, exportable color palettes and a `curated_color` field that stores a stable color key rather than a raw color value.

---

Curated Colors is a field-types module for Drupal 10.3+/11/12 with no runtime dependencies. Palettes are `curated_color_palette` config entities managed at `/admin/config/content/curated-colors`; each palette holds an ordered list of colors (machine `key`, `label`, optional `hex`, optional custom CSS `style`, `enabled` flag, and optional `groups`) plus an ordered list of group names. The `curated_color` field type stores one color key chosen from a palette and exposes computed `hex`, `style`, `label` and `css` properties resolved against the palette at render time. A `curated_color_picker` widget replaces the plain `<select>` with a swatch popover (degrading to the select without JS); the same picker is exposed as a standalone Form API element (`#type` `curated_color_picker`) for use on any form. Two formatters ship: `curated_color_swatch` (a colored chip plus label) and `curated_color_value` (raw key/label/hex/CSS as plain text). A palette resolver service fires a `PaletteColorsEvent` so other modules can add, remove or modify colors at runtime. With Drupal Canvas installed, any SDC string prop carrying an `x-curated-color-palette` vendor key gets the swatch picker in the component editor. Because content stores the key (`brand-blue`), the intended pattern keeps real color values in CSS, so re-theming is a stylesheet edit, not a content migration.

---

- Give editors a fixed, on-brand set of named colors to choose from instead of a free-form hex input.
- Define reusable color palettes as exportable config entities committed to git and deployed with `drush cim`.
- Add a `curated_color` field to nodes, taxonomy terms, media, users, paragraphs or any fieldable entity.
- Restrict a specific field's picker to a subset of a palette by allowing only certain groups.
- Organize a large palette into named groups (Primary, Secondary, Gradients) shown as labeled sections in the picker.
- Store a stable color key (`brand-blue`) in content and keep the actual hex/gradient values in your theme's CSS.
- Apply the chosen color as a BEM CSS-modifier class (`card--brand-blue`) so re-branding is a stylesheet change.
- Output an inline `background:` declaration for email templates, SVG fills or dynamic styles via the computed `css` property.
- Render a swatch chip with an optional label on entity displays with the `curated_color_swatch` formatter.
- Emit the raw key, label, hex or custom CSS string with the `curated_color_value` formatter for tokens, exports or debugging.
- Read resolved color data (`hex`, `label`, `style`, `css`) directly in Twig via the field item's computed properties.
- Support gradients and other multi-stop values a single hex can't represent using each color's custom CSS field.
- Retire a color from the picker without breaking existing content by toggling its Enabled switch off.
- Reorder colors and groups by dragging cards/rows in the palette editor to control picker order.
- Preview a palette live in the editor as you type hex or custom CSS, with no save required.
- Add the swatch picker to a custom settings or config form as a Form API element, independent of the field system.
- Override the picker's UI strings (Select, Clear, open, no-selection) per instance via the element's `#labels`.
- Use a curated color palette in Drupal Canvas by annotating an SDC string prop with `x-curated-color-palette`.
- Let Canvas editors pick a curated color for a component prop both when bound to a field and when set statically on a page.
- Ship a starter palette and a working component pattern by enabling the `curated_colors_example` submodule.
- Build a constrained "style variant" picker (button styles, layout options) by treating the palette as a labeled key list.
- Attach palette cache tags to rendered fields so display caches clear automatically when a palette changes.
- Extend or filter a palette's effective colors at runtime from a custom module by subscribing to `PaletteColorsEvent`.
