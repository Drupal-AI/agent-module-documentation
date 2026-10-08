# Theming

## Theme hook
`layout__layout_bg` (registered in `layout_bg_theme()`), template
`templates/layout--layout-bg.html.twig`, `base hook: layout`. Both layouts point their
`theme_hook` at it. `template_preprocess_layout__layout_bg()` copies
`content['#base_layout_template']` to the `base_layout_template` variable.

Available variables:
- `content` — the render array; `content.processed_background` holds the first non-empty background
  block, `content.background` the full region (used in edit mode).
- `attributes` / `region_attributes` — layout and per-region attributes; the trait pre-fills
  `region_attributes.background`, `.overlay_attributes`, `.content_attributes` with the inline
  styles/classes.
- `base_layout_template` — path of the base layout template (`layout--onecol.html.twig` or
  `layout--twocol-section.html.twig`) that is `{% include %}`d for the content regions.

The template renders two branches: an **edit-mode preview** (when
`content.background.layout_builder_add_block` is set) with a color-preview box and guidance text, and
the **front-end markup** (`.layout-bg-section` → `.layout-bg-bg-container` with the background wrapper
and overlay, then the content container).

## CSS libraries (`layout_bg.libraries.yml`)
- `layout_bg` — `css/layout_bg.css` (the `object-fit`, overlay, and positioning styles).
- `layout_bg_onecol` — depends on `layout_discovery/onecol` + `layout_bg/layout_bg`.
- `layout_bg_twocol` — depends on `layout_builder/twocol_section` + `layout_bg/layout_bg`.

## Overriding
Copy `layout--layout-bg.html.twig` into your theme to change wrapper markup, or add classes/CSS
targeting `.layout-bg-section`, `.layout-bg-bg-wrapper`, `.layout-bg-overlay`,
`.layout-bg-content-container`, and the `static-image` / `absolute-image` / `center-content` /
`set-text-color` / `link-underline` classes.
