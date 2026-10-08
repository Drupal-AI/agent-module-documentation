<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Endpoint, authentication, queue & config

## Endpoint

Route `commerce_opp_webhooks.webhooks_endpoint` — `POST /opp/webhooks`
(`modules/webhooks/commerce_opp_webhooks.routing.yml`), controller `WebhooksController::endpoint`,
`_access: TRUE`, `no_cache: TRUE`. Returns `application/json` `{"processed": true|false}`.

## Authentication (AES-256-GCM)

OPPWA sends the notification body encrypted. `WebhooksController::endpoint()`:

1. Reads headers `X-Initialization-Vector` and `X-Authentication-Tag`; **403** if either is missing.
2. Reads `commerce_opp.settings:encryption_secret`; **400** if empty (fails closed — the endpoint accepts
   nothing when no secret is set).
3. `decrypt($body, $iv, $tag, $secret)` runs
   `openssl_decrypt(hex2bin($body), "aes-256-gcm", hex2bin($secret), OPENSSL_RAW_DATA, hex2bin($iv), hex2bin($tag))`.
   The GCM authentication tag verifies integrity and authenticity; a forged/tampered body decrypts to FALSE →
   `[]` → **400**. So a caller without the secret cannot drive fulfilment.

The secret must be identical on the OPP side and in Drupal. Store it as a protected secret (env var + Key
entity, or override in `settings.php`), not in exported config.

## Notification handling

- `type` **PAYMENT**: only payment types `DB`, `PA`, `CP`, `RC` are accepted (others → 400). The payment is
  loaded by remote id, or by `ndc` (checkout id) fallback. Already-completed payments are skipped
  (`{"processed": false}`). `processTransactionStatus()` maps the payload and binds the paid amount to the
  order; non-pending results enqueue a job carrying the resolved transition
  (`authorize` / `authorize_capture` / `capture` / `void`) plus brand / registration / card / bank / VA info.
- `type` **TEST**: logged, `{"processed": true}`.
- `REGISTRATION`, `RISK`, anything else: **400**.

## Async processing

Job type `commerce_opp_webhooks` (`ProcessOppWebhook`, `max_retries = 3`, `retry_delay = 1800`s) on queue
`commerce_opp_webhooks` (config `advancedqueue.advancedqueue_queue.commerce_opp_webhooks`, database backend,
`processor: cron`, lease 300s, processing 90s, rate threshold 60). `process()` re-verifies the payment is not
already completed and the transition is allowed, creates/updates the payment method (card/paypal/brand),
applies the transition, sets remote id/state, and — on `authorize` — places the order and unlocks it.

## Config `commerce_opp_webhooks.settings`

- `queue_delay` (integer seconds, default `0`) — delay after which enqueued jobs become available for
  processing. Schema in `modules/webhooks/config/schema/`; install default in `config/install/`.

Set it (and the parent's `encryption_secret`) via the parent settings form at
`/admin/commerce/config/payment/opp` (this submodule's `configure` link points there).
