# Programmatic API — manager, assigner, generator

Services are declared in `features.services.yml`.

## `features.manager` — `FeaturesManager`

The core service (`Drupal\features\FeaturesManagerInterface`). Builds the config collection,
initializes packages, and detects drift.

```php
/** @var \Drupal\features\FeaturesManagerInterface $manager */
$manager = \Drupal::service('features.manager');

$config    = $manager->getConfigCollection();          // all ConfigurationItem objects
$packages  = $manager->getPackages();                  // machine_name => Package
$package   = $manager->loadPackage('my_feature', TRUE);

$overrides = $manager->detectOverrides($package);      // active config != exported code
$missing   = $manager->detectMissing($package);        // in code but not installed
$new       = $manager->detectNew($package);

$manager->assignConfigPackage('my_feature', ['node.type.article']);
$manager->createConfiguration(['node.type.article' => '']);  // import/revert
$manager->import($modules);
```

Other useful methods: `getExportSettings()`, `getExportInfo($package, $bundle)`,
`isFeatureModule($extension)`, `filterPackages($packages, $namespace)`,
`initPackage(...)`, `getFeaturesModules($bundle, $installed)`, `statusLabel()`/`stateLabel()`.
Status/state constants (e.g. `STATUS_INSTALLED`, `STATUS_NO_EXPORT`, `STATE_OVERRIDDEN`,
`STATE_DEFAULT`) live on `FeaturesManagerInterface`.

## `features_assigner` — `FeaturesAssigner`

Runs the assignment-method pipeline and manages the active bundle.

```php
/** @var \Drupal\features\FeaturesAssignerInterface $assigner */
$assigner = \Drupal::service('features_assigner');
$assigner->assignConfigPackages();          // run all enabled assignment methods
$bundle = $assigner->applyBundle('acme');   // select a features_bundle
$bundle = $assigner->getBundle();
$methods = $assigner->getEnabledAssigners();
```

## `features_generator` — `FeaturesGenerator`

Runs a generation method to write/export packages.

```php
use Drupal\features\Plugin\FeaturesGeneration\FeaturesGenerationWrite;

/** @var \Drupal\features\FeaturesGeneratorInterface $generator */
$generator = \Drupal::service('features_generator');
$result = $generator->generatePackages(
  FeaturesGenerationWrite::METHOD_ID,   // 'write' (or FeaturesGenerationArchive::METHOD_ID = 'archive')
  $assigner->getBundle(),
  ['my_feature']
);
```

## Supporting services

- `plugin.manager.features_assignment_method`, `plugin.manager.features_generation_method` — plugin managers.
- `features.config_update` — `config_update`'s `ConfigReverter` (diff/revert engine Features builds on).
- `features.extension_storage` / `features.extension_optional_storage` — `FeaturesInstallStorage`
  reading feature modules' `config/install` and `config/optional`.
- `logger.channel.features` — the `features` log channel.
