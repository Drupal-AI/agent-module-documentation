<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Iplicit API — client service

Inject `@iplicit_api.client` (interface `Drupal\iplicit_api\Service\IplicitClientInterface`). It builds requests through `HttpClientBuilder` (Guzzle via core `ClientFactory`, `Domain` default header, default TLS verification) and authenticates via `SessionManager`.

- `SessionManager::getSession()` returns a cached `IplicitSession` or POSTs `{username, userApiKey}` to `/api/Session/create/api` to mint one; cached in `cache.default`, keyed `iplicit_api:session:<fingerprint>`, expiry = `min(tokenDue - 60s, now + 1800s)`.
- `SessionManager::invalidate()` drops the cached token; the client calls this when Iplicit returns 401.
- Resource classes are thin wrappers over the client and are **not** registered as services — a consumer module wires only the few it uses (see the module README).

Exceptions all derive from this module: `IplicitConfigurationException` (misconfiguration), `IplicitAuthenticationException` (session/credential rejection). Errors log the key *ID* and username but never the secret or token.
