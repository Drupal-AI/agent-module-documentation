# Gutenberg hooks (`gutenberg.api.php`)

All are `hook_*` implementations you add to a module (some also work in themes, as noted).

| Hook | Purpose |
|---|---|
| `hook_gutenberg_media_search_query_alter(Request $request, string $type, string $search, Query $query)` | Alter the entity query behind the editor's media (file) search — add conditions, ranges, etc. |
| `hook_gutenberg_media_library_view_alter(array &$build_ui)` | Alter the render array of the Gutenberg Media Library dialog. |
| `hook_gutenberg_info_alter(array &$info)` | Alter the collected gutenberg definitions (the `*.gutenberg.yml` data) — e.g. remove a block's `libraries-view` entry. |
| `hook_gutenberg_render_block_alter(&$block_content, &$block)` | Alter a block's final rendered inner HTML. `$block` has `blockName`, `attrs`, `innerBlocks`, `innerContent`, `innerHtml`. **Works in themes too.** |
| `hook_gutenberg_render_block_BASE_BLOCK_ID_alter(&$block_content, &$block)` | Same, for one block id — `BASE_BLOCK_ID` is the block name with `/`→`_` (e.g. `core/columns` → `core_columns`). |
| `hook_gutenberg_block_view_alter(array &$build, &$block_content)` | Alter the render array produced by `DynamicRenderProcessor` (e.g. add a `#pre_render`). |
| `hook_gutenberg_block_view_BASE_BLOCK_ID_alter(array &$build, &$block_content)` | Per-block-id variant of the above. |
| `hook_gutenberg_node_type_route(RouteMatchInterface $route_match)` | Return the Gutenberg content type for a **custom route** (when the type can't be read from a `node`/`node_type` route parameter). Return the machine name string or NULL. |

Deprecated:

- `hook_gutenberg_blocks_alter(&$js_files_edit, &$css_files_edit, &$css_files_view)` — replaced by
  Drupal libraries in `MODULE.gutenberg.yml` (see plugins/blocks-and-plugins.md).

Example — add a modifier class to `core/columns`:

```php
function my_module_gutenberg_render_block_alter(&$block_content, &$block) {
  if ($block['blockName'] === 'core/columns') {
    $processor = new \Drupal\Gutenberg\Html\TagProcessor($block_content);
    if ($processor->next_tag() && $processor->has_class('wp-block-columns')) {
      $processor->add_class('wp-block-columns--custom-modifier');
    }
    $block_content = $processor->get_updated_html();
  }
}
```
