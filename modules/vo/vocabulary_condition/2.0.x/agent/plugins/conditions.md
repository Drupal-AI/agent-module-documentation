<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Condition plugins

The module ships two plugins for core's `condition` plugin type (annotation replaced by the PHP
`#[Condition]` attribute). Both extend the shared `VocabularyConditionBase` and differ only in the
required context and in which term(s) they check.

| id | class | label | context definition |
|----|-------|-------|--------------------|
| `vocabulary` | `Plugin/Condition/VocabularyCondition` | "Vocabulary or term" | `taxonomy_term` → `entity:taxonomy_term` |
| `vocabulary_node` | `Plugin/Condition/VocabularyNodeCondition` | "Content tagged with vocabulary" | `node` → `entity:node` |

Base class: `Drupal\vocabulary_condition\Plugin\Condition\VocabularyConditionBase`
(extends `Drupal\Core\Condition\ConditionPluginBase`, implements `ContainerFactoryPluginInterface`).
It injects `entity_type.manager` and holds all shared logic; the two subclasses only implement
`evaluate()`.

## Configuration each plugin stores

`defaultConfiguration()` adds three keys to the standard condition config (`id`, `negate`,
`context_mapping`):

- `bundles` — array of taxonomy vocabulary machine names (default `[]`).
- `terms` — array of integer term ids (default `[]`).
- `include_descendants` — bool (default `FALSE`).

See [configure/conditions.md](../configure/conditions.md) for the form and schema.

## How a term is matched — `matchesTerm(TermInterface $term)`

Shared by both plugins. Returns TRUE when any of these hold (evaluated in order):

1. The term's bundle is in `bundles` (`$this->configuration['bundles'][$term->bundle()]` is set).
2. The term id is in `terms`.
3. `include_descendants` is TRUE **and** any of the term's ancestors (from
   `TermStorage::loadAllParents($term->id())`) is in `terms`.

With `terms` empty, only rule 1 can match. Every inspected term (and, for rule 3, every ancestor)
has its cache tags merged into `$inspectedTermTags`.

## evaluate()

- `vocabulary` (`VocabularyCondition::evaluate`): if `hasRestrictions()` is FALSE and the condition
  is not negated, returns TRUE (no restriction). Otherwise reads the `taxonomy_term` context and
  returns `matchesTerm($term)`. Meant for taxonomy term pages.
- `vocabulary_node` (`VocabularyNodeCondition::evaluate`): same empty-restriction short-circuit, then
  reads the `node` context, collects every taxonomy term referenced by the node via
  `getReferencedTerms()`, and returns TRUE on the first term that `matchesTerm()`. Meant for content
  pages.

`getReferencedTerms(FieldableEntityInterface $entity)` iterates the entity's field definitions,
keeps only `entity_reference` fields whose `target_type` setting is `taxonomy_term`, and returns the
referenced `TermInterface` entities keyed by term id. It scans all such fields, not just a named one.

`hasRestrictions()` is TRUE when either `bundles` or `terms` is non-empty. Negation is applied by the
condition executable manager, so `evaluate()` returns the un-negated result.

## Cache metadata

`VocabularyConditionBase::getCacheTags()` merges the parent tags with `$inspectedTermTags` — the tags
of every term (and ancestor, when matching descendants) touched during evaluation. This invalidates a
cached block whenever an inspected term or its ancestry changes. The module adds no extra cache
contexts; varying by the current term/node comes from the route context supplied by the host.

## Consuming from code

These are ordinary condition plugins, so they work anywhere conditions are used — Block Layout, the
Context module, Page Manager, or directly:

```php
/** @var \Drupal\Core\Condition\ConditionManager $manager */
$manager = \Drupal::service('plugin.manager.condition');
/** @var \Drupal\Core\Condition\ConditionInterface $condition */
$condition = $manager->createInstance('vocabulary', [
  'bundles' => ['tags' => 'tags'],
  'terms' => [5, 8],
  'include_descendants' => TRUE,
]);
$condition->setContextValue('taxonomy_term', $term);
$applies = $condition->execute();
```
