<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — Clover Commerce Sync

**Settings:** `clover_commerce_sync.settings` → `/admin/config/commerce/clover-sync` (perm `administer clover commerce sync`). Enter Clover API credentials and the webhook secret. **Set the webhook secret** before exposing the webhook.

**Manual sync:** `clover_commerce_sync.manual_sync` → `/admin/config/commerce/clover-sync/run` runs `CloverSyncService::syncAll()` and reports updated/skipped/errors counts (errors go to dblog).

**Webhook:** `clover_commerce_sync.webhook` → POST `/clover-sync/webhook`. `WebhookController::handle()` verifies `X-Clover-Signature` (`hash_hmac('sha256', body, secret)`, `hash_equals`) when a secret is configured, parses the Clover payload (`merchants[mId].data[]`), collects ITEM/INVENTORY_ITEM object ids, and calls `syncSingleItem()` for each (values fetched from the Clover API — the webhook carries only ids).

**Matching:** variations are matched to Clover items by SKU; price is always updated, stock is updated when `commerce_stock.service_manager` is available (optional dependency).
