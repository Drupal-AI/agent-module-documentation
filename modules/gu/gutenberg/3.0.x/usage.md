Gutenberg brings the WordPress Gutenberg block editor to Drupal as a text-editor/text-format that you enable per content type. Editors compose a page from blocks (paragraphs, headings, media, columns, embeds, reusable blocks, custom blocks) that are stored as block markup in a body field and rendered back through a filter.

---

Gutenberg registers an `@Editor` plugin (`gutenberg`) and a companion `@Filter` plugin (`gutenberg`), and ships a `gutenberg` text format + `editor.editor.gutenberg` that pairs them; the `GutenbergFilter` parses the stored Gutenberg block markup and renders it through a pipeline of **block processors** (services tagged `gutenberg_block_processor`: Drupal blocks, oEmbed, reusable blocks, content blocks, layout, dynamic render, field mapping, duotone). Rather than a text-format-per-field, Gutenberg is switched on **per content type**: the content-type add/edit form gains an "Enable Gutenberg experience" checkbox, and `_gutenberg_node_type_form_submit()` writes `<node_type>_enable_full: true` into the `gutenberg.settings` config object (with sibling keys `<type>_template`, `<type>_template_lock`, `<type>_allowed_image_styles`); `GutenbergContentTypeManager::isContentTypeSupported()` reads that flag to decide whether to swap the node form for the full-screen block editor. The available blocks come from `gutenberg.blocks.yml` (core WordPress blocks + embeds) plus blocks contributed by any module/theme through a `<name>.gutenberg.yml` discovery file (handled by `GutenbergLibraryManager` / `BlocksLibraryManager`), which declares `libraries-edit`, `libraries-view`, `dynamic-blocks`, and `custom-blocks`. Editor-side JS "plugins" are a real plugin type (`@GutenbergPlugin` annotation, manager `plugin.manager.gutenberg.plugin`, e.g. `DrupalImage`). It also provides a `gutenberg_text` field formatter, reusable blocks (a `reusable_block` block_content type + a `pattern_categories` vocabulary), a Media Library opener, and REST-like controller routes under `/editor/*` for media, blocks, patterns, and oEmbed. Three permissions gate it: `use gutenberg`, `manage blocks lock`, and `create and edit custom gutenberg content blocks`. There is no single settings page (`configure` is null) — configuration is the per-content-type toggle plus the text format.

---

- Give editors a full block-based page builder for a content type (like the WordPress editor).
- Enable Gutenberg on a specific content type via the "Enable Gutenberg experience" checkbox.
- Compose pages from core blocks: paragraph, heading, image, gallery, columns, quote, table, etc.
- Embed media from the Media Library directly into block content.
- Insert oEmbed content (YouTube, Vimeo, Twitter, SoundCloud, …) as embed blocks.
- Create and reuse **reusable blocks** across content (stored as `reusable_block` block_content).
- Organize reusable blocks/patterns with the `pattern_categories` taxonomy.
- Build custom non-reusable content blocks inline (permission-gated).
- Render Drupal blocks inside Gutenberg content (system, search form, views blocks, …).
- Provide a starter block template per content type via the `<type>_template` setting.
- Lock a content type's block template so editors can't restructure it (`<type>_template_lock`).
- Restrict which image styles are offered in the editor per content type.
- Add custom editor blocks from a module/theme via a `MODULE.gutenberg.yml` discovery file.
- Register server-side "dynamic blocks" rendered through a Twig template.
- Ship front-end/edit JS libraries for blocks with `libraries-edit` / `libraries-view`.
- Add a Gutenberg editor JS plugin via the `@GutenbergPlugin` plugin type.
- Alter a block's rendered HTML with `hook_gutenberg_render_block_alter()`.
- Alter media search queries in the editor with `hook_gutenberg_media_search_query_alter()`.
- Resolve the content type for custom routes via `hook_gutenberg_node_type_route()`.
- Render a Gutenberg-formatted field elsewhere with the `gutenberg_text` field formatter.
- Use the `gutenberg` text format on a long-text field to parse and render block markup.
- Proxy and cache oEmbed lookups through the `/editor/oembed` controller.
- Gate editor access and custom-block creation with the module's three permissions.
- Duotone-filter images and apply layout supports through the block processors.
