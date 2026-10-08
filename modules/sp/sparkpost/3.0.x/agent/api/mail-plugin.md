<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Sparkpost mail plugin and API client

## Mail plugin — `Drupal\sparkpost\Plugin\Mail\SparkpostMail`

`@Mail` id `sparkpost_mail`, implements `MailInterface` + `ContainerFactoryPluginInterface`.

- **`format($message)`** — joins `body` array with blank lines and strips CR/LF from `subject`.
- **`mail($message)`** — builds and sends the SparkPost transmission:
  - If `format` config is set, runs `check_markup($body, $format)`.
  - Headers: merges `params['sparkpost']['header']`, defaults `Reply-To` to the message `from`
    (SparkPost needs the from address configured separately, so per-message from becomes reply-to),
    then reduces headers to a whitelist (`X-*`, `Return-Path`, `Cc`) via `allowedHeaders()`.
  - Recipients: `createRecipientField()` parses the comma-separated `to` (supports
    `Name <addr>` via `ClientService::EMAIL_REGEX`); `Cc`/`Bcc` are parsed by `createCcField()`
    and merged into the recipient list (Bcc handled by omitting `header_to`).
  - Attachments: each existing file in `message['attachments']` is base64-encoded
    (`chunk_split`) with a MIME type from `file.mime_type.guesser`; `isValidContentType()`
    restricts to `image/*`, `text/*`, `application/pdf`, `application/x-zip` (throws otherwise).
  - Plaintext: `params['plaintext']` if given, else `MailFormatHelper::htmlToText($body)`.
  - Payload shape (merged over `params['sparkpost']['overrides']`):
    ```
    content: { from:{name,email}, html, text, subject, attachments, reply_to, headers }
    recipients: [ {address:{name,email}}, ... ]
    campaign_id: substr(message.id, 0, 64)
    options: { transactional: true }
    ```
  - Fires `\Drupal::moduleHandler()->alter('sparkpost_mail', $sparkpost_message, $message)`
    (i.e. `hook_sparkpost_mail_alter()`) before sending.
  - If `async` config is on: serialises the `sparkpost.message_wrapper` into the
    `sparkpost_send` queue and returns TRUE. Otherwise calls `MessageWrapper::sendMessage()`.
  - On exception: returns FALSE, and if `debug` is on logs via `watchdog_exception`.

## Message wrapper — `Drupal\sparkpost\MessageWrapper` (service `sparkpost.message_wrapper`)

Holds the Drupal message, the SparkPost payload, the result, and any `SparkPostException`.
`sendMessage()` calls the client, and on success invokes `hook_sparkpost_mailsend_success()`, on
`SparkPostException`/error invokes `hook_sparkpost_mailsend_error()` (the requeue hook). Uses
`DependencySerializationTrait` so it survives queue serialisation.

## API client — `Drupal\sparkpost\ClientService` (service `sparkpost.client`)

Constructed with `@http_client` (Drupal's Guzzle client) and `@config.factory`.

- `getClient()` wraps `@http_client` in the php-http Guzzle adapter (`Http\Adapter\Guzzle7\Client`,
  falling back to Guzzle6) and constructs `new SparkPost($httpClient, ['key' => api_key, 'host' =>
  api_hostname])` from the `sparkpost/sparkpost` v2 SDK.
- `sendMessage($message)` → `$client->transmissions->post($message)->wait()` (i.e.
  `POST https://<host>/api/v1/transmissions`), JSON-decodes a stream body, logs+rethrows on error.
- `sendRequest($endpoint, $data, $method)` → generic `$client->request(...)` passthrough.
- **Transport/TLS:** because the SDK is handed Drupal's `http_client`, requests use Drupal's
  default HTTP configuration — TLS certificate verification is **on** (the module does not pass
  `verify => false` or disable `CURLOPT_SSL_VERIFYPEER`). The API key travels to SparkPost in the
  SDK's `Authorization` header over that verified connection.

## Extension hooks (`sparkpost.api.php`)

- `hook_sparkpost_mail_alter(&$sparkpost_message, &$message)` — rewrite the outbound payload.
- `hook_sparkpost_mailsend_success(MessageWrapperInterface $wrapper)` — after a successful send.
- `hook_sparkpost_mailsend_error(MessageWrapperInterface $wrapper)` — after a failed send
  (implemented by sparkpost_requeue).

## No inbound endpoints

There is **no** routing entry that SparkPost calls back into — no bounce/event webhook, no
signature-verification code, nothing anonymous. `sparkpost.routing.yml` defines only the two
admin-gated forms. Delivery/event feedback is not consumed by this module.
