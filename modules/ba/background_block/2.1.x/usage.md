Background Block adds an optional per-block background color and opacity that editors set on the standard block configuration form.

---

Background Block is a small presentation helper for core's Block layout. When enabled, it alters the block configuration form (`block_form`) to add a "Color settings" fieldset with a color picker (`#type` color) and an opacity number field. The chosen values are saved as `background_block` third-party settings on the block config entity, and `hook_preprocess_block()` applies them to the rendered block's `style` attribute. The form and its values are gated by a single `administer background block` permission; there is no separate settings page — configuration is entirely per block on the existing block-edit form. It has no dependencies beyond core `block` and ships no config, schema, services, or plugins.

---

- Give a specific block a solid background color without writing custom CSS or editing a theme.
- Add a per-block background to highlight a call-to-action or promo block in a sidebar.
- Set a background color on a menu block to visually separate navigation from surrounding content.
- Apply distinct background colors to several blocks in the same region so editors can tell them apart.
- Tint a footer block or contact block with a brand color placed directly in the block config.
- Adjust a block's opacity to soften it against a page background image.
- Let site builders style blocks entirely from the block-layout UI instead of theme templates.
- Restrict who can change block backgrounds by granting the `administer background block` permission to trusted roles only.
- Prototype block styling quickly during theming before committing values to a stylesheet.
- Give editors a color picker (browser-native hex chooser) for consistent, valid color values.
- Remove a previously set background by clearing the color field and re-saving the block.
- Differentiate a "featured" block region visually without adding block-type-specific CSS classes.
- Provide a lightweight alternative to Layout Builder styling for simple background-color needs.
- Apply a background color to system blocks (search, user login) surfaced in Block layout.
- Style a promotional banner block placed in the content region with a colored backdrop.
- Keep block styling in configuration so it exports with the block via config sync.
- Set a neutral/white background on a block that would otherwise inherit a colored region.
- Give a sidebar block a subtle tint to group related links.
- Let a content team recolor blocks per campaign without a theme deployment.
- Apply per-block opacity for layered, overlapping design treatments.
