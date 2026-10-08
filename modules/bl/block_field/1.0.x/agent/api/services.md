# Services & programmatic use

## block_field.manager (`BlockFieldManager`)
Args: `@plugin.manager.block`, `@context.repository`.
- `getBlockDefinitions()` — all block plugin definitions (used to build the widget's list).
- `getBlockCategories()` — distinct block categories (used by the `categories` selection handler).

## plugin.manager.block_field_selection (`BlockFieldSelectionManager`)
- `getOptions()` — `id => label` of available selection plugins.
- `getSelectionHandler($field_definition)` — instantiates the selection plugin configured
  on a given `block_field` field definition.

## Reading a stored block in code
```php
foreach ($node->get('my_block_field') as $item) {
  /** @var \Drupal\block_field\BlockFieldItemInterface $item */
  $block = $item->getBlock();      // instantiated block plugin, or NULL if empty
  if ($block) {
    $build = $block->build();      // render array
  }
  $plugin_id = $item->plugin_id;   // main property
  $settings  = $item->settings;    // block configuration array
}
```
`BlockFieldItem::getBlock()` calls the core block manager's `createInstance($plugin_id, $settings)`.
