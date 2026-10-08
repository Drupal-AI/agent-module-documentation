<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DropWatchApiClient — the outbound HTTP client

`src/Client/DropWatchApiClient.php`, service id **`dropwatch.client`**
(args: `@settings`, `@http_client`).

## Target

- `protected $address = 'https://dropwatch.sh';` and `protected string $endpoint = '/api/v1/update';`
  are **hard-coded**. The request goes to `https://dropwatch.sh/api/v1/update`. The destination is
  not taken from config or from the request, so there is no caller-controlled URL.

## `sendUpdate(array $payload): int`

- Reads the token: `$this->token = $this->settings::get('dropwatch_api_token', '');` — i.e. from
  Drupal core `Settings` (`$settings['dropwatch_api_token']` in `settings.php`), defaulting to `''`.
- POSTs via the injected Guzzle client:
  ```php
  $this->client->post("{$this->address}{$this->endpoint}", [
    'headers' => [
      'Authorization' => 'Bearer ' . $this->token,
      'Accept' => 'application/json',
    ],
    'json' => $payload,
  ]);
  ```
- HTTP method **POST**; body sent as JSON (`json` option). Auth via **`Authorization: Bearer <token>`**.
- Returns the response HTTP status code (`$response->getStatusCode()`). No use of the response body.
- No Guzzle options overriding TLS — the default (verify peer/host) applies. No retry/timeout options set.
- Exceptions are not caught here; the caller (`DropWatchService::sendApiRequest()`) wraps the call in
  try/catch and logs failures.
