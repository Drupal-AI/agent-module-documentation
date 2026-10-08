<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `webhooks.service` + the `Webhook` class

Service id **`webhooks.service`** → `Drupal\webhooks\WebhooksService` (implements
`WebhookDispatcherInterface`, `WebhookReceiverInterface`, `WebhookSerializerInterface`).

## Sending (outgoing)

- `triggerEvent(Webhook $webhook, string $event)` — loads all active outgoing configs subscribed to
  `$event` (`loadMultipleByEvent`) and `send()`s to each.
- `send(WebhookConfig $config, Webhook $webhook)` — dispatches `webhook.send`, encodes the payload,
  and if the config has a secret, `Webhook::setSignature()` adds the HMAC headers; then Guzzle
  `POST`s to `$config->getPayloadUrl()` with the webhook headers/body. Failures dispatch
  `webhook.send.error` and log; the send is always logged (subscriber, uuid, event, payload).
  (Self-host requests to the current host get a 0.1s timeout as a local-loop workaround.)

The core-hook triggers in `webhooks.module` build the `Webhook` payload as
`['event' => …, 'user' => normalize(currentUser), 'entity' => normalize($entity)]` (fields vary by
hook) and call `send()` directly for each matching config.

## Receiving (incoming)

`receive(string $name)`:
1. Requires an active `incoming` config with id `$name` (else `WebhookIncomingEndpointNotFoundException`
   → HTTP 404).
2. Decodes the request body per Content-Type into a `Webhook` (uuid/event from `X-Drupal-Delivery` /
   `X-Drupal-Event` headers).
3. **Verification:** if `$config->getSecret()` **or** the request carries a signature →
   `Webhook::verify($secret, $rawBody, $signature)`; else if a secret or token is present →
   `Webhook::verifyToken($config->getToken(), $token)`. A mismatch throws
   `WebhookMismatchSignatureException` (→ HTTP 401) / `WebhookMismatchTokenException`.
   (If a config has neither secret nor token and the request sends no signature/token, no
   verification runs — an intentionally open receiver.)
4. Dispatches `webhook.receive` inline, or `queue('webhooks_dispatcher')->createItem()` when
   `isNonBlocking()` (processed by the `WebhookDispatcher` QueueWorker on cron, re-dispatching
   `webhook.receive`).

`WebhookController::receive()` maps these to `Response` codes 200/404/401.

## `Webhook` (value object, `Drupal\webhooks\Webhook`)

Holds payload, headers, uuid, event, content type, secret, status.

- `setSignature($body)` → adds `X-Hub-Signature-256: sha256=hash_hmac('sha256',$body,$secret)`
  and legacy `X-Hub-Signature: sha1=…`.
- `getSignature()` → prefers `x-hub-signature-256`, falls back to `x-hub-signature`.
- `getToken()` → first header matching `/X-([a-z0-9]+)-Token/i`.
- `static verify($secret, $payload, $signature)` → splits `algo=value`, recomputes
  `hash_hmac($algo,$payload,$secret)`, compares with **`hash_equals`** (timing-safe); throws on mismatch.
- `static verifyToken($token, $received)` → strict `!==` comparison; throws on mismatch.

## Serializer

`encode/decode($data, $format)` proxy the core `serializer` (json/xml). `content_type`
`application/json` → `getMimeSubType()` `json`.
