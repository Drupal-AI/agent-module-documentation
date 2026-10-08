<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring the SVG Sprite source and field

## Point the module at a sprite file
Go to **Administration → Configuration → Content → SVG Sprite settings**
(`/admin/config/content/svg_sprite`, permission `administer site configuration`).

- **Source of the SVG sprites file** (required) — one of:
  - a full URL (`https://…/sprite.svg`) — fetched with the HTTP client;
  - a path relative to the web root (`themes/…/sprite.svg`);
  - `theme://[theme_name]/path/to/sprite.svg` — resolved against the named theme's path.
- **Sort sprites alphabetically** — sort the option list by symbol `id` (or `aria-label`).

On save, `SvgSpriteService` reads the file's `<defs><symbol id="…">` entries with
`SimpleXMLElement`, builds the id → label map (label = `aria-label` or the id), and stores
`symbols` plus the resolved `href` in `svg_sprite.settings`. The form shows a **Sprite preview**
of every symbol.

## Add the field
1. Add a field of type **SVG Sprite** to an entity bundle.
2. The **SVG Sprite** widget renders a `<select>` populated from the configured symbol list
   (labels are tag-stripped/decoded for the option text).
3. Set the display formatter to **SVG Sprite** to render the chosen symbol.

## Default href
`hook_preprocess_svg_sprite()` falls back to the configured `href` when a render call passes none,
so field/Twig output always references the current sprite file.
