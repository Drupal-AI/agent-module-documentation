# AssetValidation plugin type

`ib_dam` defines one plugin type used to validate assets before they are imported/embedded.

- **Manager service:** `plugin.manager.ib_dam.asset_validation`
  (`Drupal\ib_dam\AssetValidation\AssetValidationManager`, extends `DefaultPluginManager`).
- **Discovery:** classes in any module's `src/Plugin/IbDam/AssetValidation/`.
- **Annotation:** `@IbDamAssetValidation` (`src/Annotation/IbDamAssetValidation.php`) with:
  `id`, `label`, and optional `data_type`, `asset_types` (asset types the plugin applies to),
  `constraint` (a Symfony constraint id).
- **Interface / base:** implement `AssetValidationInterface` (extends `PluginInspectionInterface`,
  `ConfigurableInterface`); extend `AssetValidationBase`. Core contract:
  `label()` and `validate(array $assets, array $options = [], bool $use_asset_validators = TRUE)`
  returning a Symfony `ConstraintViolationListInterface` (empty = valid).
- **Alter hook:** `hook_ib_dam_asset_validation_info_alter()`; cache key
  `ib_dam_asset_validation_plugins`.
- **Instantiate:** `$manager->getInstance(['id' => 'file', ...])` (wraps `createInstance`; a bad
  id throws `AssetValidationBadPluginId`).

## Built-in plugins (`src/Plugin/IbDam/AssetValidation/`)

| id | Class | Validates |
|---|---|---|
| `file` | `File` | Local file assets — file extension (`FileExtension` via `file.validator`) and destination directory/scheme. |
| `resource` | `Resource` | Whether an asset's source type is an allowed/available resource type. |
| `api` | `Api` | API-level asset checks. |

Validation helper methods live in `AssetValidationTrait` / `AssetViolationAggregator`.

## Implementing one

```php
namespace Drupal\my_module\Plugin\IbDam\AssetValidation;

use Drupal\ib_dam\AssetValidation\AssetValidationBase;

/**
 * @IbDamAssetValidation(
 *   id = "my_check",
 *   label = @Translation("My asset check"),
 *   asset_types = {"embed"}
 * )
 */
class MyCheck extends AssetValidationBase {
  // Add validate* helper methods; AssetValidationBase::validate() aggregates them
  // into a ConstraintViolationList. Return [] / no violations when the asset is valid.
}
```
