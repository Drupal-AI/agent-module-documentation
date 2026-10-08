<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
User-defined HTTP callbacks: define **outgoing** webhooks that POST a JSON/XML payload to a remote URL when Drupal entity/system events fire, and **incoming** webhook endpoints that receive signed HTTP POSTs and dispatch them as Drupal events for other modules to handle.

---

Webhooks manages `webhook_config` config entities (admin at `/admin/config/services/webhook`, permission `administer webhooks`), each typed **incoming** or **outgoing** with a payload URL, content type (`application/json`/`application/xml`), an optional HMAC **secret** and/or **token**, selected events, and a non-blocking flag. For **outgoing** webhooks, `webhooks.module` implements core hooks (`hook_entity_insert/update/delete`, `hook_cron`, `hook_user_login/logout/cancel`, `hook_modules_installed`, `hook_file_download`, `hook_cache_flush`) that build a `Webhook` (payload = serialized user/entity/etc.) and call `WebhooksService::send()`, which POSTs the encoded body via Guzzle and, if a secret is set, adds `X-Hub-Signature-256`/`X-Hub-Signature` HMAC headers. For **incoming** webhooks, the open route `POST /webhook/{name}` (`WebhookController::receive`, access always allowed) looks up a matching active incoming config, and — when a secret or signature is present — verifies the HMAC (`Webhook::verify` using `hash_equals`) or token before dispatching a `webhook.receive` event (immediately, or via the `webhooks_dispatcher` queue when non-blocking). Events (`webhook.send`, `webhook.receive`, `webhook.send.error`) let other modules act; the bundled **webhook** submodule subscribes to `receive` and stores each incoming webhook as a `webhook` content entity. Drush commands `webhooks:trigger` and `webhooks:list` round it out. Config: `webhooks.settings` `reliable` (use the reliable queue backend).

---

- POST a webhook to an external service whenever a node/user/any entity is created, updated, or deleted.
- Notify a remote system on user login, logout, or account cancellation.
- Fire a webhook on cron, cache flush, module install, or file download.
- Send outgoing payloads as JSON or XML.
- Sign outgoing webhooks with an HMAC SHA-256 (+ legacy SHA-1) secret so the receiver can verify them.
- Receive inbound webhooks at `POST /webhook/{machine_name}` from third-party services (GitHub, Stripe, …).
- Verify inbound webhook signatures (`X-Hub-Signature-256`/`X-Hub-Signature`) against a shared secret.
- Verify inbound webhooks with a legacy `X-…-Token` header instead of a signature.
- Queue inbound webhooks for background processing (non-blocking) to keep responses fast.
- React to received webhooks in custom code via the `webhook.receive` event.
- React to (or modify logging around) outgoing sends via `webhook.send` / `webhook.send.error` events.
- Store every received webhook as a content entity for auditing (via the `webhook` submodule).
- Register additional custom events for webhooks via `hook_webhooks_event_info_alter`.
- Choose a reliable vs non-reliable queue backend for the dispatcher (`reliable` setting).
- Trigger any configured event manually for testing with `drush webhooks:trigger <event>`.
- Send a test payload/headers/content-type via the Drush trigger options.
- List all configured webhooks (name, machine name, type, status) with `drush webhooks:list`.
- Toggle a webhook active/inactive from the admin list (CSRF-protected route).
- Select exactly which entity types and system events an outgoing webhook subscribes to.
- Integrate Drupal into an automation platform (Zapier/Make/n8n) as event source or sink.
- Build a decoupled architecture where content changes push to a front-end build hook.
- Deliver payloads containing the normalized entity and acting user.
