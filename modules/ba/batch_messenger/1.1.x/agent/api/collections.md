<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Collection tracking API

The base functionality: tag dispatched Symfony Messenger messages as members of a **collection** and track how
many are pending vs. processed. Works independently of the Batch bridge.

## Attach the stamp

`Drupal\batch_messenger\Messenger\Stamp\CollectionItem` (`src/Messenger/Stamp/CollectionItem.php`) — a
`StampInterface`. Construct via `CollectionItem::create(string $collection, string $identifier)`; getters
`getCollection()` / `getIdentifier()`. `collection` is the shared set ID; `identifier` is unique within the set.
Both are non-empty strings; the tracker/DB cap each at **64 chars** (a longer value throws
`InvalidArgumentException`; README says IDs may be 1–128 but storage enforces 64). Dispatching a **duplicate**
`collection`+`identifier` pair errors (unique key `collection_and_identifier`).

```php
use Symfony\Component\Messenger\Envelope;
use Symfony\Component\Messenger\MessageBusInterface;
use Drupal\batch_messenger\Messenger\Stamp\CollectionItem;

$bus = \Drupal::service(MessageBusInterface::class);
$collection = 'my-set-' . \mt_rand(111, 999);
foreach (range(1, 60) as $i) {
  $bus->dispatch(new Envelope(
    message: new MyMessage(),
    stamps: [CollectionItem::create($collection, (string) $i)],
  ));
}
```

## How tracking happens (middlewares)

Both are declared `abstract` in `batch_messenger.services.yml` and wired into the bus by
`BatchMessengerCompilerPass` / `BatchMessengerReorderCompilerPass`.

- `Messenger\Middleware\BatchMessengerEntryMiddleware::handle()` — on an envelope carrying a `CollectionItem`,
  if it does **not** yet carry a `CollectionItemMarkedPending` stamp, calls
  `BatchMessengerTracker::addPending()` and adds that stamp (so re-queued/retried envelopes aren't counted
  twice). Then continues the stack.
- `Messenger\Middleware\BatchMessengerPostHandleMiddleware` — after the handler runs, calls
  `BatchMessengerTracker::transferPendingToProcessed()` to move the item from pending to processed.

Stamps: `Messenger\Stamp\CollectionItem`, `Messenger\Stamp\CollectionItemMarkedPending` (marker only).

## The tracker service

`Drupal\batch_messenger\BatchMessengerTracker` (`src/BatchMessengerTracker.php`, service id = class name,
`public: true`, but `@internal` — "will be removed without notice"). Deps: `Connection`, `keyvalue` factory,
`TimeInterface`. Key methods:

- `addPending($collection, $identifier)` — inserts into `batch_messenger__pending`; on first sight of a
  collection also records its created-time in keyvalue collection `batch_messenger-batch` via
  `setIfNotExists()`.
- `transferPendingToProcessed()` → `removePending()` (throws `LogicException` if the pending row is missing) +
  `addProcessed()` (inserts into `batch_messenger__processed` with a `processedOn` microtime).
- `countItems($collection)` → `[int $pending, int $processed]` via one parameterized subquery-pair
  (`:collection` placeholder).
- `getCollections()`: `\Generator<Collection>` — iterates the `batch_messenger-batch` keyvalue store, yields a
  `Collection\Collection` per set with live counts.
- `clearCompleteCollections()` — deletes the keyvalue entry for each complete collection (backing rows in the
  other tables are not yet pruned — see the `@todo`).
- `getMostRecentlyUpdatedCollection()` — most recent `processedOn` row; used by the toolbar.

## The Collection value object

`Drupal\batch_messenger\Collection\Collection` (`src/Collection/Collection.php`, `@internal`):
`create($name, \DateTimeInterface $created, int $pending, int $processed)` (name >64 chars throws). Public
readonly-style props `collectionName`, `created`, `pendingCount`, `processedCount`.
`isComplete()` = `pendingCount === 0`; `progress()` = `1 - pending / (processed + pending)` (0.0–1.0).

## Storage (created by `batch_messenger.install`, `hook_schema`)

- `batch_messenger__pending` — (`collection`, `identifier`); unique key on the pair; index on `collection`.
- `batch_messenger__processed` — adds `processedOn` (numeric microtime); same unique key + `processedon_idx`.
- Collection created-times live in the **keyvalue** collection `batch_messenger-batch` (not a DB table of its
  own for this base path).

Counts are intentionally kept in these tables (not the lock system) because they're only needed for UI display —
approximate is acceptable.
