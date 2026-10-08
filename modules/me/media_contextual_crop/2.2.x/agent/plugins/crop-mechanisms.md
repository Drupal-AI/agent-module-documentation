# Crop-mechanism plugins (`@MediaContextualCrop`)

Adapters that translate a crop-widget's data into a saved `crop` entity for a context. One
plugin per supported crop widget. Shipped by companion projects
(`media_contextual_crop_fp_adapter` = Focal Point, `media_contextual_crop_iwc_adapter` = Image
Widget Crop); this module ships **none** — it only defines the type.

- Manager service: `plugin.manager.media_contextual_crop` → `MediaContextualCropPluginManager`
- Discovery dir: `src/Plugin/MediaContextualCrop/` in any module
- Annotation: `@MediaContextualCrop` (`Drupal\media_contextual_crop\Annotation\MediaContextualCrop`)
- Interface: `MediaContextualCropInterface`; base class: `MediaContextualCropPluginBase`
- Alter hook: `hook_contextual_crop_info(&$definitions)`; cache bin key `contextual_crop_plugins`

## Annotation properties

| Property | Type | Meaning |
|---|---|---|
| `id` | string | Plugin id |
| `title` | Translation | Human label |
| `description` | Translation | Description |
| `target_field_name` | string | Field the crop widget writes to |
| `image_style_effect` | array | Image-style effect plugin ids whose `data.crop_type` this plugin owns (used by `MediaContextualCropService::styleUseMultiCrop()` to detect multi-crop styles) |

## Interface / base contract

- `saveCrop($crop_settings, string $image_style_name, string $old_uri, string $context, int $width, int $height)` — create/save the context's crop entity, return its id (called by `MediaContextualCropService::generateContextualizedImage()`).
- `getTargetFieldName()` — from `target_field_name`.
- `static processFieldData(array $field_data)` — normalize submitted widget data (base returns it unchanged).
- `processEmbedData($embed_settings)` — turn embed settings into crop settings.
- `label()`.

`MediaContextualCropPluginBase` (inject `entity_type.manager`) also provides reusable widget
helpers a subclass can call:

- `retrieveContextualCrop($context, $crop_type, $original_uri)` — `loadByProperties(['uri','type','context'])`; if none, `create()` a new `crop` bound to the source `file` entity (`entity_type=file`).
- `finishElement(&$form, $source_field_name, $default_values)` — wires the modal save submit + `widgetModify` process callback and disables the alt field.
- `static widgetModify($element)` — hides upload/remove buttons and the file link on the file widget.
- `getComponentConfig()`, `static widgetSave()` — extension points (base no-ops).

## Add one (sketch)

```php
// my_module/src/Plugin/MediaContextualCrop/MyCrop.php
namespace Drupal\my_module\Plugin\MediaContextualCrop;

use Drupal\media_contextual_crop\MediaContextualCropPluginBase;

/**
 * @MediaContextualCrop(
 *   id = "my_crop",
 *   title = @Translation("My crop"),
 *   target_field_name = "image_crop",
 *   image_style_effect = {"crop_crop", "my_crop_effect"}
 * )
 */
class MyCrop extends MediaContextualCropPluginBase {
  public function saveCrop($crop_settings, string $image_style_name, string $old_uri, string $context, int $width, int $height) {
    $crop = $this->retrieveContextualCrop($context, $crop_settings['crop_type'], $old_uri);
    // ...apply $crop_settings (position/anchor)...
    $crop->save();
    return $crop->id();
  }
  public function processEmbedData($embed_settings) { /* ... */ return []; }
}
```
