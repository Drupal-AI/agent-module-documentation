<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Sending messages, the JWT, and the JS client

Two services (`driplet.services.yml`), both built from `@config.factory`:
`driplet.service` → `DripletService`, `driplet.jwt_manager` → `JWTManager`.

## `DripletService` (send from PHP)

`src/Service/DripletService.php` wraps the vendor `Driplet\Client\DripletClient`. The constructor
reads `driplet.settings` and builds the client from `driplet_api_endpoint` + `driplet_api_secret`.

- `createMessage(): MessageBuilder` — returns a fresh `Driplet\Message\MessageBuilder`.
- `sendMessage(MessageBuilder $builder): bool` — sends it; a vendor `DripletException` is rethrown as
  a `\RuntimeException`.

Typical call:

```php
$driplet = \Drupal::service('driplet.service');
$msg = $driplet->createMessage()
  ->setMessage(['some' => 'content'])   // arbitrary payload array
  ->setTopic('some-topic')              // required, else build() throws
  ->include()                           // switch target context to "include"
  ->setTarget('roles', 'authenticated') // or setTarget('uid', [1,2])
  ->exclude()->setTarget('uid', 5);     // optional exclusion context
$driplet->sendMessage($msg);
```

### MessageBuilder targeting model (vendor `Driplet\Message\MessageBuilder`)

- `setMessage(array)`, `setTopic(string)` — topic is mandatory.
- `include()` / `exclude()` switch which target bucket subsequent `setTarget()` calls fill (via
  internal references to `target['include']` / `target['exclude']`).
- `setTarget(string $key, mixed $value)` — merges values (scalars are wrapped in an array,
  de-duplicated). Keys are free-form (the microservice interprets `uid`, `roles`, etc.).
- `build()` returns `['nonce' => random_bytes hex, 'timestamp' => time(), 'message' => …,
  'target' => ['include'/'exclude' => …], 'topic' => …]`; throws if message or topic is unset.

### How the vendor client transmits (`Driplet\Client\DripletClient::sendMessage`)

`json_encode`s the built payload, computes `hash_hmac('sha256', $json, $api_secret)`, and POSTs to
`driplet_api_endpoint` via Guzzle (`Driplet\Http\GuzzleHttpClient`) with headers
`X-Driplet-Signature: <hmac>` and `Content-Type: application/json`; returns true on HTTP 200. Guzzle
runs at its default TLS behavior (no `verify` override). The API secret is an HMAC key, not sent in
the request body.

## JWT for the browser

### `JWTManager` (`src/Service/JWTManager.php`)

Constructor reads `driplet_jwt_secret` and instantiates the vendor `Driplet\Token\JwtManager`
(which throws if the secret is empty). `generateToken(AccountInterface $user)` returns
`$vendor->generateToken(['uid' => $user->id(), 'roles' => $user->getRoles()])`.

The vendor `Driplet\Token\JwtManager::generateToken()` builds
`['exp' => time()+60, 'iat' => time(), 'custom' => $claims]` and signs with
`Firebase\JWT\JWT::encode($payload, $secret, 'HS256')` — a symmetric HS256 token, ~60-second
lifetime, with uid/roles nested under `custom`. Signature **verification happens in the external
microservice**, not in this module (the module only issues tokens).

### `DripletController::generateJwt` (`src/Controller/DripletController.php`)

Route `driplet.jwt` (`/api/driplet/jwt`, `_access: 'TRUE'`, `no_cache: TRUE`). Calls
`jwtManager->generateToken($this->currentUser())` and returns
`JsonResponse(['status' => 'success', 'message' => 'JWT token generated', 'token' => <jwt>])`. The
token always encodes the *current session user's own* uid/roles (anonymous → uid 0).

## Front-end client (`js/driplet-client.js`, library `driplet/driplet`)

Exposes `window.DripletClient`, an IIFE singleton keyed by WebSocket endpoint:

- `DripletClient.getInstance(wsEndpoint, jwtEndpoint)` — returns/creates one client per endpoint and
  auto-connects. Direct `new` throws; always use `getInstance()`.
- `connect()` — `_fetchToken()` GETs `jwtEndpoint` with `credentials: 'same-origin'`, then opens
  `new WebSocket(`${wsEndpoint}?token=${encodeURIComponent(token)}`)` (token passed as a query param).
- `setTopics([...])` / `subscribe(topic)` / `unsubscribe(topic)` — send `{type:'subscribe'|
  'unsubscribe', topic}` frames; topics are re-subscribed on (re)connect.
- `onMessage(cb)` — registers a callback (returns an unsubscribe fn); each inbound frame is
  `JSON.parse`d and passed to every callback. Callers filter by `data.topic` themselves.
- `disconnect()`, `isConnected()`, and auto-reconnect with exponential backoff
  (`maxReconnectAttempts = 5`, delay doubles from 1000ms).

The submodules call `DripletClient.getInstance(drupalSettings.driplet.ws_endpoint,
window.location.origin + '/api/driplet/jwt')`.
