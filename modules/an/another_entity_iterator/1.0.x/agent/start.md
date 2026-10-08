<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Yet Another Entity Iterator (another_entity_iterator) — agent index

Developer-only utility (package **Utility**). Exposes ONE service that loads and iterates large sets of
entities in **memory-efficient chunks** — a lazy replacement for calling `loadMultiple()` on a huge ID list.
Core `>=10.2 || ^11`, PHP **8.2**. Installed version 1.0.0-alpha7. No UI, routes, permissions, forms,
config schema, hooks, or Drush commands.

## What it provides
- Service `another_entity_iterator.factory` (public) → `EntityIterator\EntityIteratorFactory`,
  also aliased to interface `EntityIteratorFactoryInterface` for autowiring
  (`another_entity_iterator.services.yml`).
- `EntityIteratorFactory::get(string $entityType, iterable $entityIds, ?int $chunkSize = NULL): ChunkedIterator`
  — `$entityType` is a **class-string** (e.g. `Node::class`), resolved to an entity-type ID via
  `EntityTypeRepositoryInterface::getEntityTypeFromClass()`.
- `EntityIterator\ChunkedIterator` — `final readonly`, `IteratorAggregate` + `Countable`. Loads entities
  `chunkSize` at a time via storage `loadMultiple()`, then `MemoryCacheInterface::deleteAll()` per chunk.

## Key behavior
- Default chunk size **50**; per-call `$chunkSize`, else `$settings['entity_update_batch_size']`.
- Invalid (`< 1` or non-int) chunk size → `\InvalidArgumentException`.
- Empty ID iterable loads **nothing** (unlike core, never "all entities").
- Accepts arrays or lazy `\Generator` iterables of IDs. `count()` returns the ID count.
- Uses **raw storage load** — performs NO per-entity access checks (caller's responsibility).

## Solution docs
- [agent/api/iterator.md](api/iterator.md) — the factory + iterator API, chunk-size setting, patterns, caveats.

## Dependencies
None beyond Drupal core (Entity API, memory cache). No contrib deps, no submodules, no libraries.
