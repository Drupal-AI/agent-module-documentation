# Vitals — the `vitals_check` plugin type

Add a health metric to the endpoint by defining a `vitals_check` plugin.

- Manager service: `plugin.manager.vitals_check` (`\Drupal\vitals\VitalsCheckPluginManager`, extends `DefaultPluginManager`).
- Subdirectory: `Plugin/VitalsCheck`. Interface: `\Drupal\vitals\VitalsCheckInterface`. Base: `\Drupal\vitals\VitalsCheckPluginBase`.
- Annotation: `\Drupal\vitals\Annotation\VitalsCheck` (`@Annotation`) with `id`, `label`, `description`. (Annotation-based only; no PHP attribute is provided.)
- Alter hook: `hook_vitals_check_info(&$definitions)`. Cache: `vitals_check_plugins` in `cache.discovery`.

## Interface
```php
interface VitalsCheckInterface {
  public function label();      // provided by VitalsCheckPluginBase (casts label to string)
  public function getData();    // return the data to expose (any JSON-serializable value)
}
```

## Example
```php
namespace Drupal\my_module\Plugin\VitalsCheck;

use Drupal\vitals\VitalsCheckPluginBase;

/**
 * @VitalsCheck(
 *   id = "queue_depth",
 *   label = @Translation("Queue depth"),
 *   description = @Translation("Number of items in the default queue.")
 * )
 */
class QueueDepth extends VitalsCheckPluginBase {
  public function getData() {
    return \Drupal::queue('my_worker')->numberOfItems();
  }
}
```

Notes:
- Only checks listed (and equal-valued) in `vitals.settings:vitals_enabled_plugins` are run; enable yours on the settings form after clearing caches.
- `Vitals::getStatus()` calls `createInstance($id)->getData()` per enabled id and keys the JSON payload by plugin id.
- Built-in plugins live in `src/Plugin/VitalsCheck/` (`CmsVersion`, `PhpVersion`, `Themes`, `Updates`) — copy their shape.
