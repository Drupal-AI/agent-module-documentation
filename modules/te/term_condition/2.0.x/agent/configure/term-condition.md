<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the Term visibility condition

There is **no admin settings page** for this module (`configure: null`). It contributes a
Condition plugin that you configure wherever conditions are collected — normally a block.

## In the UI (block visibility)

1. *Structure → Block layout* → **Place block** (or edit a placed block).
2. Open the **Visibility** vertical tab → **Term**.
3. In **Select taxonomy term(s)** (a tagged entity autocomplete) type one or more terms.
4. Optionally tick **Negate the condition** to invert (block hidden on matching terms).
5. Save the block.

The plugin requires a `node` context. On the block form the node context is provided by
core's `@node.node_route_context:node` mapping, so the condition only has an entity to test
on routes that resolve a node (e.g. `entity.node.canonical`).

## Config shape (what gets written)

A placed block stores the condition inside its `visibility` map:

```yaml
# block.block.<block_id>.yml
visibility:
  term:
    id: term
    negate: false
    context_mapping:
      node: '@node.node_route_context:node'
    term_uuids:
      - 1b2c3d4e-...   # UUID of each selected taxonomy term
```

- `term_uuids` — **array of taxonomy term UUIDs** (schema: `condition.plugin.term`,
  a `sequence` of `uuid`, ordered by value). v2 stores UUIDs, **not** term IDs.
- `negate` — boolean, inherited from `condition.plugin`.
- `id` is `term`; `context_mapping.node` binds the node context.

## Setting it with Drush / PHP

```php
$block = \Drupal::entityTypeManager()->getStorage('block')->load('my_block');
$v = $block->getVisibility();
$v['term'] = [
  'id' => 'term',
  'negate' => FALSE,
  'context_mapping' => ['node' => '@node.node_route_context:node'],
  'term_uuids' => [\Drupal\taxonomy\Entity\Term::load($tid)->uuid()],
];
$block->setVisibilityConfig('term', $v['term'])->save();
```

Resolve a term UUID with `Term::load($tid)->uuid()`, or map back with
`\Drupal::service('entity.repository')->loadEntityByUuid('taxonomy_term', $uuid)`.

## Legacy config upgrade

`term_condition_update_9201` scans **all** config for a `term_condition` module dependency
and rewrites old `tid`-based term conditions (scalar or `[['target_id' => …]]`) into
`term_uuids`, dropping entries for deleted terms and cleaning the dependency if none remain.
