<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity iterator API

Source: `src/EntityIterator/EntityIteratorFactory.php`, `EntityIteratorFactoryInterface.php`,
`ChunkedIterator.php`; wiring in `another_entity_iterator.services.yml`.

## Install / enable
`composer require drupal/another_entity_iterator` then enable `another_entity_iterator`. No config,
no schema, no permissions to grant. Nothing appears in the admin UI — it is API-only.

## The service
`another_entity_iterator.services.yml` registers `another_entity_iterator.factory`
(`EntityIteratorFactory`) as **public**, and aliases the interface
`Drupal\another_entity_iterator\EntityIterator\EntityIteratorFactoryInterface` to it so it can be
**autowired** into your own services/controllers by type-hinting the interface. Defaults are
`public: false, autowire: true`; the factory itself is explicitly `public: true`.

`EntityIteratorFactory` is constructed with core services: `EntityTypeManagerInterface`,
`@entity.memory_cache` (`MemoryCacheInterface`), `Settings`, `EntityTypeRepositoryInterface`.

## The one method
```php
public function get(
  string $entityType,        // an entity-type CLASS-string, e.g. Node::class (not "node")
  iterable $entityIds,       // array or Generator of int|string IDs
  ?int $chunkSize = NULL,    // per-call override; NULL => setting/default
): ChunkedIterator;
```
Steps in `get()`:
1. `$entityTypeId = $entityTypeRepository->getEntityTypeFromClass($entityType)` — maps the class to
   an entity-type ID.
2. `$chunkSize ??= Settings::getInstance()::get('entity_update_batch_size', 50)`.
3. Guard: if `$chunkSize` is not an int or `< 1`, throws `\InvalidArgumentException('Invalid chunk size.')`.
4. Returns `new ChunkedIterator($entityTypeManager->getStorage($entityTypeId), $memoryCache, $entityIds, $chunkSize)`.

## ChunkedIterator behavior
`final readonly class ChunkedIterator implements \IteratorAggregate, \Countable`.
- `count(): int` → `count($this->entityIds)` (the number of IDs, not loaded entities). NOTE: this calls
  `count()` on the ID iterable, so passing a bare `\Generator` and calling `count()` will not work —
  use an array/`\Countable` if you need the count.
- `getIterator()`:
  - If `$entityIds` is an **array**: `array_chunk(array_values($ids), $chunkSize)`.
  - Else (any other iterable, e.g. `\Generator`): buffers IDs and `yield`s a chunk each time it reaches
    `$chunkSize`, then yields the trailing partial chunk.
  - For each chunk: skips empty chunks (`count === 0` → `continue`, so it never accidentally loads all
    entities), then `yield from $entityStorage->loadMultiple($idChunk)`, then
    `$memoryCache->deleteAll()` to release the just-processed entities **and their referenced entities**
    (e.g. owners) from the entity memory cache.
- Yielded values are keyed by entity ID (from `loadMultiple`). Order follows the input ID order for arrays.

## Chunk size configuration
There is NO config entity/schema. The global default is read from Drupal's `Settings`
(`settings.php`):
```php
// settings.php
$settings['entity_update_batch_size'] = 200; // default is 50
```
A per-call `$chunkSize` argument overrides the setting for that call.

## Usage patterns
Direct service call:
```php
$factory = \Drupal::service('another_entity_iterator.factory');
foreach ($factory->get(\Drupal\node\Entity\Node::class, $nids) as $nid => $node) {
  // $node is a fully loaded Node; process and let it fall out of memory next chunk.
}
```
Autowired into a service (preferred):
```php
public function __construct(
  private readonly EntityIteratorFactoryInterface $iteratorFactory,
) {}
```
Feeding from an entity query:
```php
$ids = $storage->getQuery()->accessCheck(FALSE)->condition('type', 'article')->execute();
foreach ($this->iteratorFactory->get(Node::class, $ids) as $node) { /* ... */ }
```

## Caveats for callers
- **No access control.** `loadMultiple()` bypasses entity access; if iterated entities feed user-facing
  output, apply your own access checks (or an `accessCheck(TRUE)` entity query upstream).
- Pass a **class-string**, not an entity-type machine name; an unknown class makes
  `getEntityTypeFromClass()` throw.
- The memory-cache `deleteAll()` clears the whole entity memory cache each chunk — expect other
  in-request entity references to be reloaded from persistent cache/DB afterward.
- Empty ID list ⇒ zero iterations (safe; never "load everything").

## Tests
`tests/src/Kernel/ChunkedIteratorTest.php` verifies both array and `\Generator` ID inputs with a
non-evenly-divisible chunk size (10 entities / chunk 3), asserting all entities are yielded and keyed
by ID.
