<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webhooks — configuration, dispatch API, delivery

## Install / enable

`drush en advanced_filesystem_webhooks`. Pulls in `advanced_filesystem` and core `file`.
`.install` `hook_schema()` creates table **`adfs_webhook_log`** (id, event, url, http_status,
success, attempt, error, delivered_at; indexes on delivered_at/event/success).

## Config object `advanced_filesystem_webhooks.settings`

Install defaults (`config/install/…settings.yml`), schema in `config/schema/…schema.yml`:

- `enabled` (bool, default **false**) — master switch; `WebhookDispatcher::dispatch()` returns 0 when off.
- `async` (bool, default true) — queue vs. inline delivery.
- `timeout` (int, 10) — per-request HTTP timeout (also used as connect_timeout).
- `max_attempts` (int, 3) — total delivery attempts before an item is dropped.
- `site_name` (string, '') — echoed into every payload as `site`.
- `log_retention_days` (int, 30) — cron prunes `adfs_webhook_log` rows older than this; 0 = keep forever.
- `endpoints` (sequence) — each: `url` (string), `secret` (string, HMAC key), `active` (bool),
  `events` (sequence of event machine names).

`Form\WebhookSettingsForm` renders global options plus one `details` fieldset per endpoint and a
trailing blank one to add another. `validateForm()` requires each non-removed URL to pass
`FILTER_VALIDATE_URL` and match `^https?://`. `submitForm()` rebuilds the whole `endpoints` list.
The HMAC secret is a plain textfield; the URL is a `url` element (maxlength 512).

## Events and payload

`Service\WebhookDispatcher` constants: `EVENT_FILE_UPLOAD='file.upload'`,
`EVENT_FILE_DELETE='file.delete'`, `EVENT_ANTIVIRUS_INFECTED='antivirus.infected'`,
`EVENT_QUOTA_EXCEEDED='quota.exceeded'`, `EVENT_LGPD_FINDING='lgpd.finding'`.
`eventLabels()` maps them to human labels for the form checkboxes.

`.module` fires two of them: `hook_file_insert` → `dispatch('file.upload', payload)` and
`hook_file_delete` → `dispatch('file.delete', payload)`. `_advanced_filesystem_webhooks_file_payload()`
builds `{fid, filename, uri, mime, size, uid, url}` from the `FileInterface`. The three remaining
events are meant to be raised by sibling sub-modules calling the dispatcher directly.

Wire body: `{ "event": <name>, "timestamp": <request time>, "site": <site_name>, "data": <payload> }`.

## Dispatch API (`WebhookDispatcher`)

- `dispatch(string $event, array $payload=[]): int` — no-op if `enabled` is false; finds active
  endpoints subscribed to `$event` (`subscribedEndpoints()` checks `active` + in_array on `events`);
  for each, either `queue->createItem(['endpoint','event','body','attempt'=>0])` (async) or calls
  `deliver()` inline. Returns the number of endpoints dispatched to.
- `deliver(array $endpoint, string $event, array $body, int $attempt=0): bool` — JSON-encodes the
  body, computes `X-ADFS-Signature: sha256=` . `hash_hmac('sha256', $json, $secret)` when the
  endpoint secret is non-empty, sets `X-ADFS-Event` and a random `X-ADFS-Delivery` id, POSTs via
  `@http_client` with `http_errors=false`, logs the outcome to `adfs_webhook_log`. 2xx ⇒ success.
- `maxAttempts()`, `getEndpoints()`, `isEnabled()`, static `eventLabels()`.

Delivery uses Drupal's shared Guzzle `http_client` with default options (standard TLS verification;
no custom `verify`).

## Queue worker

`Plugin\QueueWorker\WebhookDeliveryWorker` (id `advanced_filesystem_webhook_delivery`, cron 30 s):
`processItem()` calls `dispatcher->deliver(endpoint,event,body,attempt)`; on failure, if
`attempt+1 < maxAttempts()` it re-queues the item with an incremented attempt, otherwise drops it
(the failure is already logged).

## Delivery log and test

`Controller\WebhookLogController::page()` lists the last 200 `adfs_webhook_log` rows (event,
endpoint, status badge, attempt, error, delivered time). `::test(int $index)` builds a `test.ping`
body and calls `deliver()` on endpoint `$index`, then redirects to the log. Its route
`advanced_filesystem_webhooks.test` additionally requires `_csrf_token: 'TRUE'`; the settings form
renders the "Send test event" links with the CSRF token in the query.

`hook_cron` deletes `adfs_webhook_log` rows with `delivered_at < now - log_retention_days*86400`
(skipped when retention is 0).
