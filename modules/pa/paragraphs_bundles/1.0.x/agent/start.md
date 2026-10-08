# Paragraphs Bundles — agent index

A suite of prebuilt Paragraph types with a **Content** tab (fields) and a **Display** tab (per-instance
colors/border/radius/margin/padding/width/shadow/opacity) on top of Paragraphs + Field Group. The base
module provides the shared field types, styling machinery, and a `simple_bundle`; 26 submodules add
specific bundles. No config UI (`configure` null), no permissions, no Drush. Depends on `paragraphs`,
`entity_reference_revisions`, `field_group`, and many core modules.

- **The two custom field types + widgets/formatters (Color Picker, BG Opacity Range) and how to reuse them** →
  [plugins/fields.md](plugins/fields.md)
- **How every bundle template turns `pb_display_*` fields into CSS variables, the `decode_entities` filter, shared preprocess** →
  [theming/rendering.md](theming/rendering.md)
- **How bundles/fields are provisioned and how to add your own bundle** →
  [extend/bundles.md](extend/bundles.md)

Submodules (each has its own `data.json` / `usage.md` / `agent/start.md` under `modules/<sub>/1.0.x/`):
3d_carousel, 3d_flip_box, accordion, alert, block, block_content, card, carousel, contact_form, content,
grid, hero, icon, image, image_background, image_grid, image_overlay, layout, link, modal, node_reference,
parallax, slideshow, tabs, views, webform — e.g.
[../../modules/paragraph_bundle_accordion/1.0.x/agent/start.md](../../modules/paragraph_bundle_accordion/1.0.x/agent/start.md).

Key facts:
- Base paragraph type: `simple_bundle`. Custom field types: `paragraphs_bundles_rgb` (Color Picker), `paragraphs_bundles_range` (BG Opacity Range).
- Display fields shared across bundles: `pb_display_bg`, `pb_display_bg_hover`, `pb_display_text`, `pb_display_text_hover`, `pb_display_border_color`, `pb_display_border_hover`, `pb_display_border`, `pb_display_border_radius`, `pb_display_margin`, `pb_display_padding`, `pb_display_width`, `pb_display_shadow`, `pb_display_bg_opacity`.
- Templates emit CSS custom properties (`--pb-bg`, `--pb-tx`, `--pb-br`, …) + utility classes; theme-agnostic, no jQuery.
- `paragraphs_bundles.services.yml` registers only the `decode_entities` Twig extension. Submodule field/type config is auto-imported from each module's `config/optional`.
