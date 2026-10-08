<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce OPP Webhooks (commerce_opp_webhooks) — agent index

Optional submodule of **[commerce_opp](../../../../commerce_opp/2.0.x/agent/start.md)**. Provides the
public OPPWA webhook endpoint and asynchronous (Advanced Queue) processing of payment notifications.
Version **2.0.12**, core `^9.5 || ^10 || ^11`. Dependencies: `commerce_opp`, `advancedqueue:advancedqueue`.
Not declared in the parent `composer.json` — add `drupal/advancedqueue` yourself before enabling.

- **Endpoint auth, queue job, config** → [configure/settings.md](configure/settings.md)

## What it provides

- **Route** `commerce_opp_webhooks.webhooks_endpoint`: `POST /opp/webhooks`, controller
  `WebhooksController::endpoint`, `_access: TRUE`, `no_cache`. Access control is the AES-256-GCM crypto itself
  (see below), not a route permission.
- **Controller** `WebhooksController` (`modules/webhooks/src/Controller/`):
  - Requires headers `X-Initialization-Vector` and `X-Authentication-Tag` (403 if absent) and a non-empty
    `commerce_opp.settings:encryption_secret` (400 if unset — **fails closed**).
  - `decrypt()` = `openssl_decrypt($cipher, "aes-256-gcm", hex2bin($secret), OPENSSL_RAW_DATA, hex2bin($iv), hex2bin($tag))`;
    a body that fails the GCM authentication tag decrypts to FALSE → `[]` → 400.
  - Handles notification `type` **PAYMENT** (payment types `DB`, `CP`, `RC`, `PA`) and **TEST**;
    `REGISTRATION` / `RISK` / others → 400.
  - Loads the payment by remote id (fallback: by `ndc` checkout id), skips already-completed payments,
    runs `$gateway->processTransactionStatus($payment, $payload)` (which binds amount to the order), and for
    non-pending results enqueues a job with the resolved transition (`authorize` / `authorize_capture` /
    `capture` / `void`). Returns `{"processed": true|false}`.
- **AdvancedQueue job type** `commerce_opp_webhooks` (`Plugin/AdvancedQueue/JobType/ProcessOppWebhook`,
  `max_retries = 3`, `retry_delay = 1800`): re-checks completed/allowed-transition state, creates/updates the
  payment method, applies the transition, and places the order on `authorize`.
- **Queue** config `advancedqueue.advancedqueue_queue.commerce_opp_webhooks` (database backend, cron processor).
- **Config** `commerce_opp_webhooks.settings`: `queue_delay` (int seconds, default 0) — delay before enqueued
  jobs become processable. Configured via the parent `commerce_opp.settings` form (`configure` points there).
- **Install**: `commerce_opp_webhooks_update_8101` seeds `queue_delay`. The parent's
  `commerce_opp_update_8202` auto-installs this submodule if an `encryption_secret` was already set.

## Setup

1. `composer require drupal/advancedqueue` then `drush en commerce_opp_webhooks -y`.
2. In the OPP provider backend, register `https://YOURDOMAIN/opp/webhooks`, check only PAYMENT types
   `DB`/`PA`/`CP`/`RC`, wrapper `None`, and set an encryption secret.
3. At `/admin/commerce/config/payment/opp`, enter the **same** secret in *Webhooks encryption secret*.
4. Consider disabling *Process pending payment intents on cron* on gateways that now have an active webhook.
