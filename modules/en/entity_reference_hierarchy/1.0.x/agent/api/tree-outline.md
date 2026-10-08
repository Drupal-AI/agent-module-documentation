<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Computing the tree: `getFieldHierarchyOutline()`

The whole hierarchy is derived **in PHP from the field item list** — there is no database query,
no join table, and no service. The logic lives in
`src/EntityReferenceHierarchyFieldItemListTrait.php`, used by
`EntityReferenceHierarchyFieldItemList` (which extends core `EntityReferenceFieldItemList`). The
revisions submodule reuses the same trait on `EntityReferenceRevisionsFieldItemList`.

## Data model

Each stored item is `{ target_id, depth }` plus the field **delta** (row order). The tree is
implied:

- **weight / sibling order** = the delta (row position).
- **parent** = the nearest preceding row whose `depth` is exactly one less.

Example (delta : depth):

```
0:0  A
1:1  B      (child of A)
2:1  C      (child of A)
3:2  D      (child of C)
4:0  E      (root sibling of A)
```

## `getFieldHierarchyOutline()`

Returns an array **keyed by delta**, nested. Two passes:

1. **Forward pass** builds a parent map. It keeps a `$parents` stack seeded with `[-1]` (the
   virtual root) and tracks `$prev_depth`. For each `$delta => $item`:
   - read `$depth = $item->get('depth')->getValue()`;
   - if depth increased, `array_unshift($parents, $delta - 1)` (the previous row becomes the new
     parent);
   - if depth decreased, `array_splice($parents, 0, $prev_depth - $depth)` (pop back up);
   - record `$tree[$delta]['parent'] = $parents[0]` and an empty `children` array.
2. **Reverse pass** folds children into parents: iterating deltas in reverse, any node whose
   `parent != -1` is prepended into its parent's `children` and unset from the top level. What
   remains at the top level are the roots, each carrying its nested `children`.

So a caller gets `['parent' => <delta|-1>, 'children' => [...]]` per node, roots at depth 0.

## Using it in code

```php
$items = $node->get('field_tree');            // EntityReferenceHierarchyFieldItemList
$outline = $items->getFieldHierarchyOutline(); // delta-keyed nested tree

// Roots:
$root_deltas = array_keys($outline);

// Parent of a delta (before the fold, the flat map is easiest to reason about):
//   $outline is already nested; walk it, or re-derive parent via depth.

// Target entity for a delta:
$target = $items[$delta]->entity;
```

The two hierarchy formatters call exactly this to build their nested `item_list`
(see [../fields/formatters.md](../fields/formatters.md)).

## Notes for agents

- **No cycles are possible by construction**: a node's parent is always an *earlier* delta at a
  *lower* depth, so the outline is a strict rooted forest — traversal is bounded by the number of
  field items and cannot loop. There is no recursion over stored parent-ids that could form a
  cycle.
- The outline is **in-memory only**: it reflects the loaded field values, not a persisted tree.
  Descendants/ancestors are cheap to compute but must be recomputed per load.
- Ordering and depth are whatever the editor dragged into place; the module does not enforce a
  maximum depth or a single-parent constraint beyond what the delta+depth encoding naturally
  gives (each row has exactly one parent).
