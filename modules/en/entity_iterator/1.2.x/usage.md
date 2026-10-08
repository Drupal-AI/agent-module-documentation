<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Iterator is a developer helper that lets code loop over a very large number of entities without exhausting memory. Instead of loading every entity at once, it fetches the matching IDs, chunks them (default 50), loads one chunk at a time via `loadMultiple`, and removes each processed entity from the `entity.memory_cache` static cache so memory usage stays flat.
The class `Drupal\entity_iterator\EntityIterator` implements `\Iterator`, `\ArrayAccess` and `\Countable`, so it can be used directly in a `foreach`, counted with `count()`, and probed/removed via array offsets (entity IDs). It is intended for update hooks, Drush scripts, migrations and cron jobs that must touch every entity of a type/bundle.
---
There is nothing to configure: install with `drush en entity_iterator` and use the class from PHP. The constructor takes an entity type ID, an optional array of IDs (NULL loads all of that type), an optional chunk size (default 50), and an optional bundle to filter on. It builds the ID list with an entity query.
Note that the internal ID query runs with `->accessCheck(FALSE)` by design — this is a low-level, code-only utility with no routes, forms, permissions or web surface, so entity access is the responsibility of the calling code (as with any batch/CLI maintenance script). There is no way for an unauthenticated or low-privileged web user to invoke it directly.
---
- Install: `composer require drupal/entity_iterator && drush en entity_iterator -y`.
- Iterate all nodes: `foreach (new EntityIterator('node') as $node) { ... }`.
- Iterate a bundle: `new EntityIterator('node', NULL, 50, 'article')`.
- Iterate a specific ID set: `new EntityIterator('node', [1,2,3])`.
- Tune memory vs query count with the chunk-size argument.
- Count matched entities with `count($iterator)`.
- Check membership with `isset($iterator[$id])` (offsetExists).
- Fetch one entity by ID with `$iterator[$id]` (offsetGet).
- Drop an entity from the remaining iteration with `unset($iterator[$id])`.
- Use inside `hook_update_N` to reprocess large content sets.
- Use in Drush commands to avoid OOM on big sites.
- Rewind re-chunks and restarts iteration cleanly.
- Each processed entity is evicted from the memory cache automatically.
- The destructor cleans up any still-loaded entities.
- Combine with batch API for progress reporting over huge datasets.
- Remember: the ID query uses accessCheck(FALSE) — enforce access in your own code if needed.
