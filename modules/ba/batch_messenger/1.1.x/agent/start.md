<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Batch Messenger (batch_messenger) — agent index

Developer/infrastructure module that groups **Symfony Messenger** messages into named **collections**,
renders their progress in a **Batch-style admin UI**, and can intercept legacy **`batch_set()`** calls to
run each operation as a Messenger message off-thread. Core `^11.1`, PHP `8.2`. License GPL-2.0-or-later.
Version 1.1.2.

Composer requires **`drupal/sm`** (Symfony Messenger for Drupal — module machine name **`sm`**) and
`thecodingmachine/safe`. No config entities, no config schema, no Drush, no plugin types. Most classes are
`@internal`.

- **Collection tracking API — the `CollectionItem` stamp, middlewares, and the tracker/counts** →
  [api/collections.md](api/collections.md)
- **Batch API bridge, the Message sets UI, routes/permissions, and service parameters** →
  [api/batch-bridge.md](api/batch-bridge.md)

## Three pieces (all in `src/`)

1. **Base — collections.** Attach `Messenger\Stamp\CollectionItem` (shared `collection` + unique `identifier`,
   each ≤64 chars) to a dispatched `Envelope`. `Messenger\Middleware\BatchMessengerEntryMiddleware` records it
   pending (once, guarded by a `CollectionItemMarkedPending` stamp); `BatchMessengerPostHandleMiddleware`
   transfers it to processed. `BatchMessengerTracker` (service, `public: true`) keeps counts in DB tables and a
   keyvalue store.
2. **UI** (parameter `batch_messenger.ui`, default `true`). `Ui\EventListener\RouteSubscriber` adds
   `/admin/reports/batch-messenger` (**`batch_messenger.ui.collection`**) and
   `/admin/reports/batch-messenger/clear-complete` (**`batch_messenger.ui.clear_complete`**). `Ui\UiHooksService`
   adds the Reports menu link, a toolbar progress bar (library `batch_messenger/toolbar`), and the "Clear
   complete" local action.
3. **Batch bridge** (parameter `batch_messenger.batch_bridge`, default `true`). `Hook\BatchBridgeHooks`
   /`BatchBridge\BatchBridgeHooksService` implement `hook_batch_alter()`, swapping each set's queue for
   `BatchBridge\BatchMessengerQueue` and dispatching operations as `BatchBridge\Messenger\LegacyBatchItem`
   messages. `BatchMessengerBatchContextManager` simulates `$context` and stores messages/results/finish
   callback.

## Provided route permission

- **`batch_messenger ui view all batches`** ("View all batches", `batch_messenger.permissions.yml`) — required
  by both UI routes. The `clear_complete` route additionally requires `_csrf_token: TRUE`. No other
  permissions.

## Container wiring (`src/BatchMessengerServiceProvider.php`)

Registers `BatchMessengerCompilerPass` (priority 100, before core's MessengerPass), `BatchMessengerReorderCompilerPass`
(priority -100), `Ui\BatchMessengerUiCompilerPass`, and `BatchBridge\BatchBridgeCompilerPass`. The UI/Bridge
`*HooksService` implementations are removed from the container when their parameter is `false`. `hook_schema()`
in `batch_messenger.install` creates 5 tables: `batch_messenger__pending`, `__processed`, `__batch`,
`__batch_messages`, `__batch_results`.

## Requirements to actually run off-thread

The bridge only moves work off the request if Messenger is configured with an **asynchronous transport** (via
`sm`) and a **`messenger:consume` worker** is running. With a sync transport, each operation runs inline in the
same request. See README "Batch API bridge" and `api/batch-bridge.md` for the behavioral differences vs. core
Batch API.
