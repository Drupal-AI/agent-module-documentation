# Substitution plugins

A substitution decides which URL an entity reference resolves to when the Linkit filter
rewrites `entity:{type}/{id}`. Plugin type defined by `SubstitutionManager` (service
`plugin.manager.linkit.substitution`), namespace `Plugin/Linkit/Substitution`, alter hook
`linkit_substitution`.

- **Interface:** `Drupal\linkit\SubstitutionInterface`.
- **Attribute:** `#[Substitution(id, label)]` (annotation `@Substitution` also supported).
- Bundled: `Canonical` (entity page — default), `File` (direct file URL), `Media`
  (media source URL).

## Implement
```php
namespace Drupal\my_module\Plugin\Linkit\Substitution;

use Drupal\Core\Entity\EntityInterface;
use Drupal\Core\Entity\EntityTypeInterface;
use Drupal\Core\StringTranslation\TranslatableMarkup;
use Drupal\linkit\Attribute\Substitution;
use Drupal\Core\Plugin\PluginBase;
use Drupal\linkit\SubstitutionInterface;

#[Substitution(id: 'my_sub', label: new TranslatableMarkup('My sub'))]
class MySub extends PluginBase implements SubstitutionInterface {
  public function getUrl(EntityInterface $entity) { return $entity->toUrl(); }
  public static function isApplicable(EntityTypeInterface $entity_type) {
    return $entity_type->hasLinkTemplate('canonical');
  }
}
```

`getUrl()` returns the `Url` to substitute; `isApplicable()` (static) gates which entity types
the plugin is offered for. `SubstitutionManagerInterface::getApplicablePluginsOptionList($entity_type_id)`
returns the choices shown in a matcher's settings.
