# Mechanism — `hook_entity_presave` parent materialisation

The entire runtime is one hook: `taxonomy_set_lineage_entity_presave($entity)` in
`taxonomy_set_lineage.module`. It fires for **every** content entity save site-wide, so the first thing
it does is cheap guards.

## Control flow (`taxonomy_set_lineage.module:20-116`)

1. Bail unless `$entity instanceof ContentEntityBase`.
2. Load `taxonomy_set_lineage.settings`; bail unless `vocabulary` is non-empty.
3. Determine the **lineage fields** for this entity (see [../configure/settings.md](../configure/settings.md)
   for how `entities`/`bundles`/`fields` scope this). The candidate list comes from
   `_taxonomy_set_lineage_get_fields()`, which returns entity-reference→`taxonomy_term` field names whose
   selection handler targets one of the active vocabularies.
4. For each lineage field, read current values and compare to `$entity->original`:
   - `$tids` = `array_column($values, 'target_id')`, `$original_tids` = same from `$entity->original`.
   - Both are `asort`ed, then `if (array_diff($tids,$original_tids) || array_diff($original_tids,$tids))`
     — i.e. **it only acts when the field's set of term ids changed** (add or remove). An unchanged
     field is skipped entirely.
5. For each currently-selected `$tid`, `\Drupal::entityTypeManager()->getStorage('taxonomy_term')->loadAllParents($tid)`.
   `loadAllParents()` returns `[term, …ancestors]` (the term itself plus ancestors up to the root), so
   `count($parents) > 1` means "has at least one ancestor".
6. Insert missing ancestors: find the child term's `$delta` in `$values`, then walk
   `array_reverse($parents, TRUE)` (root → … → child) and, for each ancestor **not already** in `$tids`,
   build `['target_id' => $parent->id()]`. `array_splice($values, $delta, 0, $new_values)` inserts them
   **immediately before** the child, and `$entity->get($field)->setValue($values)`.

Net effect: after save, a field tagged with a leaf term also contains every ancestor, ordered
root-first ahead of the leaf. See the functional test `TaxonomySetLineageContentTest::testSave()`
(parent, child, grandchild land at deltas 0,1,2).

## Behaviour an integrator must know

- **Add-only.** The hook never removes a term. It only splices in missing ancestors.
- **Change-gated.** Ancestors are (re)added only when the field's term set differs from `$entity->original`.
  A save that does not alter that field leaves it untouched — so pre-existing content is **not** backfilled
  by an unrelated edit; use the bulk action for that ([../plugins/action.md](../plugins/action.md)).
- **Removing an ancestor is effectively undone.** If an editor deletes only an ancestor (e.g. *Europe*)
  but keeps the leaf (*Berlin*), the set changed → the leaf's parents are recomputed → *Europe* is
  re-added on that same save. The field silently re-adds what was removed; editors should be told.
- **Moving a term does not re-materialise existing content.** There is no `hook_taxonomy_term_*`
  implementation. The stored ancestors are a **copy** taken at the last save; re-parenting a term in the
  vocabulary leaves already-saved content pointing at the old lineage until each item is re-saved (or the
  bulk action is run).
- **Field cardinality still wins.** The hook `setValue`s the expanded list, but the field system enforces
  cardinality on save. On a single-value field there is no room for parents, so none are added (per
  `README.txt`).
- **Multilingual.** Only the terms in the language/field values being edited are processed — parents are
  set for the just-changed values, not for other translations' term sets.

## Helper functions (in `.module`)

- `_taxonomy_set_lineage_get_fields(EntityInterface $entity, array $vocabulary = [])` — returns the names
  of the entity's `entity_reference` fields whose `field_storage_config` target type is `taxonomy_term`
  and whose handler targets one of `$vocabulary` (via `handler_settings.target_bundles`, or via
  `_taxonomy_set_lineage_get_view_vocabularies()` when `handler == 'views'`). With an empty `$vocabulary`,
  the `target_bundles` branch matches any such field.
- `_taxonomy_set_lineage_get_view_vocabularies($view_id, $display_id)` — reads the referenced View
  display's `filters.vid.value` (falling back to the `default` display) to learn which vocabularies a
  view-based entity-reference selection handler exposes.
