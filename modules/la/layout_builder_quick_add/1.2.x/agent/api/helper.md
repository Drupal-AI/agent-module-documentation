# API — LayoutBuilderQuickAddHelper service

Service id `layout_builder_quick_add.helper` →
`Drupal\layout_builder_quick_add\LayoutBuilderQuickAddHelper`
(implements `TrustedCallbackInterface`, uses `StringTranslationTrait`).

Constructor args (`layout_builder_quick_add.services.yml`):
`@config.factory`, `@plugin.manager.block`, `@entity_type.manager`, `@entity_display.repository`.

```php
$helper = \Drupal::service('layout_builder_quick_add.helper');
```

## Public methods

| Method | Returns | Purpose |
|--------|---------|---------|
| `getQuickAddEnabledBlocks()` | array | The list of block types to offer. Reads `layout_builder_quick_add.settings:blocks_order`; iterates its keys in order and includes each existing `block_content_type`. If `blocks_order` is empty, returns ALL block content types. Each entry: `id`, `plugin_id` (`inline_block:<id>`), `label`, `description`, `icon`. |
| `getBlockTypeData($types, $id, $display_description)` | array | Builds one entry (used by the above). `description` is included only when `display_description` is truthy and the type has `getDescription()`. `icon` is the URL of the file id stored in the `layout_builder_quick_add:icon` third-party setting, or NULL. |
| `getViewModeMessage($id)` | string | Returns `settings:multiple_view_mode_message` when `multiple_view_mode` is on AND the `block_content` bundle `$id` has more than one view mode (via `entity_display.repository`); else `''`. |
| `getScreenshot($id, $label)` | array | Returns a `#theme => 'image'` render for the file stored under `settings:screenshot:<id>`, or `[]` if none. |
| `getPreview()` | array | Builds the full `quick_add_blocks_listing` render used in the settings form's Preview tab (per-item links are dummy links to the project page). Attaches the configured CSS library. |
| `layoutBuilderPreRender(array $element)` (static) | array | `#pre_render` callback that rewrites core add-block links to the module's route. Registered via `hook_element_info_alter`. See [../hooks/hooks.md](../hooks/hooks.md). |
| `trustedCallbacks()` (static) | array | Returns `['layoutBuilderPreRender']`. |

Public property: `public Config $layoutBuilderQuickAddConfig` — the loaded
`layout_builder_quick_add.settings` config object.

Note: block plugin ids offered are always derived as `inline_block:<block_content_type id>` from
loaded `block_content_type` entities — not from request input.
