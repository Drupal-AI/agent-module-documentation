# Hooks

Declared in `image_effects.api.php`.

### `hook_image_effects_text_overlay_text_alter(string &$text, ConfigurableImageEffectBase $image_effect): void`
Alter the string used by a **Text Overlay** effect just before it is rendered onto the image.
Useful for injecting dynamic/tokenized text or per-context overrides.

```php
function mymodule_image_effects_text_overlay_text_alter(string &$text, ConfigurableImageEffectBase $image_effect): void {
  if ($image_effect->getPluginId() !== 'image_effects_text_overlay') {
    return;
  }
  $text = 'my altered text';
}
```
