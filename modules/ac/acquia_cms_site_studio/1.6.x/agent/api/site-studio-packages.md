# Site Studio package import (CohesionFacade)

Each Acquia CMS content module ships its Site Studio config (components, styles, templates, thumbnails)
as a "package" and lists it in a per-module packages file. This module's facade collects those lists
across all installed modules and imports them through Cohesion's sync handler, so enabling a new
`acquia_cms_*` module makes its Site Studio package available for import/rebuild.

## The facade

`Drupal\acquia_cms_site_studio\Facade\CohesionFacade` — **class-resolved** (not a registered service),
marked `@internal`. Obtain it with `\Drupal::classResolver(CohesionFacade::class)`. Constructor
dependencies: `cohesion_sync.packager`, `module_handler`, `uuid`, `cohesion_sync.package_import_handler`.

| Method | Signature | Behavior |
|---|---|---|
| `importSiteStudioPackages` | `(array $package_list = []): bool` | If `$package_list` is empty, builds it from all installed modules (`acquia_cms_site_studio` first, then other `acquia_cms_*` last), then imports via `cohesion_sync.package_import_handler::importPackagesFromArray()`. Returns FALSE if nothing to import. |
| `buildPackageList` | `(array $modules): array` | Merges each module's package list read from `<module>/config/site_studio/*.packages.yml` (path from the `COHESION_SYNC_DEFAULT_MODULE_PACKAGES` constant, defined by `cohesion_sync`). |
| `readPackageList` | `(string $path): array` | `Yaml::parse()` of one packages file; throws `PackageListEmptyOrMissing` if the file exists but parses to NULL. |
| `batchFinishedCallback` | `static (bool, array, array)` | Batch "finished" messenger callback. |

`getSortedModules()` (private) guarantees `acquia_cms_site_studio` is imported before the other
`acquia_cms_*` modules so base styles/templates exist before dependent packages load.

## Declaring a package for a module

Add `config/site_studio/<name>.packages.yml` to your module listing each package directory:

```yaml
-
  type: default_module_package
  source:
    module_name: my_module
    path: config/my_module_package
    dependencies:
      - acquia_cms_search   # optional: only import when these modules are enabled
  options:
    extra-validation: false
```

The referenced `path` directory holds the exported Cohesion config `*.yml` plus a
`sitestudio_package_files.json` manifest and the asset files (e.g. component thumbnail `*.png`). This
module's own package lives in `config/pack_acquia_cms_core` and is declared in
`config/site_studio/site_studio.packages.yml` (which also references the packages of the other
`acquia_cms_*` modules, each guarded by a `dependencies` list).

## Import from code

```php
/** @var \Drupal\acquia_cms_site_studio\Facade\CohesionFacade $facade */
$facade = \Drupal::classResolver(\Drupal\acquia_cms_site_studio\Facade\CohesionFacade::class);
$facade->importSiteStudioPackages();   // import every installed module's packages
```

This is what the install/rebuild flow calls (`_acquia_cms_site_studio_import_ui_kit`). It is skipped when
the `COHESION_ARTIFACT` environment variable is set (CI swaps in a pre-built Cohesion templates dir
instead of running the slow import).
