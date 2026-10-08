<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Inbound callback endpoint & `hook_process_dropbox_sign_callback()`

## The route

`dropbox_sign.signature_callback` → **POST** `/process-dropbox-sign-callback`, handled by
`Drupal\dropbox_sign\Controller\DropboxSignController::signatureCallback()`
(`src/Controller/DropboxSignController.php`). Requirement is `_access: TRUE` and `methods: [POST]`:
the endpoint is intentionally anonymous so Dropbox Sign's servers can post event notifications to it.
Register this URL in your Dropbox Sign account. The controller injects `@config.factory`,
`@encryption`, `@logger.channel.dropbox_sign`, `@module_handler`, `@datetime.time`.

## What the controller does (in order)

1. Requires a `json` POST parameter; if absent, logs an error and throws `AccessDeniedHttpException`.
2. `json_decode()`s it; if it does not parse, logs and throws `AccessDeniedHttpException`.
3. Reads `event->event_hash`, `event->event_time`, `event->event_type`.
4. If `event_type == 'callback_test'`, returns `Response('Hello API Event Received')` immediately
   (this is the connectivity test Dropbox Sign fires when you set the callback URL; no hook is
   invoked and no state changes).
5. Reads `signature_request->signature_request_id`.
6. **Replay window:** if `event_time < (request_time - 86400)` (older than 24 hours), logs and throws
   `AccessDeniedHttpException`.
7. **Authenticity:** decrypts the stored `api_key` and requires
   `hash_hmac('sha256', $event_time . $event_type, $api_key) === $event_hash` (strict comparison);
   if there is no key or the HMAC does not match, logs and throws `AccessDeniedHttpException`.
8. Only then logs an info line and calls
   `moduleHandler->invokeAll('process_dropbox_sign_callback', [$data])`.
9. Returns `Response('Hello API Event Received')` (plain text, per the API spec — do not change).

The controller itself changes no Drupal state; all reactions happen in hook implementations, and they
run only after the timestamp + HMAC checks pass.

## The hook — `hook_process_dropbox_sign_callback($data)`

Documented in `dropbox_sign.api.php`. Implement it in a custom module to react to verified events.
`$data` is the decoded Dropbox Sign event object; useful fields include
`$data->event->event_type` and `$data->signature_request->signature_request_id`. Event types are
defined by Dropbox Sign (e.g. `signature_request_signed`). Example from the API file:

```php
function hook_process_dropbox_sign_callback($data) {
  if ($data->event->event_type === 'signature_request_signed') {
    \Drupal::logger('dropbox_sign')->info(
      'Someone has signed Dropbox signature request @id.',
      ['@id' => $data->signature_request->signature_request_id]
    );
  }
}
```

Use this hook to update entity/workflow state, notify users, or fulfil an action when a document is
signed. Because the controller has already authenticated the event, your implementation can trust
`$data`.
