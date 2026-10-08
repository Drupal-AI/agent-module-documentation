<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Stackla API SDK (`src/Api`)

A Guzzle-based client library for the Stackla REST API, driven by `StacklaService` (`stackla_widget.stackla_service`).

- `Request` — HTTP transport (`sendGet/sendPost/sendPut/sendDelete`). Constructor builds a `GuzzleHttp\Client`; when `proxy_status` is set it passes `['verify' => FALSE, 'proxy' => …]` (Request.php:105) — TLS verification is then disabled.
- `Credentials` — OAuth2 credentials + `generateToken($client_id, $client_secret, $access_code, $redirect_uri)` (token exchange POST).
- `StacklaModel` — base model with magic get/set, JSON (de)serialization, `create/get/getById/update/delete`.
- `Widget`, `Stack` — concrete models (`widgets`, `stacks` endpoints).

`StacklaService` helpers: `stacklaAuthenticate`, `stacklaIsAuthenticated`, `stacklaGet/Set/UnsetAccessToken` (token in State), `getWidgetsOptions`, `getWidgetsList`, `getIframeById`.

Agent caution: do not enable the proxy in a security-sensitive deployment (disables cert verification); do not enable `debug_mode` where logs are retained (leaks the client secret).
