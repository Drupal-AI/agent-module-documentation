<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webhooks — agent index

User-defined HTTP callbacks. **Outgoing** webhooks POST a payload to a URL on Drupal events;
**incoming** webhooks receive signed POSTs at `/webhook/{name}` and dispatch them as events.
Admin at `/admin/config/services/webhook` (`entity.webhook_config.collection`). Depends on
`serialization`. Submodule `webhook` (own docs below).

- **The `webhook_config` entity, add/edit form fields, incoming vs outgoing, `webhooks.settings`** →
  [configure/webhooks.md](configure/webhooks.md)
- **`WebhooksService` (send/receive/triggerEvent), the `Webhook` class, signature/token verification** →
  [api/service.md](api/service.md)
- **Events (`webhook.send`/`receive`/`send.error`) + `webhooks_event_info` alter** → [hooks/events.md](hooks/events.md)
- **Drush `webhooks:trigger` / `webhooks:list`** → [drush/drush.md](drush/drush.md)
- **Permissions** → [permissions/permissions.md](permissions/permissions.md)

Submodule:
- `webhook` (stores received webhooks as content entities) →
  [../../modules/webhook/3.0.x/agent/start.md](../../modules/webhook/3.0.x/agent/start.md)

Key facts:
- Config entity `webhook_config` (`config_prefix: webhook`, `admin_permission: administer webhooks`):
  `payload_url`, `type` (incoming|outgoing), `events`, `content_type`, `secret`, `token`, `non_blocking`.
- Outgoing trigger: `webhooks.module` core hooks → `WebhooksService::send()` → Guzzle POST with
  `X-Hub-Signature-256`/`X-Hub-Signature` HMAC headers when a secret is set.
- Incoming route: `POST /webhook/{incoming_webhook_name}`, `_custom_access` = `AccessResult::allowed()`
  (open); `WebhooksService::receive()` verifies HMAC (`Webhook::verify`, `hash_equals`) or token
  **only when** a secret/signature/token is present, then dispatches `webhook.receive`.
- Non-blocking incoming webhooks go through queue `webhooks_dispatcher` (cron worker); `reliable`
  setting picks the queue backend.
