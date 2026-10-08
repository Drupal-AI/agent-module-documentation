# Plugin types — assignment & generation methods

Features defines two annotation-based plugin types (legacy `@Plugin` annotations, discovered
under each module's `src/Plugin/...`).

## Assignment methods — `features_assignment_method`

- Manager: `plugin.manager.features_assignment_method`
  (`Drupal\features\FeaturesAssignmentMethodManager`).
- Directory / namespace: `Plugin/FeaturesAssignment` (`Drupal\features\Plugin\FeaturesAssignment`).
- Interface: `Drupal\features\FeaturesAssignmentMethodInterface`; base class
  `FeaturesAssignmentMethodBase`.
- Alter hook: `hook_features_assignment_info_alter()`. Cache key `features_assignment_methods`.

An assignment method decides **which configuration goes into which package**. Built-ins (id):
`base`, `core`, `site`, `profile`, `alter`, `exclude`, `existing`, `namespace`, `packages`,
`dependency`, `forward_dependency`, `optional`. They run in `weight` order (see the bundle's
`assignments`).

```php
namespace Drupal\mymodule\Plugin\FeaturesAssignment;

use Drupal\features\FeaturesAssignmentMethodBase;

/**
 * @Plugin(
 *   id = "my_method",
 *   weight = 0,
 *   name = @Translation("My method"),
 *   description = @Translation("Assigns my config to packages."),
 *   config_route_name = "",
 *   default_settings = {}
 * )
 */
class FeaturesAssignmentMy extends FeaturesAssignmentMethodBase {
  public function assignPackages($force = FALSE) {
    // Use $this->featuresManager and $this->assigner to read the config
    // collection and call $this->featuresManager->assignConfigPackage(...).
  }
}
```

The base class injects `featuresManager`, `assigner`, `entityTypeManager`, `configFactory`.
`config_route_name` (optional) points to a settings form under the bundle UI;
`default_settings` seeds the method's bundle settings.

## Generation methods — `features_generation_method`

- Manager: `plugin.manager.features_generation_method`
  (`Drupal\features\FeaturesGenerationMethodManager`).
- Directory / namespace: `Plugin/FeaturesGeneration` (`Drupal\features\Plugin\FeaturesGeneration`).
- Interface: `Drupal\features\FeaturesGenerationMethodInterface`; base class
  `FeaturesGenerationMethodBase`.
- Alter hook: `hook_features_generation_info_alter()`. Cache key `features_generation_methods`.

A generation method **writes packages out**. Built-ins: `write` (`FeaturesGenerationWrite`,
writes modules to the filesystem — used by `drush features:export`) and `archive`
(`FeaturesGenerationArchive`, produces a downloadable tar). Implement `generate()` /
`exportFormSubmit()`; invoked via `$features_generator->generatePackages($method_id, $bundle, $package_names)`.
