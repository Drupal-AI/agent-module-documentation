# Blazy hooks

Documented in `blazy.api.php`. Implement in `MYMODULE.module`.

- `hook_blazy_settings_alter(&$settings, $items)` — alter resolved settings before build.
- `hook_blazy_base_settings_alter(&$settings, $context)` — alter base/global settings.
- `hook_blazy_alter(&$build, $settings)` — alter the final Blazy render array.
- `hook_blazy_build_alter(&$build, $settings)` — alter each built item.
- `hook_blazy_item_alter(&$build, $settings, $item)` — alter a single media/image item.
- `hook_blazy_attach_alter(&$load, $attach)` — add/adjust attached libraries & drupalSettings.
- `hook_blazy_lightboxes_alter(&$lightboxes)` — register a custom lightbox (e.g. `colorbox`,
  `photoswipe`) so it appears in the `media_switch` options.
- `hook_blazy_form_element_alter(&$form, $definition)` /
  `hook_blazy_complete_form_element_alter(...)` — alter formatter/admin form elements.
- `hook_config_schema_info_alter(&$definitions)` — used with `configSchemaInfoAlter()` to add
  Blazy settings to a formatter's schema.

Example (register a lightbox):
```php
function mymodule_blazy_lightboxes_alter(array &$lightboxes) {
  $lightboxes[] = 'photoswipe';
}
```

Alter logic lives in `src/BlazyAlter.php`.
