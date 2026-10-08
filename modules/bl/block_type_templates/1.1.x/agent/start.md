# Block Type Templates — agent index

Adds per-block-type Twig template suggestions and CSS classes. No config, no permissions, no
services, no plugins — purely two theming hooks.

- **The template suggestions, CSS classes, and how to add a per-type template** →
  [theming/templates.md](theming/templates.md)

Key facts:
- `hook_theme_suggestions_block_alter()` adds `block__block_content_<block_type>` and
  `block__block_content_<block_type>__<view_mode>` (so templates
  `block--block-content-<block-type>.html.twig` and `…--<view-mode>.html.twig` work).
- `template_preprocess_block()` adds classes: `block-content` + `block-type--<bundle>` for
  block-content blocks; `inline-block` + `block-type--<derivative>` for Layout Builder inline blocks.
- Fires only for blocks whose content is a `BlockContentInterface`; no effect otherwise.
