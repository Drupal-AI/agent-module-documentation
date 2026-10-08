# Implement a synonyms provider plugin

Plugin type **`synonyms_provider`** — how the module learns to *get* an entity's synonyms and to
*find* entities by a synonym.

- Manager service: `plugin.manager.synonyms_provider` (`ProviderPluginManager`, extends `DefaultPluginManager`).
- Discovery dir: `src/Plugin/Synonyms/Provider/`.
- Annotation: `@Provider` (`Drupal\synonyms\Annotation\Provider`). Alter hook: `synonyms_provider_info`.
- Base interface: `ProviderInterface` (empty marker). Start from `AbstractProvider`.

## Annotation fields (`@Provider`)

| Field | Meaning |
|---|---|
| `id` | Plugin/derivative id. |
| `label` | Human name (also used as the Synonym config entity's `label()`). |
| `controlled_entity_type` | Entity type this instance supplies synonyms for. |
| `controlled_bundle` | Bundle (use the entity-type id when the type has no bundles). |
| `field` | Field the synonyms are read from. |
| `deriver` | Optional deriver class (the shipped `field` provider uses one to emit one instance per eligible field). |

## Interfaces / traits (in `src/ProviderInterface/`)

Implement the two capabilities; `AbstractProvider` already `use`s the traits and implements the rest:

- **`GetInterface`** — `getSynonyms(ContentEntityInterface $entity): string[]` and
  `getSynonymsMultiple(array $entities): array` (keyed by entity id). `GetTrait` gives a default
  multiple impl looping `getSynonyms()`.
- **`FindInterface`** — `synonymsFind(ConditionInterface $condition): \Traversable`. Return objects
  with `synonym` (string) and `entity_id` (int). The `$condition` carries two placeholders you must
  swap for your real columns: `FindInterface::COLUMN_SYNONYM_PLACEHOLDER` and
  `FindInterface::COLUMN_ENTITY_ID_PLACEHOLDER`. Use `FindTrait::synonymsFindProcessCondition($condition,
  $synonym_column, $entity_id_column)` to do the substitution for you.
- **`ConfigurationInterface`** (`ConfigurationTrait`) — provider config (holds `wording`).
- **`FormatWordingInterface`** (`FormatWordingTrait`) — `synonymFormatWording($synonym, $entity, $config, $behavior)`
  renders the user-facing wording.

## Skeleton

```php
namespace Drupal\my_module\Plugin\Synonyms\Provider;

use Drupal\Core\Database\Query\ConditionInterface;
use Drupal\Core\Entity\ContentEntityInterface;
use Drupal\synonyms\Plugin\Synonyms\Provider\AbstractProvider;

/**
 * @Provider(
 *   id = "my_provider",
 *   label = @Translation("My synonyms"),
 *   controlled_entity_type = "node",
 *   controlled_bundle = "article",
 *   field = "field_aka"
 * )
 */
class MyProvider extends AbstractProvider {

  public function getSynonyms(ContentEntityInterface $entity) {
    $out = [];
    foreach ($entity->get('field_aka') as $item) {
      if (!$item->isEmpty()) { $out[] = $item->value; }
    }
    return $out;
  }

  public function synonymsFind(ConditionInterface $condition) {
    // Build a DB/entity query against your synonym storage, then:
    $this->synonymsFindProcessCondition($condition, 'field_aka_value', 'entity_id');
    // ...apply $condition, return a Traversable of {synonym, entity_id} rows.
  }
}
```

## Reference: the shipped `field` provider

`Plugin/Synonyms/Provider/Field` (deriver `Plugin/Derivative/Field`) reads `getSynonyms()` straight
from the mapped field property (`FieldTypeToSynonyms::getSimpleFieldTypeToPropertyMap()`), and
implements `synonymsFind()` by running an entity query, extracting its compiled SQL
(`FieldQuery::getSqlQuery()`), and aliasing the field/id columns to `synonym`/`entity_id`. All queries
call `accessCheck(TRUE)`. `EntityReferenceField` is the analogous provider for reference fields; both
declare config dependencies on the underlying field via `calculateDependencies()`.
