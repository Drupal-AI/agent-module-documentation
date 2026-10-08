<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Clover Commerce Sync keeps Drupal Commerce product variations in step with a Clover POS by pulling current prices and stock levels via the Clover REST API and reacting to Clover webhooks.

The `CloverSyncService` matches Clover items to commerce variations by SKU and updates price and (when Commerce Stock is present) stock. Admins configure credentials and run a full sync from `/admin/config/commerce/clover-sync` (both gated on `administer clover commerce sync`). A webhook endpoint at `/clover-sync/webhook` (`_access: 'TRUE'`, POST) receives Clover item-change events; because Clover sends only the changed object id, the module then fetches the current value from the API. Webhook signature verification (`X-Clover-Signature`, HMAC-SHA256, `hash_equals`) uses the configured webhook secret, so configure the secret before relying on webhooks.

Use it to mirror Clover pricing and inventory into a Drupal Commerce storefront in near-real-time, with a manual full-sync fallback.
---
Syncs Clover POS prices and stock into Drupal Commerce product variations via REST API and webhooks.
---
- Sync product prices from Clover to Commerce variations
- Sync stock levels from Clover (with Commerce Stock)
- Match Clover items to variations by SKU
- Run a full manual sync from the admin UI
- React to Clover item-change webhooks in near-real-time
- Fetch current values from the Clover API on webhook events
- Configure Clover API credentials
- Set a webhook secret to enable signature verification
- Verify webhook signatures with HMAC-SHA256
- Review sync counts (updated/skipped/errors) after a run
- Inspect sync errors in the dblog
- Handle ITEM and INVENTORY_ITEM change events
- Restrict configuration/sync to "administer clover commerce sync"
- Keep a storefront's pricing aligned with the POS
- Update inventory as items change at the register
- Trigger targeted single-item syncs from webhooks
- Fall back to full sync when webhooks are unavailable
