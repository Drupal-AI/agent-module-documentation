# Relationship plugin type

CTools defines the **Relationship** plugin type: given a "base" context, it derives a related
context (e.g. from a node context → its author user context, or its language).

- Manager service: `plugin.manager.ctools.relationship` (`Plugin\RelationshipManager`).
- Annotation: `@Relationship` (`src/Annotation/Relationship.php`) with keys `id`, `label`,
  `data_type`, `property_name`, `context`.
- Discovery dir: `Plugin/Relationship/` in any module.
- Built-ins (via derivers): `typed_data_relationship`, `typed_data_entity_relationship`,
  `typed_data_language_relationship` — one plugin instance per typed-data property, produced
  by `Plugin\Deriver\*RelationshipDeriver`.

Implement one:

```php
namespace Drupal\my_module\Plugin\Relationship;

use Drupal\ctools\Plugin\RelationshipBase;
use Drupal\Core\Plugin\Context\Context;

/**
 * @Relationship(
 *   id = "my_relationship",
 *   label = @Translation("My relationship"),
 *   data_type = "entity:user",
 *   context = { "base" = @ContextDefinition("entity:node") }
 * )
 */
class MyRelationship extends RelationshipBase {
  public function getRelationship() {
    $node = $this->getContext('base')->getContextValue();
    return new Context($this->getPluginDefinition()['data_type'], $node->getOwner());
  }
}
```

Consume: `\Drupal::service('plugin.manager.ctools.relationship')->getDefinitionsForContexts($contexts)`
to list relationships available for a set of contexts (used by Panels/Page Manager UIs).
