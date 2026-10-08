<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hook: alter a taxonomy term's tree label

`hook_entity_reference_tree_create_term_node_alter(&$text, $entity)` (from
`entity_reference_tree.api.php`) lets you change the label shown for a taxonomy term node in
the tree.

```php
/**
 * @param string $text
 *   The label to render (defaults to the term's name).
 * @param object $entity
 *   The term row. NOT a full TermInterface: the tree is built with
 *   TermStorageInterface::loadTree($vid, 0, NULL, FALSE), so entities are NOT
 *   loaded. You get the lightweight tree row (tid, name, parents, depth, ...);
 *   load the full term yourself if you need other fields.
 */
function hook_entity_reference_tree_create_term_node_alter(&$text, $entity) {
  // Example: mark root terms.
  if (empty($entity->parents[0])) {
    $text = t('Root: ') . $text;
  }
}
```

Use it to enrich the search/label with extra data (e.g. a code from another field, a depth
marker, or a count) to make terms easier to find in the tree. This is the only hook the
module provides; it applies to the taxonomy tree builder path.
