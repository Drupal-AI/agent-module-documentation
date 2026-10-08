# Alter hooks

From `drimage_improved.api.php`.

## `hook_drimage_improved_image_style_alter(ImageStyle &$style)`
Called in `DrimageManager::createDrimageStyle()` (via
`$this->moduleHandler()->alter('drimage_improved_image_style', $style)`) just before the
generated style is saved. Add/adjust effects on the on-the-fly style. Example adds a manual crop:
```php
function hook_drimage_improved_image_style_alter(ImageStyle &$style) {
  $configuration = ['id' => 'crop_crop', 'data' => ['crop_type' => 'custom'], 'uuid' => NULL, 'weight' => -50];
  $effect = \Drupal::service('plugin.manager.image.effect')->createInstance($configuration['id'], $configuration);
  $style->addImageEffect($effect->getConfiguration());
}
```

## `hook_drimage_improved_proxy_cache_periods_alter(array &$periods)`
Alter the list of selectable proxy cache periods.
```php
function hook_drimage_improved_proxy_cache_periods_alter(array &$periods) {
  $periods[] = 32400;
}
```
