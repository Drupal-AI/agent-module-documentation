<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webhook (submodule of Webhooks) — agent index

Persists **received** (incoming) webhooks as `webhook` content entities — an audit trail of inbound
payloads. Depends on the parent `webhooks` module. No config page (`configure` null), no Drush.

- **The `webhook` entity, its fields, and the `webhook.receive` subscriber** →
  [api/entity.md](api/entity.md)

Key facts:
- Content entity **`webhook`** (base table `webhook`, `admin_permission: access webhook overview`),
  admin list at `/admin/content/webhook`. Base fields: `title`, `headers`, `payload`, `created`.
- `WebhookSubscriber::onWebhookReceive()` listens on `WebhookEvents::RECEIVE` (`webhook.receive`) and
  saves a `webhook` entity with `title = "Webhook {uuid}"`, `headers`/`payload` = `json_encode(...)`.
- Permission `access webhook overview` (not `restrict access: true`) gates the overview list.
- Parent framework docs → [../../../../3.0.x/agent/start.md](../../../../3.0.x/agent/start.md)
