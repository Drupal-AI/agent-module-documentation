# Theme — templates, hooks, libraries, block-type icon

## Theme hooks (`hook_theme` in `.module`)

| Hook | Template | Variables |
|------|----------|-----------|
| `quick_add_blocks_listing` | `templates/quick-add-blocks-listing.html.twig` | `content` (array of item renders), `see_more` (link render), `cancel` (link render) |
| `quick_add_blocks_listing_item` | `templates/quick-add-blocks-listing-item.html.twig` | `plugin_id`, `label`, `description`, `screenshot`, `multiple_view_mode_message`, `icon`, `link` |

The listing template wraps items in `.layout-builder__quick-add-blocks` (also class
`js-layout-builder__quick-add-blocks`, used by the cancel AJAX command) and renders `see_more` +
`cancel` in an actions row. The item template renders the block `icon` as
`<img src="{{ icon }}">` (when set), the `link`, and — when a `description`, `screenshot`, or
`multiple_view_mode_message` exists — a `?` tooltip trigger with that content. All values pass
through Twig autoescaping. Override either template in your theme to restyle the picker.

## CSS libraries (`layout_builder_quick_add.libraries.yml`)

- `layout_builder_quick_add/default` → `themes/css/default/default.css`
- `layout_builder_quick_add/claro` → `themes/css/claro/claro.css`
- `layout_builder_quick_add/gin` → `themes/css/gin/gin.css`

The library attached at runtime is chosen by `settings:theme` (see
[../configure/settings.md](../configure/settings.md)); `none` attaches nothing. Source SCSS lives
under `themes/scss/` (built with the bundled gulpfile — not needed to use the module).

## Block-type icon (third-party setting)

Each `block_content_type` may carry a `layout_builder_quick_add` / `icon` third-party setting whose
value is a file id. It is set from the icon upload added to the block-type edit form (see
[../hooks/hooks.md](../hooks/hooks.md)) and read by
`LayoutBuilderQuickAddHelper::getBlockTypeData()` to produce the `icon` URL shown per item.

Read it in code:

```php
$fid = $block_content_type->getThirdPartySetting('layout_builder_quick_add', 'icon', NULL);
```
