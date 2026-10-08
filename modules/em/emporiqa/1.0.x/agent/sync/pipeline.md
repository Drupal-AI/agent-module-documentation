<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Emporiqa — sync pipeline

Flow: entity save/delete or stock movement → **EmporiqaHooks** queues an item → **WebhookQueueWorker**
(cron) loads/formats via **DataFormatter** → **WebhookClient** POSTs a signed batch. Full syncs go
through **SyncProcessor** (Batch UI / Drush) straight to WebhookClient.

## Hooks handler `src/Hook/EmporiqaHooks.php`
OOP `#[Hook(...)]` methods; `emporiqa.module` holds `#[LegacyHook]` procedural shims that delegate.
- `pageAttachments()` — on **non-admin** routes only (guards `AdminContext::isAdminRoute()`), attaches
  `drupalSettings.emporiqa` (widgetBaseUrl derived from `webhook_url` host, storeId, currency,
  channel, defaultLanguage) + library `emporiqa/widget-loader`, plus `emporiqa/cart` when
  `commerce_cart` is on. Adds cache tag `config:emporiqa.settings`. No-op until `store_id` set.
- `commerce_product_(insert|update|delete)`, `commerce_product_variation_(insert|update|delete)`,
  `node_(insert|update|delete)` — queue create/update/delete events.
- Guards before queueing: sync-type enabled, product-type/bundle allowed, **canonical (default)
  translation published** status (unpublishing a secondary translation re-emits, never deletes), and
  `hook_emporiqa_entity_sync_alter()`. Create/update are **deferred** (only id + type queued; heavy
  formatting happens in the worker). Deletes queue pre-formatted payloads.
- Stock-only optimisation: `DataFormatter::hasOnlyStockChanged()` (diffs `$entity` vs original,
  ignoring revision/changed metadata) → queues a lightweight `product.availability` event instead of
  a full rebuild. Per-request dedup map (`queuedEntities`): a full event supersedes an availability
  event for the same key. Warns once when the queue exceeds 10000 items.

## Event subscribers
- `OrderCompleteSubscriber` (`src/EventSubscriber/`) — subscribes `commerce_order.{place,validate,
  fulfill,complete}.post_transition`; if the transition id is in `order_transitions`, queues an
  `order.completed` event (order number, total, currency, items, and the `emporiqa_sid` cookie value,
  length-capped to 256 and regex-validated). Removed from the container by
  `EmporiqaServiceProvider` when `commerce_order`/`state_machine` are absent.
- `StockTransactionSubscriber` — subscribes the literal `commerce_stock_local.stock_transaction.insert`
  event (no compile-time dep on commerce_stock_local); calls
  `EmporiqaHooks::queueVariationAvailability()` so Commerce Stock sales/returns/adjustments (which
  never save the variation) still update availability.

## Queue worker `src/Plugin/QueueWorker/WebhookQueueWorker.php`
Plugin id `emporiqa_webhook`, cron time 60s. `processItem()`:
- Pre-formatted items (`events`) → sent as-is.
- Deferred items → routed by `event_type`: `product.availability` →
  `formatAvailabilityEvents()` (re-reads live stock); else `formatProductEvents()` /
  `formatPageEvents()` load + `formatProduct`/`formatPage` + `alter('emporiqa_data'|'emporiqa_availability')`.
- Skips entities that no longer exist or are unpublished. A `WebhookUnavailableException` (transient)
  throws `SuspendQueueException` (retry later). `handlePermanentFailure()`: 401/403 suspend the whole
  queue (credential problem); other rejections drop the item with an error log.

## `DataFormatter` (`src/Service/DataFormatter.php`)
Builds the consolidated webhook payloads. Optional Commerce deps are injected with `@?` and used only
if present. Key methods: `formatProduct()` / `formatVariation()` (one event per product with all
published translations nested `{channel: {lang: value}}`, shared fields `{channel: value}`),
`formatPage()` (renders the `emporiqa` display), `format*DeleteEvent()`,
`format*AvailabilityEvent()`. Helpers resolve channels from store ids, promotion-aware prices via the
chain price resolver (falls back to base/list price), stock via Commerce Stock
(incl. "always in stock") → configured field → publish status, taxonomy category **hierarchy paths**
(`" > "`, cycle-guarded), brand, images (image fields + media source), and custom `field_*`
attributes (references limited to taxonomy/product/node to avoid leaking user/file data).

## `SyncProcessor` (`src/Service/SyncProcessor.php`)
Full-sync engine shared by Batch UI and Drush. `countProducts/Pages`, `start/complete*Session`,
`processProductBatch/processPageBatch` (query published entities with `accessCheck(FALSE)` + a
`emporiqa_sync_*` query tag, format, `alter('emporiqa_data')`, send via WebhookClient, then free the
entity memory cache). Uses a `sync_session_id`; `sync.complete` marks unseen items deleted on the
platform — callers **skip completion if any batch errored** so still-present items are not wiped.

## `WebhookClient` (`src/Service/WebhookClient.php`)
`sendEvent`/`sendBatchEvents`, `startSyncSession`, `completeSyncSession`, `testConnection` (dry run,
`?dry_run=true`). Builds URL `rtrim(webhook_url,'/') . '/' . store_id . '/'`; **refuses to send when
no secret is configured**; signs the JSON body HMAC-SHA256 into header `X-Webhook-Signature`. POSTs via
the core `http_client` (Guzzle; default TLS, `http_errors=false`). Retries 429/502/503/504 and network
errors up to 2× with backoff; success is HTTP 202 (or 200 for dry run). Exposes `getLastError()` /
`getLastStatusCode()`; throws `WebhookUnavailableException` on transient failure.

## Drush (`src/Commands/EmporiqaCommands.php`, `drush.services.yml`)
`emporiqa:sync-products` (`em:sp`), `:sync-pages` (`em:spg`), `:sync-all` (`em:sa`),
`:test-connection` (`em:tc`). Each validates `store_id` + `webhook_secret` first and loops
`SyncProcessor` batches (`--batch-size`, default 50), skipping session completion on errors.
