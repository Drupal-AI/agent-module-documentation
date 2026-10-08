<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Manager service, tracking lifecycle, hook & subscriber (API)

## The state model

For each Search API index the module keeps one `State` entry:

```
search_api_mark_outdated_<index_id>  =>  [ '<combined_id>', '<combined_id>', ... ]
```

The array holds the Search API **combined ids** of items whose source content entity has changed but
whose index entry has not yet been rebuilt. An item is "outdated" iff its combined id is present in
that array. Combined ids are built as
`Utility::createCombinedId('entity:' . $entity_type_id, $entity_id . ':' . $langcode)` — one per
translation language of the entity.

## Lifecycle

1. **Content entity saved** → `search_api_mark_outdated_entity_update()` (`.module`,
   `hook_entity_update()`): returns early unless the entity is a `ContentEntityInterface` and unless
   `$entity->search_api_skip_tracking` is falsy; looks up the indexes tracking it with
   `ContentEntity::getIndexesForEntity($entity)`; calls `manager->entityUpdate($indexes, $entity)`.
2. `SearchApiManager::entityUpdate()` builds a combined id for every translation language and calls
   `setOutdated()` on each index → the ids are **added** to that index's state array.
3. **Search API finishes indexing** → it dispatches `SearchApiEvents::ITEMS_INDEXED`.
   `SearchApiSubscriber::onItemsIndexed()` (service
   `search_api_mark_outdated.search_api_subscriber`, tagged `event_subscriber`) reads
   `$event->getProcessedIds()` and calls `manager->itemsIndexed($index, $ids)` → those ids are
   **removed** (`array_diff`) from the state array. Once indexing catches up the row is no longer
   outdated.

Note: the docblocks reference `hook_search_api_items_indexed()`, but the clearing is actually wired
through the `ITEMS_INDEXED` **event subscriber** above, not a hook.

## Service: `search_api_mark_outdated.manager`

Class `Drupal\search_api_mark_outdated\SearchApiManager` (args: `@entity_type.manager`, `@state`).

```php
$manager = \Drupal::service('search_api_mark_outdated.manager');

// True if this Search API item id is currently flagged outdated for the index.
$manager->isOutdated($index, $combined_id);           // bool

// Manually flag a set of combined ids on an index (adds to the state array).
$manager->setOutdated($index, ['entity:node/12:en']);

// Manually clear a set of item ids from the outdated state (what ITEMS_INDEXED does).
$manager->itemsIndexed($index, ['entity:node/12:en']);

// Flag all translations of a just-saved content entity across the given indexes.
$manager->entityUpdate($indexes, $entity);
```

Method reference (`src/SearchApiManager.php`):

| Method | Signature | Effect |
|---|---|---|
| `entityUpdate` | `(array $indexes, ContentEntityInterface $entity): void` | Builds a combined id per translation langcode, calls `setOutdated()` on each index. |
| `setOutdated` | `(IndexInterface $index, array $ids): void` | `State` array `+ $ids` (union), then saves. |
| `itemsIndexed` | `(IndexInterface $index, array $item_ids): void` | `array_diff` the given ids out of the state array, then saves. |
| `isOutdated` | `(IndexInterface $index, string $id): bool` | `isset(array_flip(state)[$id])`. |
| `createCombinedId` | `protected (EntityInterface $entity, $langcode = NULL): string` | `entity:<type>` + `<id>:<langcode>` via `search_api\Utility\Utility::createCombinedId()`. |

## Caveats an integrator should know

- `setOutdated()` uses `+` (array union on numeric keys), not a keyed set, so ids accumulate; they
  are only ever pruned by `itemsIndexed()` on the `ITEMS_INDEXED` event. If indexing never runs for
  an index, its outdated set only grows.
- Only `hook_entity_update()` is handled — **not** entity insert or delete. A brand-new entity or a
  deleted one is not flagged/cleared by this module (Search API's own tracking handles those; this
  module only closes the gap between "edited" and "reindexed").
- Tracking is keyed by the index id, so renaming/recreating an index leaves an orphan state entry
  under the old id.
