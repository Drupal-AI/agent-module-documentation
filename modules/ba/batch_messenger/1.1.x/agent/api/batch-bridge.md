<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Batch API bridge, UI, routes & parameters

Two optional layers on top of collection tracking. Both are toggled by service parameters in
`batch_messenger.services.yml` and default to on.

## Service parameters

- `batch_messenger.ui: true` — enable the Message sets UI + toolbar.
- `batch_messenger.batch_bridge: true` — enable interception of legacy `batch_set()`.
- `batch_messenger.operation_sleep: 500000` — microseconds `BatchMessengerQueue::sleep()` waits between polling
  passes of `_batch_process()` (throttles the progress-poll loop).

When a parameter is `false`, `Ui\BatchMessengerUiCompilerPass` / `BatchBridge\BatchBridgeCompilerPass` remove the
corresponding `*HooksService` from the container, so the hooks in `src/Hook/` become no-ops (they hold a
nullable service and null-safe-call it). Registered by `BatchMessengerServiceProvider`.

## The Message sets UI

`Ui\EventListener\RouteSubscriber::alterRoutes()` defines two routes:

| Route name | Path | Requirements | Controller |
|---|---|---|---|
| `batch_messenger.ui.collection` | `/admin/reports/batch-messenger` | `_permission: 'batch_messenger ui view all batches'` | `Ui\Controller\CollectionController` |
| `batch_messenger.ui.clear_complete` | `/admin/reports/batch-messenger/clear-complete` | same `_permission` **and** `_csrf_token: TRUE` | `Ui\Controller\ClearCompleteController` |

- `CollectionController::__invoke()` builds a `#type => table` (columns Set / Created on / Pending / Processed /
  Status) over `tracker->getCollections()`; for incomplete sets it adds a `#theme => progress_bar` row whose
  `#message` is `batchContextManager->getLatestMessage()`. Cache max-age 0 (never cached).
- `ClearCompleteController::__invoke()` calls `tracker->clearCompleteCollections()`, sets a messenger
  confirmation, and redirects back to the collection route. It is a state-changing GET, protected by the
  `_csrf_token` requirement above (the "Clear complete" link is generated with the token).
- `Ui\UiHooksService`: `hook_menu_links_discovered_alter` adds the *Reports → Message sets* link;
  `hook_toolbar` adds a toolbar progress bar (only when the most-recent collection is incomplete; library
  `batch_messenger/toolbar` → `css/Ui/toolbar.css`); `hook_menu_local_actions_alter` adds the "Clear complete"
  danger-button action on the collection page; `hook_library_info_build` defines the toolbar library.

The permission `batch_messenger ui view all batches` (title "View all batches") is the module's only permission
(`batch_messenger.permissions.yml`).

## The Batch API bridge

`Hook\BatchBridgeHooks` (attribute `#[Hook('batch_alter')]`) delegates to
`BatchBridge\BatchBridgeHooksService::batchAlter()`:

1. Generates a set name `batch_messenger--{uuid}`.
2. Replaces each set's `queue` with `['name' => $name, 'class' => BatchMessengerQueue::class]`.
3. Appends a `BatchMessengerItemIdentifier` (the operation's numeric key) to each operation's args.
4. Removes the set's `finished` callback from the batch array and stores it via
   `BatchMessengerBatchContextManager::addBatch()` (only `FinishBatch`/`FinishBatchHandler` may later invoke it).

`BatchBridge\BatchMessengerQueue` (a fake queue consumed by core `_batch_process()`):

- `createItem($data)` — pops the `BatchMessengerItemIdentifier`, normalizes the operation callable
  (array `Class::method` or string), and **dispatches** a `BatchBridge\Messenger\LegacyBatchItem` message on
  `batch_messenger.bus.default` (= `@sm.bus.default`) with a `CollectionItem` stamp.
- `claimItem()` returns a `BatchMessengerClaimedItem` wrapping the static `operationCallback`, which updates the
  set's `count` from the live pending count so core's Batch progress screen advances; then `sleep()`.
- `getAllItems()`/`deleteItem()`/`create`/`deleteQueue` are no-ops.

`BatchBridge\Messenger\LegacyBatchItemHandler::__invoke()` runs each converted operation inside
`BatchMessengerBatchContextManager::sandbox()` (lock-guarded, keyvalue-backed `$context['sandbox']`). It builds a
faux `$batch_context` (`sandbox`, `results`, `finished` = 1 by default, `message`), runs the operation through
`BatchMessengerMessengerWrapper::wrapMessengerMessages()` (which redirects `\Drupal::messenger()` output to the
`logger.channel.batch_messenger.operation` channel), then persists any `message`/`results` and, if
`finished < 1`, throws `RecoverableMessageHandlingException` to re-run the operation next pass.
`FinishBatch`/`FinishBatchHandler` invoke the stored finished callback once all operations complete.

`BatchBridge\BatchMessengerBatchContextManager` (`@internal`) persists to the `hook_schema` tables:
`batch_messenger__batch` (per-collection `finishCallback` + timestamps), `batch_messenger__batch_messages`
(serialized per-operation message blobs; `getLatestMessage()` reads the newest), `batch_messenger__batch_results`
(serialized result blobs; `getResults()` yields them). All queries use the DB query builder / bound placeholders.

## Behavioral differences vs. core Batch API (from README)

Operations run in Messenger workers, so: current user/request are absent or simulated; `$context['sandbox']` is
simulated and forces single-threading for that operation; `$context['operations']` is always empty and
`$context['results']` is per-operation-only (shared only to the finished callback); the finished callback runs
once at the end with `$success` always `TRUE`; messages sent to `\Drupal::messenger()` go to logs; operations may
run **out of order / in parallel** (use locking, never rely on sequence); a single failed operation goes to the
Messenger `failed` transport and blocks set completion. **Requires an asynchronous Messenger transport and a
running worker** — otherwise operations execute inline in the request.

## Enable / operate

- `drush en batch_messenger` (pulls in `sm`). Configure an async Messenger transport in `sm` and run a
  `messenger:consume` worker for off-thread execution.
- To disable a layer without uninstalling, override `batch_messenger.ui` or `batch_messenger.batch_bridge` to
  `false` in a `services.yml`/container parameter, then rebuild the container.
- Uninstalling restores stock Batch API behavior; any in-progress batches are lost.
