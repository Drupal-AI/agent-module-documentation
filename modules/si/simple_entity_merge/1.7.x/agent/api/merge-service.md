<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API — the merge service

Service **`simple_entity_merge.merge`** → `Drupal\simple_entity_merge\SimpleEntityMerge`
(constructor args `@entity_field.manager`, `@entity_type.manager`).

## Method

```php
public function mergeReferences(
  string $entity_type_id,   // entity type of BOTH source and destination
  int $entity_source_id,    // references TO this id are repointed
  int $entity_destination_id// ... and repointed TO this id
): bool
```

Returns `FALSE` immediately if `$entity_type_id` or `$entity_source_id` is empty, or if the source
entity cannot be loaded; otherwise `TRUE` after processing. It does **not** delete the source
entity and does **not** validate that the destination id exists — callers are responsible for that.

```php
$merger = \Drupal::service('simple_entity_merge.merge');
// Repoint every reference pointing at term 42 so it points at term 7 instead.
$merger->mergeReferences('taxonomy_term', 42, 7);
// Source term 42 still exists; delete it yourself if desired.
```

## What it rewrites (and what it does not)

1. **Configurable fields:** loads all `field_storage_config` entities; for each whose type is
   `entity_reference` **and** whose `target_type` equals the source entity's type, it entity-queries
   the referencing entities (`accessCheck(FALSE)`), loads them, sets every matching
   `->target_id` from source to destination, and saves each one.
2. **Base fields:** iterates all `ContentEntityType` definitions and their base field definitions;
   for each `entity_reference` base field whose `target_type` equals the source type **and** which
   is not a revision-metadata key, it does the same query/repoint/save. (This is how e.g. a user
   merge follows the `uid` base field on nodes.)
3. Before each save, if the referencing entity is a `SynchronizableInterface` it is marked
   `setSyncing(TRUE)` (suppresses hooks that key off "syncing" state).

Limitations to know:
- Only field type **`entity_reference`** is handled — NOT `entity_reference_revisions`, dynamic
  entity reference, link/text fields, embedded references, Layout Builder config, or another
  module's own tables. Those keep pointing at the source.
- No batching: all referencing entities for a field are loaded and saved in one request — not
  suitable for large numbers of references (the project README/description says as much).
- Source and destination must be the same entity type; there is no cross-type merge.
