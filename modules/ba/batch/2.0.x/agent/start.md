<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Batch API (batch) — agent index

Developer toolkit that wraps Drupal's core Batch API with OO operation classes, a batch builder,
a finish handler, and Drush code generators. **No** routes, forms, permissions, config, or hooks —
you use its classes in your own code.

- **Machine name:** `batch` · **Namespace:** `Drupal\batch` · **License:** GPL-2.0-or-later
- **Core:** `^10 || ^11` · **Dependency:** `awareness:awareness` (composer `drupal/awareness:^2.0`)
- **Package/Composer:** `drupal/batch`

## What it provides

Classes under `src/Batch/`:
- `Operation\OperationInterface` — `setItemsPerProcess(int)`, `process(array &$context)`.
- `Operation\OperationBase` (abstract) — chunked processing (`itemsPerProcess`, default 10),
  `reclaimMemory()`, `initializeBatch()`; abstract `processItem()` + `init()`. Uses Awareness traits
  (`EntityTypeManagerAwareTrait`, `EntityMemoryCacheAwareTrait`) plus core Logger/Messenger/
  StringTranslation/DependencySerialization traits.
- `Operation\EnumeratedOperationBase` (abstract) — for a fixed array of items; ctor `array $items`,
  `setItems()`. **Extend this for most batches.**
- `Operation\HighwaterOperationBase` (abstract) — for very large/streamed sets; abstract `getItems()`,
  optional `countItems()`. (2.0.0-alpha5 breaking change: highwater now uses `getItems`.)
- `Batch\BatchBuilder` extends core `\Drupal\Core\Batch\BatchBuilder` — `addBatchOperation(OperationInterface)`,
  `setFinishOperation(FinishInterface)`.
- `Finish\FinishInterface` / `Finish\FinishDefault` — `finished()` returns optional `RedirectResponse`;
  `setRedirectUrl(Url)`.
- `Drush\Generators\OperationGenerator` (`batch:operation`) and `FinishGenerator` (`batch:finish`) —
  `drush generate` scaffolders; templates in `templates/generator/`.

## Solution docs

- [agent/api/operations.md](api/operations.md) — operation base classes, lifecycle, memory handling.
- [agent/api/batch-builder.md](api/batch-builder.md) — BatchBuilder + FinishDefault; wiring a batch.
- [agent/api/generators.md](api/generators.md) — the `batch:operation` / `batch:finish` Drush generators.
