<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `login_gov` plugin — internals & extension points

One class: `Drupal\login_gov\Plugin\OpenIDConnectClient\OpenIDConnectLoginGovClient`
(`src/Plugin/OpenIDConnectClient/OpenIDConnectLoginGovClient.php`), a
`@OpenIDConnectClient(id = "login_gov", label = "Login.Gov")` extending
`OpenIDConnectClientBase`. It customizes an otherwise generic OIDC authorization-code flow for
Login.gov's requirements. There are **no services or routes** — the parent `openid_connect` module
owns the redirect/callback controller, the `state` CSRF check, and the account
creation/login. This plugin only overrides the protocol-specific pieces.

## Endpoints — `getEndpoints()` (`:173`)

Returns a sandbox or production endpoint set based on `sandbox_mode`:

- Sandbox host `idp.int.identitysandbox.gov`, production host `secure.login.gov`.
- Keys: `authorization` (`/openid_connect/authorize`), `token` (`/api/openid_connect/token`),
  `userinfo` (`/api/openid_connect/userinfo`), `end_session` (`/openid_connect/logout`),
  `certs` (`/api/openid_connect/certs` — Login.gov's JWKS).

## Authorization request — `getUrlOptions()` (`:309`)

Calls `parent::getUrlOptions()` (which sets `client_id`, `response_type=code`, `scope`,
`redirect_uri`, and the parent's **`state`** anti-CSRF token) then adds:

- `acr_values` from `generateAcrValue()`,
- a fresh `nonce` from `generateNonce()`,
- `prompt = select_account`.

The nonce is stashed in the session: `->getSession()->set('login_gov.nonce', $nonce)` for later
verification.

`generateAcrValue()` (`:278`) validates `ial_level`/`aal_level` against allow-lists (throws
`LoginGovConfigException` otherwise) and returns `urn:acr.login.gov:<ial_level>` space-joined with an
AAL URN from `$aal_map` (`duo` → `…:PasswordProtectedTransport:duo`, `separate` → `…/aal/2`,
`phishing_resistant` → `…/aal/2?phishing_resistant=true`, `require_hspd12` → `…/aal/2?hspd12=true`).

`generateNonce(int $length = 26)` (`:268`) → `substr(Crypt::randomBytesBase64($length), 0, $length)`.

## Token exchange — private-key JWT client assertion

`getRequestOptions($authorization_code, $redirect_uri)` (`:193`) overrides the parent so the token
POST authenticates with a **signed client assertion** instead of a `client_secret`:

- `client_assertion_payload`: `iss` = `sub` = `client_id`, `aud` = the token endpoint, `jti` = a
  nonce, `exp` = `time() + 300`.
- `signJwtPayload()` (`:229`) → `JWT::encode($payload, $this->getPrivateKey(), 'RS256')`.
- POST body (`form_params`): `client_assertion` (the signed JWT), `client_assertion_type` =
  `urn:ietf:params:oauth:client-assertion-type:jwt-bearer`, `code`, `grant_type=authorization_code`.

`getPrivateKey()` (`:239`) loads the configured `key_private_key` Key entity and returns its
`getKeyValue()`, falling back to the legacy inline `configuration['private_key']` (PEM) if no Key is
set.

The parent `OpenIDConnectClientBase::retrieveTokens()` performs the actual
`$httpClient->post($endpoints['token'], $request_options)` and decodes `id_token`/`access_token`/
`expire`/`refresh_token`. **TLS verification is left at Guzzle's default (enabled)** — no
`verify => false` anywhere in this module or the parent's token/userinfo calls.

## id_token nonce & signature — `retrieveTokens()` override (`:326`)

After `parent::retrieveTokens()` returns the token set, if an `id_token` is present:

1. `getPeerPublicKeys()` (`:252`) fetches `endpoints['certs']` over HTTP and `JWK::parseKeySet()`s
   the JWKS.
2. `JWT::decode($tokens['id_token'], $keys)` — `firebase/php-jwt` **verifies the RS256 signature**
   against Login.gov's published keys and throws on failure (an unhandled throw here aborts the
   callback with no login — fail-closed).
3. Compares the decoded `nonce` claim to the session `login_gov.nonce` set during the authorization
   request; on a mismatch it returns `NULL`, so the callback shows an error and no login occurs.

## Scopes — `getClientScopes()` (`:345`)

`$alwaysFetchFields` (`sub`, `email`, `ial`, `aal`) plus the configured `userinfo_fields`, mapped
through `$fieldToScopeMap` and de-duplicated, yields the scope list requested at authorization time.

## Logout — `alterLogoutRedirectionQuery()` (`:353`)

Removes `id_token_hint` from the end-session redirect query and adds `client_id` (Login.gov's logout
contract).

## Update hooks (`login_gov.install`)

- `login_gov_update_9001` — for every `openid_connect_client` config entity with `plugin == login_gov`
  that still has an inline `private_key`, creates a new `asymmetric_private` **Key** (via
  `key_asymmetric.key_pair::getKeyProperties()`), points `key_private_key` at it, and nulls the inline
  key.
- `login_gov_update_10001` — converts the legacy `acr_level` array (+ `require_piv`) into the current
  `ial_level` + `aal_level`, and nulls the removed `acr_level`/`verified_within*`/`force_reauth`/
  `require_piv` keys.

## Subclassing / debugging notes

- To point at a different IdP host or add PKCE, you'd override `getEndpoints()` / `getUrlOptions()` in
  a subclass — nothing here is configurable beyond the settings keys above.
- Logs go to the parent's channel `openid_connect_login_gov` (token/userinfo errors are logged there
  by `OpenIDConnectClientBase`).
- The full authorization URL (including `state`/`nonce`/`acr_values`, no `code`) is logged at **debug**
  level by the parent's `authorize()`.
