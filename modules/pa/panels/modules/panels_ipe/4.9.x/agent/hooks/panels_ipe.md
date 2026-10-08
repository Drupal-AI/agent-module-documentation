# panels_ipe — hooks

Declared in `panels_ipe.api.php`. All receive the current
`Drupal\panels\Plugin\DisplayVariant\PanelsDisplayVariant`.

## `hook_panels_ipe_blocks_alter(array &$blocks, PanelsDisplayVariant $panels_display)`

Modify the list of block plugins offered in the IPE block picker (e.g. restrict to blocks
from your module).

```php
function mymodule_panels_ipe_blocks_alter(array &$blocks, $panels_display) {
  foreach ($blocks as $key => $block) {
    if ($block['provider'] !== 'mymodule') {
      unset($blocks[$key]);
    }
  }
}
```

## `hook_panels_ipe_layouts_alter(array &$layouts, PanelsDisplayVariant $panels_display)`

Modify the list of layouts offered in the IPE layout picker (e.g. only a given category).

## `hook_panels_ipe_panels_display_presave(PanelsDisplayVariant $panels_display, array $layout_model)`

Act on a Panels display just before the IPE saves it. `$layout_model` is the decoded
LayoutModel from the JavaScript app; useful to, e.g., redirect the display to a custom
storage:

```php
function mymodule_panels_ipe_panels_display_presave($panels_display, array $layout_model) {
  if (isset($layout_model['use_custom_storage'])) {
    $config = $panels_display->getConfiguration();
    $panels_display->setStorage('custom_storage_key', $config['storage_id']);
  }
}
```
