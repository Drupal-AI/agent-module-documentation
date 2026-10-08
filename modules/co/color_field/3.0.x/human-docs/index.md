# Color Field — manual setup guide

**Color Field** (`color_field`) adds a dedicated **Color** field type to Drupal, so any entity — nodes, taxonomy terms, users, media, paragraphs — can store one or more color values. Each value is a hex color (for example `#123ABC`), with an optional opacity value (0–1) recorded alongside it when you turn that on. Instead of asking editors to type a raw hex code into a plain text field and hoping they get it right, Color Field gives them real color-picker widgets and validates what they enter against a proper hex pattern.

The module solves a common design-system problem: letting editors *choose* a color and then having the site actually *use* that color. On the input side it ships several widgets — a plain text input, the native HTML5 `<input type="color">`, a rich Spectrum.js picker, a preset "box" swatch picker, and a grid swatch picker (the last three bundle third‑party JavaScript libraries). On the display side it ships four formatters: plain hex/RGB text, a colored swatch (circle or square, sized as you like), a swatch-with-options variant, and a CSS formatter that writes a real CSS declaration — so a stored value can, say, set `background-color` on an element and actually style the page.

Color Field works the moment you enable it: it depends only on core's **Field** module, and there is **no separate settings page**. Everything is configured per field through the standard Field UI (Manage fields, Manage form display, Manage display). The module also quietly provides Token integration (HEX/RGB/RGBA tokens plus per‑channel red/green/blue/opacity values), a Feeds target for imports, a migrate plugin for Drupal 6/7 upgrades, and a small set of value-object classes (`ColorHex`, `ColorRGB`, `ColorHSL`) for converting between color spaces in custom code.

This guide is written for a **human** clicking through the admin UI. If you want terse, token‑cheap references for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable it.

## How to use it

Color Field has no global configuration page. Instead it surfaces as a **field type** you add to a content type (or any other fieldable entity), and its options live entirely inside the standard Field UI.

1. **Add the field.** Go to **Structure → Content types → (your type) → Manage fields → Create a new field** and choose **Color** (field type id `color_field_type`). In the field's storage/settings you pick how the hex is stored — `#HEXHEX`, `HEXHEX`, `#hexhex`, or `hexhex` (upper/lower case, with or without the leading `#`) — and toggle whether an opacity value (0–1) is recorded with each color.

2. **Pick an input widget.** Under **Manage form display**, choose the widget editors will use:
   - **Default** — a plain text input.
   - **HTML5 color** — the browser's native color picker.
   - **Spectrum** — the Spectrum.js picker with palettes, buttons, and alpha.
   - **Box** — a fixed set of preset color boxes.
   - **Grid** — a grid swatch picker for a constrained palette.

   The Spectrum, Box, and Grid widgets load bundled third‑party JavaScript libraries; some expect their files to be present under `/libraries/…`.

3. **Pick a display formatter.** Under **Manage display**, choose how the stored color is shown:
   - **Text** — the raw hex/RGB value in your chosen format.
   - **Swatch** — a colored circle or square at a configurable width and height.
   - **Swatch (options)** — a variant of the swatch formatter.
   - **CSS** — injects a real CSS declaration, letting you set a property such as `background-color` on a selector so the field value styles the page.

To customize swatch markup, copy the `color-field-formatter-swatch` template into your theme. To reuse a color value elsewhere — in Pathauto patterns, other fields, or custom code — use the HEX/RGB/RGBA tokens the module exposes (for example `[node:field_color:rgb:red]`).
