<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Transport internals (factory + GraphApiTransport)

Two moving parts turn the `microsoft-graph-api` DSN into sent mail: the **factory** and the
**transport**.

## Services (`symfony_mailer_lite_microsoft.services.yml`)

- `symfony_mailer_lite_microsoft.microsoft_transport_factory` — class
  `Drupal\symfony_mailer_lite_microsoft\Transport\GraphApiTransportFactory`, `autowire: true`,
  tagged `symfony_mailer_lite.transport_factory` with `priority: -100`. It is injected the module's
  cache bin (`$cache`) and logger channel (`$logger`).
- `cache.symfony_mailer_lite_microsoft` — a dedicated cache bin (`cache.bin` tag) built from
  `@cache_factory`.
- `logger.channel.symfony_mailer_lite_microsoft` — logger channel `symfony_mailer_lite_microsoft`.

Symfony Mailer Lite collects all `symfony_mailer_lite.transport_factory`-tagged services and asks
each factory's `getSupportedSchemes()`; this one claims only `microsoft-graph-api`.

## Factory — `GraphApiTransportFactory::create(Dsn $dsn)`

- Rejects any scheme other than `microsoft-graph-api` (`UnsupportedSchemeException`).
- Maps DSN parts to constructor args (note the ordering):
  - `$dsn->getHost()` → `graphTentantId` (tenant)
  - `$dsn->getUser()` → `graphClientId`
  - `$dsn->getPassword()` → `graphClientSecret`
  - `$dsn->getOption('from') ?? ''` → `from`
- Returns `new GraphApiTransport($tenant, $clientId, $clientSecret, $from, $cache, $client, $dispatcher, $logger)`.

## Transport — `GraphApiTransport extends AbstractApiTransport`

`__toString()` masks the secret: `microsoft-graph-api://<client_id>:{SECRET}@<tenant>`.

### OAuth2 token (`requestAccessToken()`, `GraphApiTransport.php:165`)

- `POST https://login.microsoftonline.com/<tenant>/oauth2/v2.0/token` with form body
  `client_id`, `client_secret`, `scope=https://graph.microsoft.com/.default`,
  `grant_type=client_credentials`.
- Reads `access_token` and `expires_in` from the JSON response.
- Caches the token in bin `symfony_mailer_lite_microsoft`, key `email-token`
  (`GraphApiTransport::CACHE_KEY`). `getToken()` returns the cached value if present, else requests a
  fresh one.
- HTTP calls use the injected Symfony HTTP client with default settings — **TLS verification is on**
  (no `verify_peer`/`verify_host` override).

### Send (`doSendApi()`, `GraphApiTransport.php:42`)

- `POST https://graph.microsoft.com/v1.0/users/<from>/sendMail` with `auth_bearer` = token and a JSON
  body from `normalizeEmail()`.
- Endpoint host is `<from>` (the configured sender / envelope sender) — see `getEndpoint()`.
- Success is HTTP **202**; any other status logs the Graph response body at `error` level to the
  `symfony_mailer_lite_microsoft` channel and throws `HttpTransportException`.

### Payload mapping (`normalizeEmail()` and helpers)

- `message.subject` ← `Email::getSubject()`.
- `message.toRecipients` / `ccRecipients` / `bccRecipients` ← addresses mapped to
  `{ emailAddress: { address, name? } }` (`normalizeAddress()` / `normalizeAddresses()`).
- `message.body` ← HTML body if present (`contentType: html`), else text body (`contentType: text`),
  else `[]` (`normalizeBody()`).
- `message.attachments` ← each attachment as `#microsoft.graph.fileAttachment` with
  `contentType`, base64 `contentBytes`, and `name` from the Content-Disposition filename
  (`normalizeAttachments()`).
- `saveToSentItems` ← `true` unless header `X-Save-To-Sent-Items` has body `false`
  (`normalizeSaveToSentItems()`).

## Notes / gotchas

- No OAuth authorization-code callback exists (app-only `client_credentials`), so there is no
  redirect URI, `state`, or CSRF surface in this module.
- Cache TTL quirk: `requestAccessToken()` computes `expiryTime = expires_in - 60` and passes it as the
  cache `$expire` argument. `CacheBackendInterface::set()` expects an **absolute Unix timestamp**, but
  `expires_in` is a relative duration (e.g. `3599`), so the item is effectively already expired and a
  new token is requested on nearly every send. Functional/efficiency issue, not a correctness blocker
  (each send still gets a valid token).
- Tests: `tests/src/Unit/MicrosoftTransportTest.php` (form + DSN), with
  `tests/src/Unit/TestGraphApiTransport.php` overriding `getToken()` to bypass the network.
