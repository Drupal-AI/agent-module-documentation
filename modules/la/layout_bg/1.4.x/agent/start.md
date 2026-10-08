# Layout BG — agent index

Two Layout Builder section layouts with a `background` region rendered as a real `<img>`/`<video>`
via CSS `object-fit`. No config page (`configure` null), no permissions (uses Layout Builder access),
no Drush. Depends on core `layout_builder` (+ `layout_discovery`).

- **The two layouts, their regions, and every per-section setting key** →
  [configure/settings.md](configure/settings.md)
- **Extend `LayoutBgTrait` to add a background region to your own layout plugin** →
  [extend/trait.md](extend/trait.md)
- **The template, regions, and CSS library (theming/overrides)** → [theming/template.md](theming/template.md)

Key facts:
- Layouts (`layout_bg.layouts.yml`): `layout_bg_onecol` (regions `background`, `content`; class
  `LayoutBgOneCol` extends core `LayoutDefault`) and `layout_bg_twocol` (regions `background`,
  `first`, `second`; class `LayoutBgTwoCol` extends core `TwoColumnLayout`). Both use
  `LayoutBgTrait` and `theme_hook: layout__layout_bg`.
- Only the **first non-empty block** in the background region is displayed; later blocks are kept
  only for cache metadata, and the shown block's label is suppressed.
- Settings values (colors, opacity, text color) are written into **inline `style` attributes** by
  `LayoutBgTrait::processBackground()`. They come from the section config form, editable only by
  users with Layout Builder access — treat as trusted-admin input.
- `examples/*` are sample modules (not enabled, not documented here).
