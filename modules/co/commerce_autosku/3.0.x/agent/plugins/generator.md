# Commerce AutoSKU — the `commerce_autosku_generator` plugin type

Define a custom SKU generator (e.g. sequential, hashed, prefixed) as a plugin.

- Manager: `plugin.manager.commerce_autosku_generator` (`\Drupal\commerce_autosku\CommerceAutoSkuGeneratorManager`).
- Subdirectory: `Plugin/CommerceAutoSkuGenerator`. Interface: `...\Plugin\CommerceAutoSkuGenerator\CommerceAutoSkuGeneratorInterface`. Base: `CommerceAutoSkuGeneratorBase`.
- Discovery: both the `#[CommerceAutoSkuGenerator]` attribute (`src/Attribute/`) and the `@CommerceAutoSkuGenerator` annotation (`src/Annotation/`) are supported.

## Contract
Implement `getSku(ProductVariationInterface $entity): string` (protected). The base class provides:
- `generate()` — calls `getSku()`, falls back to `getAlternativeSku()` if empty, then `makeUnique()` (strip tags/control chars, `_N` suffix on collision, 255-char cap).
- `defaultConfiguration()` / `getConfiguration()` / `setConfiguration()` and the `buildConfigurationForm()` / `validate` / `submit` config-form hooks (rendered via the `commerce_plugin_configuration` element on the settings form).
- `isUnique()` — checks the variation storage for an existing SKU.

## Example
```php
namespace Drupal\my_module\Plugin\CommerceAutoSkuGenerator;

use Drupal\commerce_autosku\Attribute\CommerceAutoSkuGenerator;
use Drupal\commerce_autosku\Plugin\CommerceAutoSkuGenerator\CommerceAutoSkuGeneratorBase;
use Drupal\commerce_product\Entity\ProductVariationInterface;
use Drupal\Core\StringTranslation\TranslatableMarkup;

#[CommerceAutoSkuGenerator(
  id: 'sequential',
  label: new TranslatableMarkup('Sequential'),
)]
final class Sequential extends CommerceAutoSkuGeneratorBase {
  protected function getSku(ProductVariationInterface $entity): string {
    return 'SKU-' . \Drupal::service('some.counter')->next();
  }
}
```

Reference implementation: `src/Plugin/CommerceAutoSkuGenerator/Token.php` (token pattern + `token_tree_link`, validates that the pattern contains at least one token). Your plugin id is what gets stored as `plugin` in the variation type's `commerce_autosku` third-party settings.
