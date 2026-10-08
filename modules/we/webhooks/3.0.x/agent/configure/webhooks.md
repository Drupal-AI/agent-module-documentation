<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure webhooks

Manage `webhook_config` config entities at `/admin/config/services/webhook`
(`entity.webhook_config.collection`, permission `administer webhooks`). Add form
`WebhookConfigForm`.

## `webhook_config` fields (`config_export`)

| Field | Form element | Meaning |
|---|---|---|
| `id` / `label` | machine_name / textfield | Machine + human name. |
| `type` | select `incoming`\|`outgoing` (locked after create) | Incoming = receive HTTP events; outgoing = POST events to a URL. |
| `content_type` | select | `application/json` or `application/xml`. |
| `secret` | textfield | HMAC secret. Outgoing: signs the payload. Incoming: verifies the sender's signature. Kept if left blank on edit. |
| `token` | textfield | Legacy shared token (verified via an `X-…-Token` header on incoming). |
| `payload_url` | url (outgoing) | Target URL. **Incoming** webhooks store a dummy `http://example.com/webhook` (set in `validateForm`). |
| `events` | tableselect (outgoing) | Which events to send — entity `create`/`update`/`delete` per content entity type, plus system events `cron`, `file_download`, `modules_installed`, `user_cancel`, `user_login`, `user_logout`, `cache_flush`. Options extended via `hook_webhooks_event_info_alter`. |
| `non_blocking` | checkbox (incoming) | Queue received webhooks for later processing instead of dispatching inline. |
| `status` | checkbox | Active/inactive. |

Validation: outgoing requires a `payload_url` and ≥1 event; incoming forces the dummy URL.

## Incoming endpoint

`POST /webhook/{id}` (open route). Only active (`status=1`) incoming configs whose id matches are
accepted; the request body is decoded per its Content-Type and dispatched as `webhook.receive`
(inline, or via the `webhooks_dispatcher` queue when `non_blocking`). Signature/token verification
runs when a secret or signature/token is present — see [../api/service.md](../api/service.md).

## Settings (`webhooks.settings`)

Route `/admin/config/services/webhook/settings` (`SettingsForm`, `administer webhooks`).

| Key | Default | Meaning |
|---|---|---|
| `reliable` | `false` | Use the reliable queue backend for `webhooks_dispatcher` (durable but slower) vs the default memory/db queue. |

## Toggle active

`/admin/config/services/webhook/{id}/toggle_active` (`WebhookController::toggleActive`,
`_permission: administer webhooks`, `_csrf_token: TRUE`) flips `status`.
