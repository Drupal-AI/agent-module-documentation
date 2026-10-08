# CropEntityProvider plugins

Entity provider plugins tell Crop API how to resolve the **image file URI** for a given entity
type, so crops can be attached to it. Core ships two: `file` and `media`.

- Plugin namespace: `Plugin/Crop/EntityProvider`
- Annotation: `Drupal\crop\Annotation\CropEntityProvider` (`entity_type`, `label`, `description`)
- Interface: `Drupal\crop\EntityProviderInterface` — implement `uri(EntityInterface $entity): string|false`
- Base class: `Drupal\crop\EntityProviderBase`
- Manager service: `plugin.manager.crop.entity_provider` (`Drupal\crop\EntityProviderManager`)
- Alter hook: `hook_crop_entity_provider_info_alter()`

The plugin **id** is the `entity_type` it supports; `Crop::provider()` looks the plugin up by
the crop's `entity_type` field.

```php
namespace Drupal\mymodule\Plugin\Crop\EntityProvider;

use Drupal\Core\Entity\EntityInterface;
use Drupal\crop\EntityProviderBase;

/**
 * @CropEntityProvider(
 *   entity_type = "my_entity",
 *   label = @Translation("My entity"),
 *   description = @Translation("Crop integration for my entity.")
 * )
 */
class MyEntity extends EntityProviderBase {
  public function uri(EntityInterface $entity) {
    return $entity->get('field_image')->entity->getFileUri();
  }
}
```

Core `File::uri()` returns `$entity->getFileUri()`; `Media` resolves the configured source
image field. After adding a plugin, rebuild caches so the manager (cache id
`crop_entity_provider_plugins`) discovers it.
