<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Clover Commerce Sync (clover_commerce_sync) — agent index

**Syncs Clover POS prices and stock into Drupal Commerce product variations via REST API and webhooks.**

- **Version:** 1.0.x (1.0.2)
- **Core:** ^10 || ^11 · **Depends on:** system, commerce_product, commerce_price (optional commerce_stock)
- **Routes:** `clover_commerce_sync.settings` `/admin/config/commerce/clover-sync` (perm `administer clover commerce sync`); `clover_commerce_sync.manual_sync` `/admin/config/commerce/clover-sync/run` (same perm); `clover_commerce_sync.webhook` `/clover-sync/webhook` (`_access: TRUE`, POST)
- **Key services:** `clover_commerce_sync.sync_service` (`CloverSyncService`), `clover_commerce_sync.api_client` (`CloverApiClient`)
- **Permission:** `administer clover commerce sync` (restricted)
- **Security:** admin routes permission-gated. The webhook verifies `X-Clover-Signature` HMAC-SHA256 via `hash_equals` using `webhook_secret` — set the secret. Match by SKU, values re-fetched from the API.

See [configure/sync.md](configure/sync.md)
