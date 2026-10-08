# Gutenberg Editor — agent index

Brings the WordPress Gutenberg block editor to Drupal as an `@Editor` + `@Filter` pair on a
`gutenberg` text format, switched on **per content type**. Content is block markup stored in a
long-text field and rendered through block processors. No single settings page (`configure` =
null) — configuration is the per-content-type toggle plus the text format.

- **Enable Gutenberg on a content type, the text format/editor, templates & image styles** →
  [configure/enable.md](configure/enable.md)
- **Add editor blocks & JS plugins: the `MODULE.gutenberg.yml` discovery file, dynamic/custom
  blocks, and the `@GutenbergPlugin` plugin type** → [plugins/blocks-and-plugins.md](plugins/blocks-and-plugins.md)
- **Hooks (`gutenberg.api.php`)** → [hooks/hooks.md](hooks/hooks.md)
- **Permissions** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Enable per content type: config `gutenberg.settings` key `<node_type>_enable_full: true`
  ("Enable Gutenberg experience" checkbox on the content-type form). Siblings: `<type>_template`,
  `<type>_template_lock`, `<type>_allowed_image_styles`.
- Ships `filter.format.gutenberg` + `editor.editor.gutenberg` (Editor plugin id `gutenberg`,
  Filter id `gutenberg`). Field formatter `gutenberg_text`.
- Plugin type: `@GutenbergPlugin` (manager `plugin.manager.gutenberg.plugin`, namespace
  `Plugin/GutenbergPlugin`) — editor-side JS plugins (e.g. `DrupalImage`).
- Reusable blocks: block_content type `reusable_block`; patterns vocab `pattern_categories`.
- Controller routes live under `/editor/*` (media, blocks, patterns, oEmbed).
- Permissions: `use gutenberg`, `manage blocks lock`, `create and edit custom gutenberg content blocks`.
- Submodule `example_blocks` → `modules/gutenberg/modules/example_blocks/3.0.x/`.
