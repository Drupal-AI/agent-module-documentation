# Layout Builder Extra Templates — agent index

Adds Twig template suggestions for `block_content` and `inline_block` blocks, keyed by block bundle and
active theme. No config, permissions, schema, services, or Drush — enable and add templates to your theme.
Depends on core `layout_builder`.

- **The exact suggestions added and how to use them in a theme** → [theming/suggestions.md](theming/suggestions.md)

Key facts:
- Single hook: `hook_theme_suggestions_block_alter()` → `AddExtraThemeSuggestions::add()`.
- Only acts when `#base_plugin_id` is `block_content` or `inline_block`.
- Bundle source: `#block_content->bundle()` for reusable blocks; `#derivative_plugin_id` for inline blocks.
- Adds `block__<bundle>` and `block__<theme>__<bundle>` near the top of the list, and appends
  `block__<theme>__<base_plugin_id>__<bundle>`.
