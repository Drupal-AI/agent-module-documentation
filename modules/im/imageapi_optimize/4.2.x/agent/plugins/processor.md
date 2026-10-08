# Write a processor plugin

Processors are the pluggable optimization steps in a pipeline. This is the plugin type the
module defines.

- Plugin namespace: `Plugin/ImageAPIOptimizeProcessor`
- Annotation: `Drupal\imageapi_optimize\Annotation\ImageAPIOptimizeProcessor`
- Manager: `plugin.manager.imageapi_optimize.processor`
  (`ImageAPIOptimizeProcessorManager`)
- Interface: `ImageAPIOptimizeProcessorInterface`; base `ImageAPIOptimizeProcessorBase`.
- Configurable variants: `ConfigurableImageAPIOptimizeProcessorInterface` /
  `ConfigurableImageAPIOptimizeProcessorBase` (adds a settings form).

```php
namespace Drupal\mymodule\Plugin\ImageAPIOptimizeProcessor;

use Drupal\imageapi_optimize\ConfigurableImageAPIOptimizeProcessorBase;

/**
 * @ImageAPIOptimizeProcessor(
 *   id = "my_optimizer",
 *   label = @Translation("My optimizer"),
 *   description = @Translation("Recompresses images with my tool.")
 * )
 */
class MyOptimizer extends ConfigurableImageAPIOptimizeProcessorBase {

  public function applyToImage($image_uri) {
    // Optimize the file at $image_uri in place; return TRUE on success.
    return TRUE;
  }

  // Optionally override defaultConfiguration()/buildConfigurationForm()
  // /submitConfigurationForm() for per-processor settings (stored in the
  // pipeline's processors[].data).
}
```

After `drush cr`, the processor appears in the "Add processor" list on the pipeline edit
form. Concrete optimizers (reSmush.it, local binaries, etc.) are provided by companion
projects as examples.
