<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The depth field & procedural API

## `depth_level` base field

`hook_entity_base_field_info()` adds an integer base field `depth_level`
(label "Depth", provider `taxonomy_term_depth`, default NULL) to the `taxonomy_term` entity.
It is stored in the **`taxonomy_term_field_data`** table (`depth_level` column) and read on a
loaded term as `$term->depth_level->value`.

**Depth is 1-based:** a root term (no parent) = 1, its child = 2, grandchild = 3, etc.

## Automatic maintenance

- `taxonomy_term_depth_entity_insert($entity)` and `taxonomy_term_depth_entity_update($entity)`
  recompute the depth on every term save. `entity_update` only rewrites when the value actually
  changed (`_taxonomy_term_depth_get_nocache()` compares against the current value), then sets
  `$entity->depth_level`.
- Depth is derived from the parent relationship in `taxonomy_term__parent`, so creating a term
  with a `parent` or re-parenting it yields the correct depth automatically.

## Read API (procedural, in `taxonomy_term_depth.module`)

| Function | Returns |
|---|---|
| `taxonomy_term_depth_get_by_tid($tid, $force = FALSE)` | The term's depth (int). Uses a static + the stored column; `$force = TRUE` recalculates from SQL **and writes the new value back** to `taxonomy_term_field_data`. |
| `taxonomy_term_depth_get_parent($tid, $nocache = FALSE)` | The immediate parent tid (or 0/empty at root). |
| `taxonomy_term_depth_get_parents($tid, $reversed = FALSE)` | Array of ancestor tids (nearest first; `$reversed` for root-first). |
| `taxonomy_term_depth_get_children($tid, $reversed = FALSE)` | Array of descendant tids (follows one child chain). |
| `taxonomy_term_depth_get_full_chain($tid, $reversed = FALSE)` | Ancestors + the term + descendants as one chain. |
| `taxonomy_term_depth_get_chain($tid, $reversed = FALSE)` | **Deprecated** alias of `_get_parents()`. |
| `taxonomy_term_depth_queue_manager($vid = NULL)` | The queue manager service, with `$vid` set. |

```php
// Depth of a term (cached):
$depth = taxonomy_term_depth_get_by_tid($tid);

// Force a fresh recalculation and persist it (e.g. after a raw SQL re-parent):
$depth = taxonomy_term_depth_get_by_tid($tid, TRUE);

// Ancestor chain, root first:
$ancestors = taxonomy_term_depth_get_parents($tid, TRUE);
```

Example hierarchy `Root(1) → Child(2) → Grand(3)`:
`taxonomy_term_depth_get_by_tid($grand)` = `3`;
`taxonomy_term_depth_get_parents($grand)` = `[$child, $root]`.

Note: the read helpers use `drupal_static` caches within a request; pass `$force`/`$nocache`
to bypass them after out-of-band changes.
