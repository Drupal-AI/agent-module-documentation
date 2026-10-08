<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Index maintenance internals (`PrevNextApi`)

`Drupal\prev_next\PrevNextApi` (service `prev_next.api`, args `@module_handler`, `@database`,
`@prev_next.helper`) is the write side. It maintains `prev_next_node` rows so the read side
([helper](../blocks/prev-next-block.md)) is a single indexed lookup.

## Entity lifecycle wiring
`prev_next.module` calls the API only for `NodeInterface` entities whose bundle is in
`PrevNextHelper::getBundleNames()`:
- `hook_entity_insert` → `add($nid, $bundle)`
- `hook_entity_update` → `update($nid, $bundle)`
- `hook_entity_delete` → `remove($nid, $bundle)`

## add($entity_id, $bundle_name)
1. Loads the bundle config, reads `indexing_criteria`, builds a bundle SQL clause with
   `bundlesSql()`.
2. Computes this node's `prev_nid`/`next_nid` from `{node_field_data}` filtered by `status = 1`:
   - When `indexing_criteria == 'nid'`: order by `nid` and take the first row `> :nid` (next) /
     `< :nid` (prev).
   - Otherwise: fetch the node's criteria value, then find the next/prev row ordered by
     `(criteria, nid)` with a compound comparison so ties on the criteria fall back to `nid`.
3. Upserts this node's row (checks existence, then `update` or `insert`), storing `0` when a side has
   no neighbour and `changed = \Drupal::time()->getRequestTime()`.
4. Repairs neighbours: iterates `NodeType::loadMultiple()`, recomputes, and updates the rows of the
   nodes that should now point at this node (`next_nid`/`prev_nid = entity_id`).

## update()
`modifyPointingEntities()` first (re-`add()` any node whose stored `prev_nid`/`next_nid` equals this
node), then `add()` for this node.

## remove()
Deletes this node's row, then `modifyPointingEntities()` to re-`add()` nodes that pointed at it, so
their neighbour links close the gap.

## bundlesSql($bundle_name, $bundle)
Returns the `AND type …` fragment appended to the neighbour queries:
- `same_type` on → `AND type = '<bundle_name>'`.
- `same_type` off → `AND type IN ('<t1>','<t2>',…)` built from `getBundleNames()`
  (empty string when no types).

## Notes for operators
- The index reflects **published** nodes only; unpublishing removes a node as a neighbour on the next
  save/cron pass.
- Bulk-importing nodes that bypass entity hooks leaves rows stale — re-save or re-index.
- Node **grant-based** access (node_access modules) is not evaluated when picking a neighbour; the
  block emits a bare `/node/<id>` link and the target node enforces access when visited.
