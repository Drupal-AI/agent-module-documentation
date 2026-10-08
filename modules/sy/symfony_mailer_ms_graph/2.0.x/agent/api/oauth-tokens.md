<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# OAuth flow, tokens & cron

The delegated authorization-code flow, both token managers, State storage, and automatic renewal. Source: `src/Controller/`, `src/*TokenManager.php`, `src/Service/`, `src/Hook/`, `*.routing.yml`.

## Routes & permission

`symfony_mailer_ms_graph.routing.yml` — all three require permission `administer symfony mailer ms graph` (defined in `*.permissions.yml`, `restrict access: TRUE`), all `no_cache: TRUE`:
- `symfony_mailer_ms_graph.oauth_login` — `/admin/config/system/symfony-mailer-ms-graph/oauth-login` → `OAuthLoginController::login`.
- `symfony_mailer_ms_graph.oauth_callback` — `/symfony-mailer-ms-graph/oauth-callback` → `OAuthCallbackController::callback`.
- `symfony_mailer_ms_graph.refresh_token` — `/admin/config/system/symfony-mailer-ms-graph/refresh-token` → `TokenRefreshController::refresh`; additionally `_csrf_token: 'TRUE'`.

## Delegated authorization-code flow

1. **Login** (`OAuthLoginController::login`): reads `tenant_id`/`client_id` via `DelegatedTransportConfig`; errors back to the transport list if unset. Generates a random `state` (`Crypt::randomBytesBase64(32)`), stores it in the session (`SESSION_STATE_KEY`), and returns a `TrustedRedirectResponse` to `https://login.microsoftonline.com/<tenant>/oauth2/v2.0/authorize` with `scope=https://graph.microsoft.com/Mail.Send offline_access`, `response_type=code`, and the callback route as `redirect_uri`.
2. **Callback** (`OAuthCallbackController::callback`): 404s unless `code` or `error` present. Reads and removes the session state, and rejects the request unless `hash_equals()` matches the returned `state` (login-CSRF protection). On an OAuth `error` it logs and redirects back. Otherwise it POSTs `grant_type=authorization_code` (with the resolved client secret) to the token endpoint; on HTTP 200 it stores the returned `refresh_token` **encrypted** in State and records the obtained time, clears the needs-reauthorization flag, and messages success (warns if no refresh token returned → check `offline_access`).

## Token managers (send path)

- `AppTokenManager` (client-credentials, no refresh token): `getToken()` returns the in-memory or State-cached token if unexpired, else POSTs `grant_type=client_credentials`, `scope=.../.default` to `https://login.microsoftonline.com/<tenant>/oauth2/v2.0/token`, caches the access token **encrypted** in State (`application_access_token` / `_expires`). The client secret constructor param is `#[\SensitiveParameter]`.
- `DelegatedTokenManager` (refresh_token grant): same caching (`delegated_access_token` / `_expires`); on refresh it also persists any rotated `refresh_token` back to State (`symfony_mailer_ms_graph.refresh_token`). Both throw `HttpTransportException` on transport failure or non-200.

## TokenRefreshService (cron + manual)

`Service\TokenRefreshService` (`symfony_mailer_ms_graph.token_refresh`) handles standalone refresh-token renewal for the fixed delegated transport:
- State keys: `refresh_token`, `refresh_token_obtained`, `needs_reauthorization`. `REFRESH_TOKEN_LIFETIME` = 90 days (display estimate only).
- `isRenewalDue()` — true when `now >= obtained + renewal_days*86400` (renewal_days from the transport config, default 60).
- `refresh()` — decrypts the stored refresh token, resolves tenant/client/secret, POSTs `grant_type=refresh_token` to the token endpoint; on success stores the new (encrypted) refresh token + obtained time and clears the reauth flag. `handleTokenError()` detects `invalid_grant` and sets `needs_reauthorization` + an admin message telling them to re-authorize.
- `getStatus()` — returns `has_refresh_token`, `needs_reauthorization`, `refresh_token_obtained`, `refresh_token_expected_expiry`, `renewal_recommended`; drives the delegated form's OAuth panel.

`TokenRefreshController::refresh()` just calls `refresh()` and messages success (the service already logs/messages failures).

## Cron

`SymfonyMailerMsGraphHooks::cron()` (`#[Hook('cron')]`; legacy shim `symfony_mailer_ms_graph_cron()` in `.module`) calls `refresh()` only when `isRenewalDue()`, so the token endpoint is not hit every run.

## Supporting services (`*.services.yml`)

- `client_secret_resolver` (`ClientSecretResolver`) — resolves the Azure client secret from a Key entity by machine name (`key.repository`); throws `SymfonyMailerMsGraphException` if the ref is empty, unloadable, or resolves empty. The secret is never stored in config/State.
- `secret_cipher` (`SecretCipher`) — AES-256-CBC encrypt/decrypt for values persisted to State (refresh token, cached access tokens); key derived via `sha256(private_key . hash_salt)`, so the derived key is never stored.
- `delegated_transport_config` (`DelegatedTransportConfig`) — reads the fixed `microsoftgraph_delegated` entity's plugin configuration.
- `http_client` — a shared `Symfony\Component\HttpClient\HttpClient::create()` used for all token and Graph calls.

## Migration (1.x → 2.x)

`symfony_mailer_ms_graph_update_10001()` copies the old flat `symfony_mailer_ms_graph.settings` config (email/client/tenant/secret-key/renewal) onto the `microsoftgraph_delegated` transport entity, deletes the old config object, ensures both Key entities exist, and creates the Application transport. `update_10002()` shortens the Key descriptions to fit the 128-char limit.
