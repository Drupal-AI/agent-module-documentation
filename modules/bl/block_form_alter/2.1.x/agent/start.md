# Block Form Alter — agent index

A developer-only module. It provides **two alter hooks** so you can modify block configuration
forms uniformly across the Block, Block Content and Layout Builder code paths. **No config, no
UI, no permissions, no services, no plugins, no Drush.** Depends on core `block`.

- **The two hooks, when each fires, and how to implement them** →
  [hooks/block-form-alter.md](hooks/block-form-alter.md)

Key facts:
- `hook_block_plugin_form_alter(&$form, &$form_state, $plugin)` — fires for block **plugins**
  (every plugin **except** `block_content` / `inline_block`).
- `hook_block_type_form_alter(&$form, &$form_state, $block_type)` — fires for custom **content
  block** forms (`block_content` and `inline_block`, including inline blocks in Layout Builder);
  `$block_type` is the block bundle machine name.
- Mechanism: one `hook_form_alter()` detects the context (`block_form`,
  `block_content_*_form`, `layout_builder_add_block` / `layout_builder_update_block`), resolves
  the plugin id / bundle, and re-dispatches via `\Drupal::moduleHandler()->invokeAll()`.
- Exists to work around core issue #3028391 (altering inline-block forms under Layout Builder).
