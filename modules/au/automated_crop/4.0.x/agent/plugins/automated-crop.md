# Plugin type — `AutomatedCrop`

Implement a custom automatic cropping strategy (how the crop box is sized and positioned).

## Plugin machinery

| Piece | Value |
|---|---|
| Manager service | `plugin.manager.automated_crop` (`AutomatedCropManager`, extends `DefaultPluginManager`, implements `FallbackPluginManagerInterface`) |
| Subdirectory | `Plugin/AutomatedCrop` |
| Annotation | `@AutomatedCrop` (`id`, `label`, `description`) — annotation-based, not attribute-based |
| Interface | `Drupal\automated_crop\AutomatedCropInterface` |
| Base class | `Drupal\automated_crop\AbstractAutomatedCrop` |
| Fallback id | `automated_crop_default` (returned by `getFallbackPluginId()` for unknown ids) |
| Cache | `automated_crop_plugins`; alter hook `hook_automated_crop_info_alter()` |

`AutomatedCropManager::getProviderOptionsList()` returns `id => label` for all plugins — this is
what the image-effect provider select and the Crop-API provider registration use.

## Minimal implementation

Extend `AbstractAutomatedCrop` and implement the two abstract methods:

```php
namespace Drupal\my_module\Plugin\AutomatedCrop;

use Drupal\automated_crop\AbstractAutomatedCrop;

/**
 * @AutomatedCrop(
 *   id = "my_rule_of_thirds",
 *   label = @Translation("Rule of thirds"),
 *   description = @Translation("Positions the crop on a thirds intersection."),
 * )
 */
final class MyRuleOfThirds extends AbstractAutomatedCrop {

  public function calculateCropBoxSize() {
    // Set $this->cropBox['width'] / ['height'] then:
    $this->setCropBoxSize($this->cropBox['width'], $this->cropBox['height']);
    return $this;
  }

  public function calculateCropBoxCoordinates() {
    // Set $this->cropBox['x'] / ['y'] (top-left of the crop area).
    return $this;
  }
}
```

## What the base class gives you

`AbstractAutomatedCrop` handles the plumbing: `initCropBox()`, `setOriginalSize()`,
`setAspectRatio()` (parses `W:H` or a float; falls back to the image ratio when `NaN`), `setDelta()`,
`setMaxSizes()`, `setCropBoxSize()`, `anchor()`, `size()`, `setAutoCropArea()`, `hasHardSizes()`,
`getConfiguration()`/`setConfiguration()`. Your subclass only decides the **size** and **position**
of the crop box via the two abstract methods.

Configuration passed to `createInstance()` includes `image`, `min_width`, `min_height`,
`aspect_ratio` (see the event flow in [api/mechanism.md](../api/mechanism.md)).

## Registration is automatic

Any `@AutomatedCrop` plugin you add is picked up by the manager and, through the
`AutomatedCropProvider` subscriber, registered as a Crop-API automatic-crop provider — so it becomes
selectable as the effect's `automatic_crop_provider` with no extra wiring.
