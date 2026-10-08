# Plugin type: `IbDamAssetValidation`

The parent defines one plugin type used to validate assets before they are saved.

- **Annotation:** `Drupal\ib_dam\Annotation\IbDamAssetValidation` (`@IbDamAssetValidation`) — keys
  `id`, `label`, optional `data_type`, `asset_types`, `constraint`.
- **Manager service:** `plugin.manager.ib_dam.asset_validation`
  (`Drupal\ib_dam\AssetValidation\AssetValidationManager`, a `default_plugin_manager`).
- **Discovery namespace:** `Drupal\<module>\Plugin\IbDam\AssetValidation`.
- **Base class:** `Drupal\ib_dam\AssetValidation\AssetValidationBase` (injects `typed_data_manager`).
- **Interface / trait:** `AssetValidationInterface`; `AssetValidationTrait` is what callers (e.g. the
  browser form) mix in — it runs a list of validators against a list of assets and records form errors,
  aggregating messages via `AssetViolationAggregator`.

A validator plugin exposes one or more `validateXxx(AssetInterface $asset, ...)` methods; each returns
an array of error message strings (empty = valid). Which methods run is chosen by the caller and by the
asset's `getApplicableValidators()`.

## Built-in plugins (`src/Plugin/IbDam/AssetValidation/`)

| id | Class | Methods | Purpose |
|---|---|---|---|
| `file` | `File` | `validateFileExtensions($asset, $extensions)`, `validateFileDirectory($asset, $file_dir)` | Extension allowlist (via core `file.validator` `FileExtension`) and destination-scheme/dir check for downloaded **local** files. |
| `resource` | `Resource` | `validateIsAllowedResourceType($asset, ['type','allowed'])` | Blocks an `embed` asset when embedding is not allowed for the target. |
| `api` | `Api` | `validateApiAuthKey($asset)` | Placeholder — currently returns no errors. |

## Add your own validator

```php
namespace Drupal\my_module\Plugin\IbDam\AssetValidation;

use Drupal\ib_dam\Asset\AssetInterface;
use Drupal\ib_dam\AssetValidation\AssetValidationBase;

/**
 * @IbDamAssetValidation(
 *   id = "my_check",
 *   label = @Translation("My check")
 * )
 */
class MyCheck extends AssetValidationBase {
  public function validateSomething(AssetInterface $asset, $option): array {
    return $ok ? [] : [$this->t('Not allowed.')];
  }
}
```

Then reference the plugin id + method name in the validator spec passed to `AssetValidationTrait::validateAssets()`.
