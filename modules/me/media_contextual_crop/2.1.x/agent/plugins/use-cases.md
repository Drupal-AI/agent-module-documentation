# Use-case (context) plugins (`@MediaContextualCropUseCase`)

Adapters that answer "does *this* rendered image carry a contextual crop, and what is it?" —
one per *place* a contextual crop can come from (a CKEditor media embed, a media/entity
reference field). Shipped by companion projects (`media_contextual_crop_embed`,
`media_contextual_crop_field_formatter`); this module defines only the type.

- Manager service: `plugin.manager.media_contextual_crop_use_case` → `MediaContextualCropUseCasePluginManager` (also injected with `media_contextual_crop.service`)
- Discovery dir: `src/Plugin/MediaContextualCropUseCase/`
- Annotation: `@MediaContextualCropUseCase` (props: `id`, `title` only)
- Interface: `MediaContextualCropUseCaseInterface`; base: `MediaContextualCropUseCasePluginBase`
- Alter hook: `hook_media_contextual_crop_use_case_info(&$definitions)`; cache key `media_contextual_crop_use_case_plugins`

## How it is used

Every image the preprocess hooks (see [hooks/preprocess.md](../hooks/preprocess.md)) and the
`image_contextual_url` formatter (see [fields/formatters.md](../fields/formatters.md)) touch is
run through:

```php
$plugin = $manager->findCompetent($imageItem); // first plugin whose isCompetent() is TRUE, else NULL
```

`findCompetent(ImageItem $item)` instantiates every use-case plugin and returns the first whose
`isCompetent()` matches; NULL means "no contextual crop here, render normally".

## Interface contract

| Method | Purpose |
|---|---|
| `isCompetent(ImageItem $item): bool` | Does this plugin own this image item? (base returns FALSE) |
| `getCropSettings(ImageItem $item): array\|null` | Extract the crop settings (incl. `plugin_id`/`crop_setting`/`context`) from the item, or NULL |
| `getContextualizedImage($crop_settings, $old_uri, $image_style): string` | Return the contextual derivative URL/URI |

`MediaContextualCropUseCasePluginBase` (injects `plugin.manager.media_contextual_crop` as
`$mccPluginManager` and `media_contextual_crop.service` as `$mccService`) implements
`getContextualizedImage()` for you: it builds `$old_image` (`#uri/#width/#height` from the
item values) and delegates to `MediaContextualCropService::generateContextualizedImage()`
(see [api/services.md](../api/services.md)). A subclass normally only implements `isCompetent()`
and `getCropSettings()`.

## Add one (sketch)

```php
// my_module/src/Plugin/MediaContextualCropUseCase/MyContext.php
namespace Drupal\my_module\Plugin\MediaContextualCropUseCase;

use Drupal\media_contextual_crop\MediaContextualCropUseCasePluginBase;
use Drupal\image\Plugin\Field\FieldType\ImageItem;

/**
 * @MediaContextualCropUseCase(
 *   id = "my_context",
 *   title = @Translation("My context")
 * )
 */
class MyContext extends MediaContextualCropUseCasePluginBase {
  public function isCompetent(ImageItem $item) { return isset($item->getValue()['my_crop_data']); }
  public function getCropSettings(ImageItem $item) {
    return [
      'plugin_id'    => 'my_crop',              // a @MediaContextualCrop id
      'crop_setting' => /* widget data */ [],
      'context'      => $this->mccService->getBaseContext($item->getEntity(), $item->getFieldDefinition()->getName()),
    ];
  }
}
```
