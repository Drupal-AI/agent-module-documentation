Color Field adds a "Color" field type that stores a hex color value (and optional opacity), with a choice of color-picker widgets and several display formatters ranging from a text value to a rendered swatch or injected CSS.

---

The module registers a `color_field_type` field so any entity — nodes, taxonomy terms, users, media, paragraphs — can carry one or more color values. Storage settings let you pick the hex format (`#123ABC`, `123abc`, etc.) and a per-field toggle records an opacity value (0–1) alongside the color; input is validated against a hex regex and opacity range. Data entry uses one of several widgets: a plain default text input, an HTML5 native `<input type="color">`, a Spectrum.js picker, a box/preset-swatch picker, and a grid picker (the latter three bundle third-party JS libraries). For display it ships four formatters: plain text (in your chosen format), a colored swatch (circle or square, configurable size, optional opacity), swatch-with-options, and a CSS formatter that writes a real CSS declaration (e.g. sets `background-color` on a selector) so a field value can style the page. It also exposes Token integration (HEX/RGB/RGBA tokens and individual red/green/blue/opacity values), a Feeds target for imports, a migrate field plugin for D6/D7 upgrades, and a set of value-object classes (`ColorHex`, `ColorRGB`, `ColorHSL`) for converting between color spaces in code. Everything is configured through the standard Field UI (Manage fields / form display / display) — there is no separate settings page.

---

- Add a brand/theme color picker field to a content type.
- Let editors choose a background color per node.
- Store a category color on taxonomy terms for color-coded listings.
- Record a color plus opacity (RGBA) for overlays and tints.
- Offer a native HTML5 color picker for quick input.
- Provide a rich Spectrum.js picker with palettes and alpha.
- Present a fixed set of preset colors via the box widget.
- Use a grid swatch picker for a constrained palette.
- Choose the stored hex format (uppercase/lowercase, with/without `#`).
- Display a color as a small circular or square swatch.
- Show the swatch at a configurable width and height.
- Render the raw hex/RGB text value in listings.
- Inject a CSS declaration so a field value colors an element on the page.
- Set `background-color` on a custom selector via the CSS formatter.
- Output `rgba()` values including opacity in templates via tokens.
- Use `[node:field_color:rgb:red]`-style tokens in other fields or Pathauto.
- Color-code calendar/event entries by a per-entity color.
- Let users personalize a profile accent color.
- Build a swatch legend for a design-system reference page.
- Theme cards or badges using an editor-selected color.
- Import color values from a CSV/feed via the Feeds target.
- Migrate legacy color field data from Drupal 6/7.
- Convert stored hex to RGB or HSL in custom code with the color value objects.
- Validate that entered values are proper hex codes automatically.
- Override swatch markup via the `color-field-formatter-swatch` template.
