<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Operation classes

Files: `src/Batch/Operation/*.php`. An "operation" is one OO batch callback. All extend
`OperationBase` and implement `OperationInterface`.

## Install / enable

`composer require drupal/batch` (pulls `drupal/awareness:^2.0`), then `drush en batch -y`.
Nothing to configure; you write PHP that uses the classes.

## OperationInterface (`OperationInterface.php`)

- `setItemsPerProcess(int $itemsPerProcess): self` — items handled per batch iteration.
- `process(array &$context): void` — the callback core invokes each run (registered as
  `[$operation, 'process']` by the builder).

## OperationBase (`OperationBase.php`, abstract)

Traits: `DependencySerializationTrait` (survives serialization between HTTP requests),
`EntityMemoryCacheAwareTrait` + `EntityTypeManagerAwareTrait` (from **awareness** — provide
`getEntityMemoryCache()` / `getEntityTypeManager()`), `LoggerChannelTrait`, `MessengerTrait`,
`StringTranslationTrait`.

- `protected int $itemsPerProcess = 10;` — default chunk size; `setItemsPerProcess()` overrides.
- `abstract protected function processItem(mixed $item, array &$context): void;` — **you implement
  this**: the per-item worker (load an entity by ID, mutate, save, log, etc.).
- `abstract protected function init(array &$context): void;` — seed `$context['sandbox']`; called
  once via `initializeBatch()` which guards on `$context['sandbox']['batch_init']`.
- `protected function reclaimMemory(): bool` — if `memory_get_usage()` ≥ 85% of `memory_limit`
  (treats `-1` as 256MB via `Bytes::toNumber`), runs `drupal_static_reset()`, resets every entity
  storage cache, `getEntityMemoryCache()->deleteAll()`, and `gc_collect_cycles()`. Returns whether it ran.

## EnumeratedOperationBase (`EnumeratedOperationBase.php`, abstract) — the common case

For a **known, in-memory list**. Constructor `__construct(protected array $items = [])`; also
`setItems(array): self`.
- `init()` stores `$context['sandbox']['items']` and `['total'] = count(...)`.
- `process()` calls `initializeBatch()`, then `array_shift`s up to `itemsPerProcess` items and calls
  `processItem()` on each (returns early when the list empties), calls `reclaimMemory()`, and sets
  `$context['finished'] = 1 - remaining/total` capped at `.9999`.

Extend it and implement `processItem()`:
```php
class MyOp extends EnumeratedOperationBase {
  public function processItem(mixed $item, array &$context): void {
    $node = $this->getEntityTypeManager()->getStorage('node')->load($item);
    if ($node) { $node->setTitle('Updated')->save(); }
  }
}
```

## HighwaterOperationBase (`HighwaterOperationBase.php`, abstract) — huge / streamed sets

Loads items **progressively** instead of holding them all in memory.
- `init()` seeds `items=[]`, `highwater=NULL`, `count=0`, `total=NULL`.
- `abstract protected function getItems(array &$context): void;` — **you implement**: query the next
  chunk (respecting `itemsPerProcess`), push IDs into `$context['sandbox']['items']`, and set
  `$context['sandbox']['highwater']` to the highest processed marker; leave it `NULL` when done.
- `protected function countItems(array $context): ?int` — optional; override for accurate progress
  (default `NULL` → `$context['finished'] = 0`, i.e. unknown).
- `process()` calls `getItems()`, returns when highwater is `NULL`, processes the whole chunk,
  reclaims memory, and computes `finished = count/total` capped at `.9999`.

> Breaking change (2.0.0-alpha5): highwater operations must implement `getItems()`; earlier code
> using the previous method must be updated.

## Running an operation

Build with `BatchBuilder` and hand to core — see [batch-builder.md](batch-builder.md).
