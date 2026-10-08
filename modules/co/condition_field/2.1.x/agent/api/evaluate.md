<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Reading & evaluating stored conditions

Condition Field **stores** conditions but never evaluates them. To act on them you read the field,
rebuild the condition plugin instances, and resolve them.

## Resolver helper

`Drupal\condition_field\ConditionAccessResolver` (uses core `ConditionAccessResolverTrait`):

```php
ConditionAccessResolver::checkAccess(array $conditions, string $condition_logic): bool
```

- `$conditions` — an array of instantiated `ConditionInterface` objects.
- `$condition_logic` — `'and'` (all must pass) or `'or'` (any passes).
- Returns TRUE/FALSE.

## Typical evaluation (from the module README), e.g. in `hook_entity_view`

```php
use Drupal\condition_field\ConditionAccessResolver;

function mymodule_entity_view(array &$build, $entity, $display, $view_mode) {
  if ($entity->get('field_conditions')->isEmpty()) {
    return; // no conditions set -> show
  }
  $conditions_config = $entity->get('field_conditions')->getValue()[0]['conditions'];
  $manager = \Drupal::service('plugin.manager.condition');
  $conditions = [];
  foreach ($conditions_config as $condition_id => $values) {
    $conditions[] = $manager->createInstance($condition_id, $values);
  }
  if (!ConditionAccessResolver::checkAccess($conditions, 'or')) {
    $build = []; // hide the entity build
  }
}
```

Notes:
- The stored value lives at `->getValue()[0]['conditions']` (single-value field), keyed by
  condition plugin id.
- Context-aware conditions may need contexts applied (see core `ConditionAccessResolverTrait` /
  `ContextHandler`) before evaluation; the module's example resolves them directly.
- The class comments and README mark this as a starting point ("@todo do more conditions related
  work") — the evaluation policy (which entities, which logic, context mapping) is up to your code.

## TypedData

`ConditionFieldData` (extends `TypedData`) is the property class backing the `conditions` map value.
No plugin types, hooks, services beyond the autowired `ConditionFieldHooks` (help text), permissions,
or Drush are provided.
