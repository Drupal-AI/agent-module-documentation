<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Eventbrite One-Way Sync (eventbrite_one_way_sync) — agent index

**One-directional import of Eventbrite events into Drupal via the Eventbrite v3 API and deferred webhooks; optional submodule maps them to nodes.**

- **Version:** 2.0.x (from `2.0.0`)
- **Core:** ^10 || ^11 · **PHP:** 8.x
- **Depends:** `webhook_receiver:webhook_receiver_defer` (webhook transport/auth lives there).
- **Submodule:** `eventbrite_one_way_sync_node` (needs `drupal:datetime_range`).
- **Key services:** `eventbrite_one_way_sync`, `.session_factory`, `.processor_factory`, `.webhook_manager`, `.config`, `plugin.manager.eventbrite_one_way_sync`.
- **API:** private token per account from `eventbrite_one_way_sync.unversioned:api-keys` (settings.php); base `https://www.eventbriteapi.com/v3`, HTTPS default TLS verification.
- **Webhook:** `Plugin/WebhookReceiverPlugin/Eventbrite` defers + delegates to `WebhookManager` (routes by `config.action`).
- **Security:** no routes defined by this module; webhook exposure/auth is delegated to `webhook_receiver`. The Eventbrite plugin does NOT verify an HMAC/signature on the payload — trust boundary = webhook_receiver's access control. Sync is import-only (no order fulfilment). Tokens are config-only, not hardcoded.

See [configure/setup.md](configure/setup.md).
