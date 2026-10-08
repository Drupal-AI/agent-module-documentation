# Block content template — agent index

Adds an entity-level Twig template + theme suggestions + CSS classes for **custom (content) block**
entities, so they can be themed like nodes/terms. Depends on `block_content`. **No config, no routes,
no permissions, no Drush.**

- **Theme hook, template file, suggestions, variables, CSS classes** → [theming/templates.md](theming/templates.md)

Key facts:
- Registers a `block_content` theme hook (`render element: elements`) backed by
  `templates/block-content.html.twig`; `hook_block_content_view_alter()` sets `#theme = 'block_content'`
  on every rendered custom block.
- Suggestion cascade (from `hook_theme_suggestions_HOOK`): `block_content__<view_mode>`,
  `block_content__<bundle>`, `block_content__<bundle>__<view_mode>`, `block_content__<id>`,
  `block_content__<id>__<view_mode>` → so template files like `block-content--<bundle>.html.twig`.
- Preprocess exposes `id`, `bundle`, `view_mode`, `label`, `content`.
