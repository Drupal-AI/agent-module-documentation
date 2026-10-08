<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring the conditions

There is no site-wide settings page. Each condition is configured on the block (or context) that
hosts it, at **Structure > Block layout**, in a block's **Visibility** section — the "Vocabulary or
term" tab (`vocabulary`) or the "Content tagged with vocabulary" tab (`vocabulary_node`). Both tabs
present the same three inputs (from `VocabularyConditionBase::buildConfigurationForm`).

## Form fields

| Form key | Type | Stored config key | Meaning |
|----------|------|-------------------|---------|
| Vocabularies | `checkboxes` of all `taxonomy_vocabulary` entities | `bundles` | Match every term of the checked vocabularies. |
| Taxonomy terms | `entity_autocomplete` (`taxonomy_term`, `#tags` = TRUE) | `terms` | Also match these specific terms, even if their vocabulary is not checked. |
| Include descendants of the selected terms | `checkbox` | `include_descendants` | Also match every term nested under the selected terms. |

`submitConfigurationForm()` normalizes the values: `bundles` is `array_filter`-ed to the checked
machine names, `terms` is mapped to a plain array of integer term ids (from the autocomplete
`target_id`s), and `include_descendants` is cast to bool. The two subclasses only override the field
`#description` text (term-page vs. content-page wording); the stored keys are identical.

## Semantics

- Selected vocabularies and terms are combined with **OR**: the condition applies when the evaluated
  term is in one of the chosen vocabularies **or** is one of the chosen terms (**or** descends from
  one, when Include descendants is on).
- Leaving **both** vocabularies and terms empty does not restrict anything — the condition evaluates
  TRUE (unless negated).
- Block visibility conditions are combined with **AND** by the block system. Putting both `vocabulary`
  and `vocabulary_node` on the same block hides it everywhere, since a page cannot be both a term page
  and a content page.
- `vocabulary_node` reads the node from the route, so it only takes effect where core Node provides a
  node context (canonical node pages).

## Config object + schema

The condition config lives inside the host entity's `visibility` mapping (for blocks, in the
`block.block.*` config). Schema (`config/schema/vocabulary_condition.schema.yml`):

- `condition.plugin.vocabulary` and `condition.plugin.vocabulary_node` both resolve to
  `vocabulary_condition.condition`.
- `vocabulary_condition.condition` extends `condition.plugin` and adds: `bundles` (sequence of
  string), `terms` (sequence of integer), `include_descendants` (boolean).

Exported block config fragment:

```yaml
visibility:
  vocabulary:
    id: vocabulary
    negate: false
    context_mapping:
      taxonomy_term: '@taxonomy_term.taxonomy_term_route_context:taxonomy_term'
    bundles:
      tags: tags
    terms:
      - 5
      - 8
    include_descendants: true
```

`context_mapping` is wired automatically by Block Layout to the taxonomy term (or, for
`vocabulary_node`, the node) of the current route; you normally only set `bundles`, `terms`, and
`include_descendants`.

## Set via PHP

```php
$block = \Drupal\block\Entity\Block::load('my_block');
$block->setVisibilityConfig('vocabulary', [
  'id' => 'vocabulary',
  'negate' => FALSE,
  'context_mapping' => [
    'taxonomy_term' => '@taxonomy_term.taxonomy_term_route_context:taxonomy_term',
  ],
  'bundles' => ['tags' => 'tags'],
  'terms' => [5, 8],
  'include_descendants' => TRUE,
]);
$block->save();
```
