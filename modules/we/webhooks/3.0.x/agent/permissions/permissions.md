<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webhooks permissions

| Permission | Module | Gates |
|---|---|---|
| `administer webhooks` | webhooks | All `webhook_config` operations (add/edit/delete/toggle), the settings form, and the collection UI. It is the `admin_permission` of the `webhook_config` config entity. Not flagged `restrict access: true`, but it is a `/admin/config/services` config permission that lets its holder set outbound POST target URLs and secrets — grant only to trusted administrators. |
| `access webhook overview` | webhook (submodule) | View the received-webhook content-entity list at `/admin/content/webhook`. Also the `admin_permission` of the `webhook` content entity. |

The incoming receiver route (`POST /webhook/{name}`) is intentionally **not** permission-gated
(`_custom_access` = `AccessResult::allowed()`); it is instead protected per-webhook by the optional
HMAC secret / token verified in `WebhooksService::receive()`.
