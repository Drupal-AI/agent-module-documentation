# API — evaluate groups & manage the entity in code

## Service: `block_visibility_groups.group_evaluator`

Class `Drupal\block_visibility_groups\GroupEvaluator` (implements `GroupEvaluatorInterface`),
constructed with `@context.handler` and `@context.repository`.

```php
$evaluator = \Drupal::service('block_visibility_groups.group_evaluator');
$group = \Drupal::entityTypeManager()
  ->getStorage('block_visibility_group')
  ->load('my_group');
$visible = $evaluator->evaluateGroup($group); // bool
```

`evaluateGroup(BlockVisibilityGroup $group)`:
- Returns TRUE when the group has no conditions.
- Applies runtime plugin contexts (`applyContexts`) to context-aware conditions; if a required
  context value is NULL it returns FALSE, and under `and` logic a context error on a non-negated
  condition also fails the group.
- Otherwise resolves the conditions with the group's `logic` via core's
  `ConditionAccessResolverTrait::resolveConditions()`. Results are memoized per group id.

## The `block_visibility_group` config entity

`Drupal\block_visibility_groups\Entity\BlockVisibilityGroup` (implements
`BlockVisibilityGroupInterface extends ConfigEntityInterface, EntityWithPluginCollectionInterface`).

Key methods:
- `getLogic()` / `setLogic('and'|'or')`
- `isAllowOtherConditions()` / `setAllowOtherConditions(bool)`
- `getConditions()` → `ConditionPluginCollection`
- `getCondition($condition_id)`
- `addCondition(array $configuration)` — assigns a uuid, returns it
- `removeCondition($condition_id)`
- `getCacheTags()` — includes `block_visibility_group:{id}` plus each condition's tags

Create one in code:

```php
use Drupal\block_visibility_groups\Entity\BlockVisibilityGroup;

$group = BlockVisibilityGroup::create([
  'id' => 'front_only',
  'label' => 'Front page only',
  'logic' => 'and',
  'allow_other_conditions' => FALSE,
]);
$group->save();
$group->addCondition([
  'id' => 'request_path',        // any core/contrib condition plugin id
  'pages' => '<front>',
  'negate' => FALSE,
]);
$group->save();
```

Conditions are stored under the `conditions` key and rehydrated through the core condition plugin
manager, so plugin ids from CTools or other contrib condition modules work the same way.
