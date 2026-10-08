<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
SVG Sprite adds a field type that lets editors pick an icon from an SVG sprite file by symbol id, and renders it with a `<use href="file.svg#symbol-id">` reference.

---

Point the module at a sprite file (a full URL, a path relative to the web root, or `theme://[theme]/path.svg`) on the settings form at **Administration → Configuration → Content → SVG Sprite settings** (`svg_sprite.settings`, permission `administer site configuration`). The service reads the file's `<defs><symbol id="…">` entries with `SimpleXMLElement`, optionally alpha-sorts them, and stores the id/label list (and the resolved href) in config. Editors then get an **SVG Sprite** field whose widget is a `<select>` populated from that list; the **SVG Sprite** formatter renders the chosen symbol. A Twig function `{{ svg_sprite('lightbulb', {'class': 'my_css_class'}) }}` and a token `[svg_sprite:sprite:ID]` render sprites outside fields. An optional `svg_sprite_ckeditor5` sub-module adds a CKEditor 5 button to insert sprites in rich text.

The rendered markup is a `<svg><use href="…#id"/></svg>` element pointing at the external sprite file — the module references the sprite rather than inlining uploaded SVG content, and both the `href` and the `sprite_id` flow through Twig's autoescaping in the `svg-sprite.html.twig` template. Symbol labels shown in the widget select are stripped of tags and decoded. The sprite source is admin-configured (site-configuration permission), and the settings-form preview and token render output allow-list `svg`/`use` tags. Set a default sprite file in config so field/twig output has an href even when none is passed.

---
- Add an "SVG Sprite" field to a content type for choosing an icon
- Let editors pick a symbol from a dropdown generated from the sprite file
- Render a chosen sprite with the SVG Sprite field formatter
- Reference a sprite file by full URL, web-root-relative path, or `theme://theme/path.svg`
- Auto-populate the symbol list from every `<symbol id="">` in the sprite
- Alpha-sort the symbol list by id or `aria-label`
- Display a sprite in a Twig template with `{{ svg_sprite('id') }}`
- Pass custom attributes/classes to the Twig sprite function
- Insert a sprite via the `[svg_sprite:sprite:ID]` token
- Insert sprites into CKEditor 5 with the `svg_sprite_ckeditor5` sub-module
- Preview all available sprites on the settings form
- Set a site-wide default sprite file so output always has an href
- Use `aria-label` on symbols to give friendly option labels
- Cache-bust the sprite href with the file mtime for local files
- Keep icon markup tiny by referencing a shared external sprite via `<use>`
- Swap the entire icon set by pointing config at a different sprite file
- Add `sprite`/`sprite-<id>` classes automatically for styling
- Mark decorative sprites `aria-hidden`/`focusable=false` by default
- Provide a consistent icon system across fields, Twig, and rich text
- Reuse a theme-provided sprite file via the `theme://` source prefix