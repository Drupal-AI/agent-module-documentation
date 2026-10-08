# Synonyms runtime API

Two services do the work; call them from custom code instead of touching provider plugins directly.

## `synonyms.provider_service` (`ProviderService`)

Constructed with `entity_type.manager` + `entity_type.bundle.info`.

| Method | Signature | Returns / does |
|---|---|---|
| `getEntitySynonyms` | `(ContentEntityInterface $entity)` | `string[]` — all synonyms of one entity, merged & de-duped across its enabled provider configs. |
| `getSynonymConfigEntities` | `($entity_type, $bundle)` | `Synonym[]` — provider config entities matching that type and bundle (`$bundle` may be a string, array, or NULL for any). |
| `findSynonyms` | `(Condition $condition, EntityTypeInterface $entity_type, $bundle = NULL)` | array of `{synonym, entity_id}` — runs each matching provider's `synonymsFind()`. Use `FindInterface::COLUMN_*` placeholders in `$condition`. |
| `getBySynonym` | `(EntityTypeInterface $entity_type, string $name, $bundle = NULL)` | `int[]` entity IDs whose **label OR** a synonym equals `$name` (label lookup uses `accessCheck(TRUE)`; `user` is special-cased to the `name` column). |
| `serviceIsEnabled` | `($entity_type, $bundle, $service_id)` | `bool` — reads `synonyms_<service_id>.behavior.<entity_type>.<bundle>` config `status`. |

Example — resolve a user-typed alias to term IDs:

```php
$ps = \Drupal::service('synonyms.provider_service');
$etm = \Drupal::entityTypeManager();
$ids = $ps->getBySynonym($etm->getDefinition('taxonomy_term'), 'USA', 'countries');
```

Exact-match find with a placeholder condition:

```php
use Drupal\Core\Database\Query\Condition;
use Drupal\synonyms\ProviderInterface\FindInterface;

$condition = new Condition('AND');
$condition->condition(FindInterface::COLUMN_SYNONYM_PLACEHOLDER, 'United States');
$rows = $ps->findSynonyms($condition, $etm->getDefinition('taxonomy_term'), 'countries');
// each $row->synonym, $row->entity_id
```

## `synonyms.behavior_service` (`BehaviorService`)

A `service_collector` that gathers every service tagged `synonyms_behavior` (via `addBehaviorService()`
during container compilation). Behaviors implement `BehaviorInterface` (`getId()`, `getTitle()`);
widget-capable ones also implement `WidgetInterface` (`getWidgetTitle()`).

| Method | Returns |
|---|---|
| `getBehaviorServices()` | assoc array `behavior_id => service` of all behaviors. |
| `getWidgetServices()` | subset that also implement `WidgetInterface` (autocomplete, select). |

## Registering your own behavior

```yaml
# my_module.services.yml
services:
  my_module.behavior.foo:
    class: Drupal\my_module\Behavior\FooService
    tags:
      - { name: synonyms_behavior }
```

The class must implement `Drupal\synonyms\BehaviorInterface\BehaviorInterface` (and optionally
`WidgetInterface`). It then appears on the *Manage behaviors* form and can be toggled per
entity-type/bundle, checked with `serviceIsEnabled()`.
