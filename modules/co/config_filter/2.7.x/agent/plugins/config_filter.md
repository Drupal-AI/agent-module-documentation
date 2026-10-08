# Implement a ConfigFilter plugin

A `ConfigFilter` intercepts config storage operations on `config.storage.sync` (or another
named storage) during import/export, letting you rewrite, add, hide, or block config.

- Plugin namespace: `Plugin/ConfigFilter`
- Annotation: `Drupal\config_filter\Annotation\ConfigFilter` (`@ConfigFilter`; no Attribute class)
- Interface: `Drupal\config_filter\Plugin\ConfigFilterInterface` (extends `StorageFilterInterface`)
- Base class: `Drupal\config_filter\Plugin\ConfigFilterBase` (uses `TransparentStorageFilterTrait` — every filter method is a no-op pass-through by default; override only what you need)
- Manager service: `plugin.manager.config_filter`; alter hook: `config_filter_info`

```php
namespace Drupal\mymodule\Plugin\ConfigFilter;

use Drupal\config_filter\Plugin\ConfigFilterBase;

/**
 * @ConfigFilter(
 *   id = "mymodule_filter",
 *   label = @Translation("My config filter"),
 *   weight = 0,               // lower runs earlier; optional
 *   status = TRUE,            // inactive filters are skipped; optional
 *   storages = {"config.storage.sync"},  // optional, this is the default
 * )
 */
class MyFilter extends ConfigFilterBase {

  public function filterRead($name, $data) {
    // Alter data as it is read from the source storage (import direction).
    return $data;
  }

  public function filterWrite($name, array $data) {
    // Alter data before it is written (export direction). Return NULL to skip.
    return $data;
  }
}
```

Key `StorageFilterInterface` methods you can override: `filterRead`, `filterReadMultiple`,
`filterWrite` (return `NULL` to not write), `filterWriteEmptyIsDelete`, `filterExists`,
`filterDelete`, `filterDeleteAll`, `filterRename`, `filterListAll`, `filterCreateCollection`
(return a `clone $this` to act per collection), `filterGetAllCollectionNames`,
`filterGetCollectionName`.

- `setSourceStorage()` / `setFilteredStorage()` are called for you; use `getSourceStorage()`
  (read-only source) and `getFilteredStorage()` (post-filter view — beware recursion) inside a filter.
- Weight sorts the filter chain; `status = FALSE` disables without deleting the plugin.
- Rule: a well-behaved filter never writes during a read method.
